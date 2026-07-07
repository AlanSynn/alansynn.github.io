#!/usr/bin/env node
// video-clips.mjs — build-time pipeline: each paper/project video → small muted
// ~0-15s clip (lazy thumbnail). Output: public/video-clips/ + src/data/video-clips.json.
// Sources: papers.bib `video={}` + projects/*.md `video:` frontmatter.
// Idempotent (skips existing); skips YouTube if yt-dlp missing. Usage: node scripts/video-clips.mjs

import { createHash } from 'node:crypto';
import { existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { execSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const ROOT = resolve(fileURLToPath(import.meta.url), '..', '..');
const PUBLIC = join(ROOT, 'public');
const CLIP_DIR = join(PUBLIC, 'video-clips');
const BIB_PATH = join(ROOT, 'content', 'papers.bib');
const PROJECTS_DIR = join(ROOT, 'content', 'projects');
const MANIFEST_PATH = join(ROOT, 'src', 'data', 'video-clips.json');

const MAX_SECS = 15;
const POSTER_AT = 1.5; // poster frame timestamp (s)
const WIDTH = 480; // output width; height auto (-2 keeps even)
const CRF = 30; // high = small; 30 is aggressive but fine for thumbs
const PRESET = 'veryfast';
const PER_FILE_TIMEOUT_MS = 180_000;
const YOUTUBE_ID = /^[A-Za-z0-9_-]{11}$/;
const SIZE_BUDGET_BYTES = 800 * 1024; // soft per-clip target

function sha1(s) {
  return createHash('sha1').update(s).digest('hex');
}

function which(bin) {
  try {
    execSync(`command -v ${bin}`, { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

// Classify a source string into 'youtube' | 'direct'.
function classify(source) {
  if (/youtube\.com|youtu\.be/i.test(source)) return 'youtube';
  if (YOUTUBE_ID.test(source)) return 'youtube'; // bare 11-char id
  if (/^https?:\/\/.+\.(mp4)(\?.*)?$/i.test(source)) return 'direct';
  if (/^https?:\/\//i.test(source)) return 'direct'; // remote, non-mp4 — try anyway
  if (source.startsWith('/')) return 'direct'; // local public/ path
  return 'direct';
}

// youtube source (url or bare id) → canonical watch URL.
function youtubeUrl(source) {
  if (YOUTUBE_ID.test(source)) return `https://www.youtube.com/watch?v=${source}`;
  return source;
}

// 'direct' source → ffmpeg-readable input.
function resolveInput(source) {
  if (source.startsWith('/')) return join(PUBLIC, source); // local public asset
  return source; // remote URL
}

// run cmd: swallow output on success, surface on failure.
function run(cmd, timeoutMs = PER_FILE_TIMEOUT_MS) {
  try {
    execSync(cmd, { stdio: 'pipe', timeout: timeoutMs });
  } catch (e) {
    const stderr = (e.stderr && e.stderr.toString()) || '';
    const msg = stderr.trim() || e.message;
    throw new Error(msg.split('\n').slice(-8).join('\n'));
  }
}

function fmtSize(bytes) {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(2)} MB`;
}

// Minimal brace-aware bibtex extractor: citekey + video field per entry that has one.
// Doesn't reuse the main parser. @string/@comment skipped (no video field).
function discoverFromBib() {
  if (!existsSync(BIB_PATH)) return [];
  const text = readFileSync(BIB_PATH, 'utf8');
  const out = [];
  let i = 0;
  while (i < text.length) {
    const at = text.indexOf('@', i);
    if (at < 0) break;
    const typeMatch = text.slice(at).match(/^@(\w+)\s*\{/);
    if (!typeMatch) {
      i = at + 1;
      continue;
    }
    const openBrace = at + typeMatch[0].length - 1; // index of '{'
    // matching close brace via depth count
    let depth = 1;
    let j = openBrace + 1;
    while (j < text.length && depth > 0) {
      const c = text[j];
      if (c === '{') depth++;
      else if (c === '}') depth--;
      j++;
    }
    if (depth !== 0) break; // unbalanced bib — stop
    const inner = text.slice(openBrace + 1, j - 1);
    i = j;
    // citekey = up to first comma
    const comma = inner.indexOf(',');
    const citekey = (comma >= 0 ? inner.slice(0, comma) : inner).trim();
    if (!citekey) continue;
    const v = inner.match(/video\s*=\s*\{([^}]*)\}/i);
    if (v) {
      const source = v[1].trim();
      if (source) out.push({ source, ref: citekey, refKind: 'citekey' });
    }
  }
  return out;
}

// Parse projects/*.md frontmatter `video:` without a YAML dep (quoted + unquoted).
function discoverFromProjects() {
  if (!existsSync(PROJECTS_DIR)) return [];
  const out = [];
  const files = readdirSync(PROJECTS_DIR).filter((f) => f.endsWith('.md'));
  for (const f of files) {
    const text = readFileSync(join(PROJECTS_DIR, f), 'utf8');
    const fm = text.match(/^---\r?\n([\s\S]*?)\r?\n---/);
    if (!fm) continue;
    const v = fm[1].match(/^video:\s*["']?([^"'\n\r]+?)["']?\s*$/m);
    if (v) {
      const source = v[1].trim();
      if (source) out.push({ source, ref: f.replace(/\.md$/, ''), refKind: 'project' });
    }
  }
  return out;
}

function main() {
  mkdirSync(CLIP_DIR, { recursive: true });

  const hasFfmpeg = which('ffmpeg');
  if (!hasFfmpeg) {
    console.error('ffmpeg not found on PATH. Install ffmpeg before running this script.');
    process.exit(1);
  }
  const hasYtDlp = which('yt-dlp');

  // Dedupe by source (manifest keyed by source; paper + project sharing a video → one clip).
  const discovered = [...discoverFromBib(), ...discoverFromProjects()];
  const bySource = new Map();
  for (const d of discovered) {
    if (!bySource.has(d.source)) bySource.set(d.source, d);
  }
  const sources = [...bySource.values()];

  if (sources.length === 0) {
    console.log('video-clips: no video sources discovered. Writing empty manifest.');
    writeFileSync(MANIFEST_PATH, '{}\n');
    return;
  }

  console.log(
    `video-clips: ${sources.length} unique source(s). ffmpeg=ok, yt-dlp=${hasYtDlp ? 'ok' : 'MISSING'}`,
  );

  const manifest = {};
  const sizeRows = []; // {ref, source, kind, clipKB, posterKB, status}

  for (const { source, ref, refKind } of sources) {
    const id = sha1(source);
    const clipPath = join(CLIP_DIR, `${id}.mp4`);
    const posterPath = join(CLIP_DIR, `${id}.jpg`);
    const kind = classify(source);
    const clipUrl = `/video-clips/${id}.mp4`;
    const posterUrl = `/video-clips/${id}.jpg`;
    const tag = `${refKind}=${ref} <${source}>`;

    const cached = existsSync(clipPath) && existsSync(posterPath);
    if (cached) {
      manifest[source] = { id, clip: clipUrl, poster: posterUrl };
      sizeRows.push({
        ref,
        source,
        kind,
        tag,
        clipKB: statSync(clipPath).size,
        posterKB: statSync(posterPath).size,
        status: 'cached',
      });
      console.log(`  - cached   ${kind.padEnd(7)} ${tag}`);
      continue;
    }

    try {
      if (kind === 'youtube') {
        if (!hasYtDlp) {
          console.warn(`  ! skip     youtube  ${tag}  (yt-dlp not installed)`);
          sizeRows.push({
            ref,
            source,
            kind,
            tag,
            clipKB: 0,
            posterKB: 0,
            status: 'skipped:no-ytdlp',
          });
          continue;
        }
        const url = youtubeUrl(source);
        const cmd =
          `yt-dlp -f "worst[ext=mp4]/worst" --download-sections "*0-${MAX_SECS}" ` +
          `--force-keyframes-at-cuts -o - "${url}" | ` +
          `ffmpeg -y -i - -vf scale=${WIDTH}:-2 -an -c:v libx264 -crf ${CRF} ` +
          `-preset ${PRESET} -movflags +faststart "${clipPath}"`;
        run(cmd);
      } else {
        const input = resolveInput(source);
        if (source.startsWith('/') && !existsSync(input)) {
          throw new Error(`local video not found: ${input}`);
        }
        const cmd =
          `ffmpeg -y -ss 0 -t ${MAX_SECS} -i "${input}" -vf scale=${WIDTH}:-2 ` +
          `-an -c:v libx264 -crf ${CRF} -preset ${PRESET} -movflags +faststart "${clipPath}"`;
        run(cmd);
      }

      // Poster from the fresh clip (works for both kinds; avoids re-reading remote source).
      run(
        `ffmpeg -y -ss ${POSTER_AT} -i "${clipPath}" -frames:v 1 -vf scale=${WIDTH}:-2 "${posterPath}"`,
        60_000,
      );

      manifest[source] = { id, clip: clipUrl, poster: posterUrl };
      sizeRows.push({
        ref,
        source,
        kind,
        tag,
        clipKB: statSync(clipPath).size,
        posterKB: statSync(posterPath).size,
        status: 'generated',
      });
      console.log(`  + made     ${kind.padEnd(7)} ${tag}`);
    } catch (e) {
      const msg = String(e.message || e)
        .split('\n')
        .pop()
        .slice(0, 200);
      console.warn(`  ! failed   ${kind.padEnd(7)} ${tag}  (${msg})`);
      sizeRows.push({ ref, source, kind, tag, clipKB: 0, posterKB: 0, status: `failed:${msg}` });
    }
  }

  // Manifest rebuilt from scratch each run → removed videos drop out naturally.
  writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2) + '\n');

  console.log('\nvideo-clips: size summary');
  let totalClip = 0;
  let totalPoster = 0;
  for (const r of sizeRows) {
    totalClip += r.clipKB;
    totalPoster += r.posterKB;
    const overBudget = r.clipKB > SIZE_BUDGET_BYTES ? '  (over 800KB budget!)' : '';
    if (r.status === 'generated' || r.status === 'cached') {
      console.log(
        `    ${r.status.padEnd(9)} ${r.kind.padEnd(7)} ${fmtSize(r.clipKB).padStart(9)} clip + ` +
          `${fmtSize(r.posterKB).padStart(8)} poster   ${r.tag}${overBudget}`,
      );
    }
  }
  console.log(
    `    ${'TOTAL'.padEnd(9)} ${' '.repeat(7)} ${fmtSize(totalClip).padStart(9)} clip + ${fmtSize(totalPoster).padStart(8)} poster   (${sizeRows.filter((r) => r.status === 'generated' || r.status === 'cached').length} clip(s))`,
  );

  const skipped = sizeRows.filter(
    (r) => r.status.startsWith('skipped') || r.status.startsWith('failed'),
  );
  if (skipped.length) {
    console.log(`  ! ${skipped.length} source(s) not processed:`);
    for (const r of skipped) console.log(`      - ${r.tag}  [${r.status}]`);
  }
  console.log(
    `video-clips: manifest -> ${MANIFEST_PATH} (${Object.keys(manifest).length} entries)`,
  );
}

main();
