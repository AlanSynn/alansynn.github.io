#!/usr/bin/env node
// gen-og-svg.mjs — emit public/og.svg, the site-default Open Graph image.
//
// A FROZEN IK FRAME of the two mechanism motifs: the ARM rising flush from the
// bottom edge and the LEGS hanging flush from the top edge, each in its UPRIGHT
// rest pose with the JOINTS BENT via IK so the hand and the feet reach toward
// the center and almost touch — the look of the live site's RobotIK engine with
// a cursor dragged to center, stopped mid-reach.
//
// The bend lives in the JOINTS (shoulder/elbow/wrist, hip/knee/ankle), NOT in a
// whole-figure rotation: each motif's outer group is translate+scale only (local
// orientation == canvas orientation), so angles solved in canvas space apply
// directly to the local rotate() pivots. Arm base + legs pelvis sit ON the canvas
// edges (no margin — they poke out, emerging from the frame).
//
// IK is the SAME closed-form solver as src/lib/ik.ts (ported here verbatim — pure
// math, no DOM, y-down, +angle = clockwise = SVG rotate(+deg)). One frame, so the
// port stays in sync trivially. Run, look, tweak the PLACEMENT / TARGET constants,
// re-run:
//
//   node scripts/gen-og-svg.mjs                 # → public/og.svg
//   rsvg-convert -w 1200 -h 630 public/og.svg -o public/og.png
import { writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

// ─── IK (ported from src/lib/ik.ts — keep in sync) ──────────────────────────
const clamp = (x, lo, hi) => Math.max(lo, Math.min(hi, x));
const rotN = (x, y, ang, out) => {
  const c = Math.cos(ang),
    s = Math.sin(ang);
  out.x = x * c - y * s;
  out.y = x * s + y * c;
};
// 2-link root--l1-->mid--l2-->tip; returns a1 (abs @ root) + a2 (rel @ mid).
function ik2(root, target, l1, l2, elbowSign = 1) {
  const dx = target.x - root.x,
    dy = target.y - root.y;
  const D2 = dx * dx + dy * dy;
  const cos_t2 = clamp((D2 - l1 * l1 - l2 * l2) / (2 * l1 * l2), -1, 1);
  const a2 = elbowSign * Math.acos(cos_t2);
  const a1 = Math.atan2(dy, dx) - Math.atan2(l2 * Math.sin(a2), l1 + l2 * Math.cos(a2));
  return { a1, a2 };
}
function fk2(root, a1, a2, l1, l2) {
  const _s = { x: 0, y: 0 };
  rotN(l1, 0, a1, _s);
  const mid = { x: root.x + _s.x, y: root.y + _s.y };
  rotN(l2, 0, a1 + a2, _s);
  return { mid, tip: { x: mid.x + _s.x, y: mid.y + _s.y } };
}
function ik2Pole(root, target, l1, l2, pole) {
  const s1 = ik2(root, target, l1, l2, 1);
  const s2 = ik2(root, target, l1, l2, -1);
  const m1 = fk2(root, s1.a1, s1.a2, l1, l2).mid;
  const m2 = fk2(root, s2.a1, s2.a2, l1, l2).mid;
  const d1 = (m1.x - pole.x) ** 2 + (m1.y - pole.y) ** 2;
  const d2 = (m2.x - pole.x) ** 2 + (m2.y - pole.y) ** 2;
  return d1 <= d2 ? { ...s1, mid: m1 } : { ...s2, mid: m2 };
}
// 3-link hip--l1-->knee--l2-->ankle + foot@footAng (world dir). {hip,knee,ankle}
// all such that ankleAbs = hip+knee+ankle = footAng. kneePole picks the fold side.
function ikLegPole(hip, footTip, l1, l2, lFoot, footAng, kneePole) {
  const _s = { x: 0, y: 0 };
  rotN(lFoot, 0, footAng, _s);
  const ankle = { x: footTip.x - _s.x, y: footTip.y - _s.y };
  const r = ik2Pole(hip, ankle, l1, l2, kneePole);
  return { hip: r.a1, knee: r.a2, ankle: footAng - (r.a1 + r.a2), anklePos: ankle };
}
const deg = (rad) => (rad * 180) / Math.PI;
// rotate() string for a joint: (absAng - rest) in degrees, pivot in LOCAL coords.
const j = (absAng, rest, px, py) => `rotate(${deg(absAng - rest).toFixed(2)} ${px} ${py})`;

// ─── Canvas + motifs ────────────────────────────────────────────────────────
const W = 1200,
  H = 630;

// ARM (viewBox 180×360; shoulder (90,340); l1=95→elbow(90,245); l2=88→wrist(90,157);
// lHand=33→hand-tip(90,124). Links drawn −Y, rest shoulder abs = −π/2.)
const ARM = { l1: 95, l2: 88, lHand: 33, shoulder: { x: 90, y: 340 }, restShoulder: -Math.PI / 2 };
// LEGS (viewBox 140×260; hips (50,10)+(90,10); l1=92→knee y102; l2=86→ankle y188; lFoot=22.)
const LEG = {
  l1: 92,
  l2: 86,
  lFoot: 22,
  hips: [
    { x: 50, y: 10 },
    { x: 90, y: 10 },
  ],
  restHip: Math.PI / 2,
};

// Finger table (hand-local). `grab` is a 0..1 curl gradation across the hand:
// RIGHTMOST finger (f-r) curls most, LEFTMOST (f-t/thumb) stays fully extended —
// only the outer 1-2 fingers fold, easing out to a straight finger (a reaching
// hand, not a fist). PIP/DIP/MCP interpolate from straight (grab 0) to full curl.
const FINGERS = [
  {
    cls: 'f-t',
    mcp: { x: 78, y: 150 },
    pip: { x: 78, y: 138 },
    dip: { x: 78, y: 128 },
    tip: { x: 78, y: 120 },
    splay: -29,
    grab: 0,
  },
  {
    cls: 'f-i',
    mcp: { x: 88, y: 146 },
    pip: { x: 88, y: 132 },
    dip: { x: 88, y: 120 },
    tip: { x: 88, y: 111 },
    splay: -9,
    grab: 0.3,
  },
  {
    cls: 'f-m',
    mcp: { x: 98, y: 145 },
    pip: { x: 98, y: 130 },
    dip: { x: 98, y: 118 },
    tip: { x: 98, y: 108 },
    splay: 0,
    grab: 0.65,
  },
  {
    cls: 'f-r',
    mcp: { x: 108, y: 147 },
    pip: { x: 108, y: 133 },
    dip: { x: 108, y: 122 },
    tip: { x: 108, y: 113 },
    splay: 9,
    grab: 1,
  },
];
const lerp = (a, b, t) => a + (b - a) * t;
const GRAB_MCP_FLEX = 15; // max MCP drop at full curl
const PIP_BASE = 8,
  PIP_GRAB = 82,
  DIP_BASE = 6,
  DIP_GRAB = 58;

// ─── PLACEMENT + IK TARGETS (tweak these, re-run) ───────────────────────────
// ARM: base flush at the BOTTOM edge at horizontal 1/5 (poking out), upright,
// reaching up-right. Handtip targets 2/5 — reaches partway, NOT to center.
const ARM_S = 2.0;
const ARM_SHOULDER_X = W / 5; // 1/5 across → 240
const ARM_MOUNTBASE_Y = H + 6; // mount base line: 6px past bottom → emerges from edge
const ARM_TX = ARM_SHOULDER_X - ARM.shoulder.x * ARM_S;
const ARM_TY = ARM_MOUNTBASE_Y - 346 * ARM_S; // 346 = local y of mount base line
const ARM_WRIST_TARGET = { x: (W * 2) / 5, y: 330 }; // handtip → 2/5 (480)
const ARM_HAND_DIR = -Math.PI / 2 + 0.6; // hand points up, tilted toward the feet (clockwise)
const ARM_ELBOW_POLE = { x: ARM_SHOULDER_X + 80, y: ARM_MOUNTBASE_Y - 170 }; // elbow folds right

// LEGS: pelvis flush at the TOP edge at horizontal 4/5 (poking out), upright,
// reaching down-left. Feet target 3/5 — reaches partway, NOT to center.
const LEG_S = 2.2;
const LEG_PELVIS_X = (W * 4) / 5; // 4/5 across → 960
const LEG_PELVIS_TOP_Y = -6; // pelvis top: 6px past top → emerges from edge
const LEG_TX = LEG_PELVIS_X - 70 * LEG_S; // 70 = local pelvis center x
const LEG_TY = LEG_PELVIS_TOP_Y - 3 * LEG_S; // 3 = local y of pelvis top
// Two feet target ~3/5 with both horizontal splay AND vertical offset between
// left/right leg (one foot lower, one higher) — a stepping asymmetry.
const LEG_FOOT_TARGETS = [
  { x: 690, y: 358 }, // leg0 (left hip): lower foot
  { x: 755, y: 298 }, // leg1 (right hip): higher foot
];
const LEG_FOOT_ANGS = [Math.PI / 2 - 0.08, Math.PI / 2 + 0.05]; // per-leg foot dir (slight toe-out/in)
const LEG_KNEE_POLES = [
  { dx: -18 * LEG_S, dy: 52 * LEG_S }, // leg0: standard fold
  { dx: -24 * LEG_S, dy: 46 * LEG_S }, // leg1: a touch more bend, different height
];
const LEG_KNEE_POLE_DX = -18 * LEG_S; // knee bends LEFT (toward center)
const LEG_KNEE_POLE_DY = 52 * LEG_S;

// Forward kinematics in canvas space (scaled links) — verification geometry.
function fkLeg(hip, hipA, kneeA, ankleA, l1, l2, lFoot) {
  const _ = (len, ang) => {
    const o = { x: 0, y: 0 };
    rotN(len, 0, ang, o);
    return o;
  };
  const k = _(l1, hipA);
  const knee = { x: hip.x + k.x, y: hip.y + k.y };
  const a = _(l2, hipA + kneeA);
  const ankle = { x: knee.x + a.x, y: knee.y + a.y };
  const t = _(lFoot, hipA + kneeA + ankleA);
  return { knee, ankle, toe: { x: ankle.x + t.x, y: ankle.y + t.y } };
}

// ─── Solve ──────────────────────────────────────────────────────────────────
// Canvas-space solve: link lengths scale with the group, pivot = shoulder canvas pos.
const armShoulderC = { x: ARM_TX + ARM.shoulder.x * ARM_S, y: ARM_TY + ARM.shoulder.y * ARM_S };
const arm = ikLegPole(
  armShoulderC,
  ARM_WRIST_TARGET,
  ARM.l1 * ARM_S,
  ARM.l2 * ARM_S,
  ARM.lHand * ARM_S,
  ARM_HAND_DIR,
  ARM_ELBOW_POLE,
);
const legs = LEG.hips.map((hipLocal, i) => {
  const hipC = { x: LEG_TX + hipLocal.x * LEG_S, y: LEG_TY + hipLocal.y * LEG_S };
  const kp = LEG_KNEE_POLES[i];
  const kneePole = { x: hipC.x + kp.dx, y: hipC.y + kp.dy };
  return ikLegPole(
    hipC,
    LEG_FOOT_TARGETS[i],
    LEG.l1 * LEG_S,
    LEG.l2 * LEG_S,
    LEG.lFoot * LEG_S,
    LEG_FOOT_ANGS[i],
    kneePole,
  );
});

// ─── Markup builders (joint pivots in LOCAL coords) ─────────────────────────
const armSvg = () => `
    <line class="ra-mount" x1="56" y1="346" x2="124" y2="346" />
    <line class="ra-mount" x1="72" y1="340" x2="108" y2="340" />
    <rect class="ra-mount" x="84" y="337" width="12" height="9" rx="1.5" />
    <g class="j-shoulder" transform="${j(arm.hip, ARM.restShoulder, 90, 340)}">
      <line class="ra-link" x1="90" y1="340" x2="90" y2="245" />
      <line class="ra-tendon" x1="86" y1="334" x2="86" y2="251" />
      <line class="ra-tendon" x1="94" y1="334" x2="94" y2="251" />
      <circle class="ra-joint" cx="90" cy="340" r="4.4" />
      <circle class="ra-joint" cx="90" cy="245" r="3.8" />
      <g class="j-elbow" transform="${j(arm.knee, 0, 90, 245)}">
        <line class="ra-link" x1="90" y1="245" x2="90" y2="157" />
        <line class="ra-tendon" x1="86" y1="239" x2="86" y2="163" />
        <line class="ra-tendon" x1="94" y1="239" x2="94" y2="163" />
        <circle class="ra-joint" cx="90" cy="157" r="3.6" />
        <g class="j-wrist" transform="${j(arm.ankle, 0, 90, 157)}">
          <g class="hand">
            <path class="ra-palm" d="M 70 158 Q 68 148 78 146 L 100 145 Q 112 147 114 158 Q 92 163 70 158 Z" />
${FINGERS.map(
  (f) =>
    `            <g class="${f.cls}"><g class="j-mcp" transform="${j(((f.splay + GRAB_MCP_FLEX * f.grab) * Math.PI) / 180, 0, f.mcp.x, f.mcp.y)}"><line class="ra-link" x1="${f.mcp.x}" y1="${f.mcp.y}" x2="${f.pip.x}" y2="${f.pip.y}" /><circle class="ra-knuckle" cx="${f.mcp.x}" cy="${f.mcp.y}" r="2.4" /><g class="j-pip" transform="${j((lerp(PIP_BASE, PIP_GRAB, f.grab) * Math.PI) / 180, 0, f.pip.x, f.pip.y)}"><line class="ra-link" x1="${f.pip.x}" y1="${f.pip.y}" x2="${f.dip.x}" y2="${f.dip.y}" /><circle class="ra-joint" cx="${f.pip.x}" cy="${f.pip.y}" r="2.1" /><g class="j-dip" transform="${j((lerp(DIP_BASE, DIP_GRAB, f.grab) * Math.PI) / 180, 0, f.dip.x, f.dip.y)}"><line class="ra-link" x1="${f.dip.x}" y1="${f.dip.y}" x2="${f.tip.x}" y2="${f.tip.y}" /><circle class="ra-tip" cx="${f.tip.x}" cy="${f.tip.y}" r="2.1" /></g></g></g></g>`,
).join('\n')}
          </g>
        </g>
      </g>
    </g>`;

const legSvg = (i) => {
  const hx = LEG.hips[i].x;
  const kneeY = 102,
    ankleY = 188;
  const sol = legs[i];
  return `    <g class="leg">
      <g class="j-hip" transform="${j(sol.hip, LEG.restHip, hx, 10)}">
        <line class="rl-link" x1="${hx}" y1="10" x2="${hx}" y2="${kneeY}" />
        <line class="rl-tendon" x1="${hx - 3.5}" y1="14" x2="${hx - 3.5}" y2="${kneeY - 4}" />
        <line class="rl-tendon" x1="${hx + 3.5}" y1="14" x2="${hx + 3.5}" y2="${kneeY - 4}" />
        <circle class="rl-joint" cx="${hx}" cy="10" r="4.4" />
        <g class="j-knee" transform="${j(sol.knee, 0, hx, kneeY)}">
          <line class="rl-link" x1="${hx}" y1="${kneeY}" x2="${hx}" y2="${ankleY}" />
          <line class="rl-tendon" x1="${hx - 3.5}" y1="${kneeY + 4}" x2="${hx - 3.5}" y2="${ankleY - 4}" />
          <line class="rl-tendon" x1="${hx + 3.5}" y1="${kneeY + 4}" x2="${hx + 3.5}" y2="${ankleY - 4}" />
          <circle class="rl-joint" cx="${hx}" cy="${kneeY}" r="3.8" />
          <g class="j-ankle" transform="${j(sol.ankle, 0, hx, ankleY)}">
            <path class="rl-foot" d="M ${hx - 3} ${ankleY} L ${hx - 4} ${ankleY + 8} Q ${hx - 4} ${ankleY + 18} ${hx} ${ankleY + 20} Q ${hx + 4} ${ankleY + 18} ${hx + 4} ${ankleY + 8} L ${hx + 3} ${ankleY} Z" />
            <circle class="rl-heel" cx="${hx}" cy="${ankleY + 15}" r="1.5" />
          </g>
        </g>
      </g>
    </g>`;
};

// ─── Assemble ───────────────────────────────────────────────────────────────
const svg = `<?xml version="1.0" encoding="UTF-8"?>
<!--
  Site-default Open Graph image (${W}x${H}). A frozen IK frame of the two mechanism
  motifs: ARM rising flush from the bottom edge, LEGS hanging flush from the top
  edge — upright rest pose with the joints IK-bent so the hand and the feet reach
  toward the center and almost touch (cursor-dragged-to-center, stopped mid-reach).
  Generated by scripts/gen-og-svg.mjs (same IK as src/lib/ik.ts). Crawlers don't
  render SVG → rasterized to og.png by rsvg-convert. Edit the script, not this file.
-->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" width="${W}" height="${H}" color="#1d4e89">
  <defs>
    <pattern id="grid" width="40" height="40" patternUnits="userSpaceOnUse">
      <path d="M 40 0 L 0 0 0 40" fill="none" stroke="#1d4e89" stroke-width="1" stroke-opacity="0.12" />
    </pattern>
  </defs>

  <style>
    .ra-link, .rl-link { stroke: currentColor; stroke-width: 1.7; stroke-linecap: round; fill: none; }
    .ra-tendon, .rl-tendon { stroke: currentColor; stroke-width: 0.85; stroke-linecap: round; stroke-dasharray: 2 3; fill: none; opacity: 0.5; }
    .ra-joint, .ra-knuckle, .rl-joint, .rl-pelvis-dot, .rl-heel { fill: currentColor; }
    .ra-tip { fill: rgba(29,78,137,0.18); stroke: currentColor; stroke-width: 1; }
    .ra-mount { stroke: currentColor; stroke-width: 1.7; stroke-linecap: round; fill: rgba(29,78,137,0.18); opacity: 0.75; }
    .ra-palm { fill: rgba(29,78,137,0.18); stroke: currentColor; stroke-width: 1.6; stroke-linejoin: round; opacity: 0.85; }
    .rl-pelvis { fill: rgba(29,78,137,0.18); stroke: currentColor; stroke-width: 1.6; stroke-linejoin: round; }
    .rl-foot { fill: rgba(29,78,137,0.18); stroke: currentColor; stroke-width: 1.3; stroke-linejoin: round; }
  </style>

  <rect width="${W}" height="${H}" fill="#ffffff" />
  <rect width="${W}" height="${H}" fill="url(#grid)" />

  <!-- ARM: base flush at the bottom edge, upright, IK-bent reaching up to center. -->
  <g transform="translate(${ARM_TX.toFixed(2)} ${ARM_TY.toFixed(2)}) scale(${ARM_S})">${armSvg()}
  </g>

  <!-- LEGS: pelvis flush at the top edge, upright, IK-bent reaching down to center. -->
  <g transform="translate(${LEG_TX.toFixed(2)} ${LEG_TY.toFixed(2)}) scale(${LEG_S})">
    <path class="rl-pelvis" d="M 32 10 Q 32 3 39 3 L 101 3 Q 108 3 108 10 Q 108 17 101 17 L 39 17 Q 32 17 32 10 Z" />
    <circle class="rl-pelvis-dot" cx="70" cy="10" r="2.6" />
${legSvg(0)}
${legSvg(1)}
  </g>
</svg>
`;

const out = join(dirname(fileURLToPath(import.meta.url)), '..', 'public', 'og.svg');
writeFileSync(out, svg);
console.log(`wrote ${out} (${svg.length} bytes)`);
console.log(
  'arm  shoulderC',
  armShoulderC,
  '→ wrist',
  ARM_WRIST_TARGET,
  'elbowPole',
  ARM_ELBOW_POLE,
);
console.log(
  'arm  angles deg: shoulder',
  deg(arm.hip - ARM.restShoulder).toFixed(1),
  'elbow',
  deg(arm.knee).toFixed(1),
  'wrist',
  deg(arm.ankle).toFixed(1),
);
legs.forEach((s, i) =>
  console.log(
    `leg${i} angles deg: hip`,
    deg(s.hip - LEG.restHip).toFixed(1),
    'knee',
    deg(s.knee).toFixed(1),
    'ankle',
    deg(s.ankle).toFixed(1),
    '← target',
    LEG_FOOT_TARGETS[i],
  ),
);

// ─── Canvas FK positions (verification: where each joint/toe actually lands) ─
const afk = fkLeg(
  armShoulderC,
  arm.hip,
  arm.knee,
  arm.ankle,
  ARM.l1 * ARM_S,
  ARM.l2 * ARM_S,
  ARM.lHand * ARM_S,
);
console.log(
  '\nARM canvas: shoulder',
  armShoulderC,
  'elbow',
  afk.knee,
  'wrist',
  afk.ankle,
  'handtip',
  afk.toe,
);
console.log('  handtip vs nearest foot gap:');
legs.forEach((s, i) => {
  const fk = fkLeg(
    { x: LEG_TX + LEG.hips[i].x * LEG_S, y: LEG_TY + LEG.hips[i].y * LEG_S },
    s.hip,
    s.knee,
    s.ankle,
    LEG.l1 * LEG_S,
    LEG.l2 * LEG_S,
    LEG.lFoot * LEG_S,
  );
  const d = Math.hypot(afk.toe.x - fk.toe.x, afk.toe.y - fk.toe.y);
  console.log(
    `  leg${i}: knee`,
    fk.knee,
    'ankle',
    fk.ankle,
    'toe(foot)',
    fk.toe,
    '→ gap-to-handtip',
    d.toFixed(1) + 'px',
  );
});
console.log('\ncanvas', W + 'x' + H, 'center (600,315)');
