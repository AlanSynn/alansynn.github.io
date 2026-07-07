// ik.ts — closed-form inverse kinematics for the mechanism motifs. Pure math,
// no DOM. Angles in radians; coords are SVG user units (y-down). Standard matrix
// rotation: +angle reads clockwise on screen (y-down), maps 1:1 to SVG rotate(+deg).
//
// PERF: the per-frame hot path (one rAF, ~7 solves) is allocation-bound — every
// vector op used to allocate a fresh {x,y}. The composite solvers below now write
// internal temporaries into module-scope `_s[]` scratch and return FRESH result
// objects, so callers can hold several results without aliasing. Scratch safety:
// each fn reads `_s` into a fresh local BEFORE any sub-call, and the call tree is
// non-recursive (ik2 → scalar; fk2 → rotN only; ik2Pole → ik2+fk2 sequentially).
// So `_s` is never observed stale. Leaf exports (V/add/sub/rot/len/dist) stay
// allocating for cold/external use; robot-ik.ts still imports V/add/sub.

export type V2 = { x: number; y: number };

export const V = (x: number, y: number): V2 => ({ x, y });
export const add = (a: V2, b: V2): V2 => ({ x: a.x + b.x, y: a.y + b.y });
export const sub = (a: V2, b: V2): V2 => ({ x: a.x - b.x, y: a.y - b.y });
export const len = (a: V2): number => Math.hypot(a.x, a.y);
export const dist = (a: V2, b: V2): number => len(sub(a, b));
export const clamp = (x: number, lo: number, hi: number): number => Math.max(lo, Math.min(hi, x));

// Rotate vector `a` by `ang` radians (standard matrix).
export const rot = (a: V2, ang: number): V2 => {
  const c = Math.cos(ang),
    s = Math.sin(ang);
  return { x: a.x * c - a.y * s, y: a.x * s + a.y * c };
};

// RULE: never return `_s`; never hold a `_s`-derived ref across a rotN/sub-call.
// Each consumer reads `_s` into a fresh local before the next rotN — that's the
// whole safety contract (the call tree is non-recursive, see header).
const _s: V2 = { x: 0, y: 0 };
// raw rotate of (x,y) by ang into `out` — skips the V(...) alloc that rot() pays.
// returns void on purpose: forces callers to read `out` (here `_s`) into a fresh
// local, so a `const v = rotN(...)` capture CAN'T alias `_s` (the rotN trap).
const rotN = (x: number, y: number, ang: number, out: V2): void => {
  const c = Math.cos(ang),
    s = Math.sin(ang);
  out.x = x * c - y * s;
  out.y = x * s + y * c;
};

// 2-link IK: root --l1--> mid --l2--> tip, solve so tip ≡ target. Returns a1
// (absolute at root) + a2 (relative at mid). elbowSign picks the fold side.
// In-reach targets reach exactly; out-of-reach clamp cos→±1 (chain extends straight).
export function ik2(root: V2, target: V2, l1: number, l2: number, elbowSign = 1) {
  const dx = target.x - root.x,
    dy = target.y - root.y;
  const D2 = dx * dx + dy * dy;
  const cos_t2 = clamp((D2 - l1 * l1 - l2 * l2) / (2 * l1 * l2), -1, 1);
  const a2 = elbowSign * Math.acos(cos_t2);
  const a1 = Math.atan2(dy, dx) - Math.atan2(l2 * Math.sin(a2), l1 + l2 * Math.cos(a2));
  return { a1, a2 };
}

// Forward 2-link: mid + tip positions from root + angles (verification helper).
export function fk2(root: V2, a1: number, a2: number, l1: number, l2: number) {
  rotN(l1, 0, a1, _s);
  const mid: V2 = { x: root.x + _s.x, y: root.y + _s.y };
  rotN(l2, 0, a1 + a2, _s);
  const tip: V2 = { x: mid.x + _s.x, y: mid.y + _s.y };
  return { mid, tip };
}

// 2-link IK with a pole vector: solves both elbow signs, returns the one whose mid
// lies nearest `pole`. Lets a mid-joint be dragged (grab elbow/knee → chain follows
// while the tip still tracks its own target). Ties break toward `pole`'s side.
// PERF: compare squared distance (monotonic with dist for d≥0) → drops 2 sub allocs
// + 2 Math.hypot per call. Self-consistent: both sides use distSq.
export function ik2Pole(root: V2, target: V2, l1: number, l2: number, pole: V2) {
  const s1 = ik2(root, target, l1, l2, 1);
  const s2 = ik2(root, target, l1, l2, -1);
  const m1 = fk2(root, s1.a1, s1.a2, l1, l2).mid;
  const m2 = fk2(root, s2.a1, s2.a2, l1, l2).mid;
  const d1x = m1.x - pole.x,
    d1y = m1.y - pole.y;
  const d2x = m2.x - pole.x,
    d2y = m2.y - pole.y;
  return d1x * d1x + d1y * d1y <= d2x * d2x + d2y * d2y ? { ...s1, mid: m1 } : { ...s2, mid: m2 };
}

// 3-link leg IK with a foot-direction constraint: hip --l1--> knee --l2--> ankle,
// then foot of length lFoot whose WORLD direction is `footAng`. Solves hip+knee as
// 2-link to the ankle, then sets the ankle so the foot points at footAng. Returns
// absolute hip, relative knee, relative ankle.
export function ikLeg(
  hip: V2,
  footTip: V2,
  l1: number,
  l2: number,
  lFoot: number,
  footAng: number,
  kneeSign = 1,
) {
  rotN(lFoot, 0, footAng, _s);
  const ankle: V2 = { x: footTip.x - _s.x, y: footTip.y - _s.y };
  const { a1, a2 } = ik2(hip, ankle, l1, l2, kneeSign);
  return { hip: a1, knee: a2, ankle: footAng - (a1 + a2), anklePos: ankle };
}

// 3-link leg IK with a knee POLE (drag the knee to set bend direction).
export function ikLegPole(
  hip: V2,
  footTip: V2,
  l1: number,
  l2: number,
  lFoot: number,
  footAng: number,
  kneePole: V2,
) {
  rotN(lFoot, 0, footAng, _s);
  const ankle: V2 = { x: footTip.x - _s.x, y: footTip.y - _s.y };
  const r = ik2Pole(hip, ankle, l1, l2, kneePole);
  return { hip: r.a1, knee: r.a2, ankle: footAng - (r.a1 + r.a2), anklePos: ankle };
}

// Forward leg (verification).
export function fkLeg(
  hip: V2,
  hipA: number,
  kneeA: number,
  ankleA: number,
  l1: number,
  l2: number,
  lFoot: number,
) {
  rotN(l1, 0, hipA, _s);
  const knee: V2 = { x: hip.x + _s.x, y: hip.y + _s.y };
  rotN(l2, 0, hipA + kneeA, _s);
  const ankle: V2 = { x: knee.x + _s.x, y: knee.y + _s.y };
  rotN(lFoot, 0, hipA + kneeA + ankleA, _s);
  const toe: V2 = { x: ankle.x + _s.x, y: ankle.y + _s.y };
  return { knee, ankle, toe };
}

// Gait foot target for one leg. `phase` advances with scroll + idle time; two legs
// offset by π alternate steps. y-down: stance extends the foot down, lift raises it.
export function gaitFoot(hip: V2, phase: number, stride: number, stance: number, lift: number): V2 {
  const sp = Math.sin(phase); // memoized: reused for stride + lift-swing
  return { x: hip.x + stride * sp, y: hip.y + stance - lift * (sp > 0 ? sp : 0) };
}
