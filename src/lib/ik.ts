// ik.ts — closed-form inverse kinematics for the mechanism motifs.
// Pure math, no DOM. Angles in radians; coordinates are SVG user units (y-down).
// Rotation uses the standard matrix; with y-down coords a positive angle reads
// clockwise on screen, matching SVG `rotate(+deg)`, so solver output maps 1:1
// to the transform attribute the engine writes onto each joint group.

export type V2 = { x: number; y: number };

export const V = (x: number, y: number): V2 => ({ x, y });
export const add = (a: V2, b: V2): V2 => ({ x: a.x + b.x, y: a.y + b.y });
export const sub = (a: V2, b: V2): V2 => ({ x: a.x - b.x, y: a.y - b.y });
export const mul = (a: V2, s: number): V2 => ({ x: a.x * s, y: a.y * s });
export const len = (a: V2): number => Math.hypot(a.x, a.y);
export const dist = (a: V2, b: V2): number => len(sub(a, b));
export const clamp = (x: number, lo: number, hi: number): number =>
  Math.max(lo, Math.min(hi, x));
export const TAU = Math.PI * 2;

// Rotate vector `a` by `ang` radians (standard matrix).
export const rot = (a: V2, ang: number): V2 => {
  const c = Math.cos(ang), s = Math.sin(ang);
  return { x: a.x * c - a.y * s, y: a.x * s + a.y * c };
};

// 2-link IK: root --l1--> mid --l2--> tip, solve so tip ≡ target.
// Returns a1 (absolute angle at root) and a2 (relative angle at mid).
// elbowSign ∈ {-1,+1} picks which side the mid joint folds toward. Canonical
// closed form — FK with (a1, a1+a2) reaches `target` exactly for in-reach
// targets; out-of-reach targets clamp cos to ±1 and the chain extends straight.
export function ik2(root: V2, target: V2, l1: number, l2: number, elbowSign = 1) {
  const dx = target.x - root.x, dy = target.y - root.y;
  const D2 = dx * dx + dy * dy;
  const cos_t2 = clamp((D2 - l1 * l1 - l2 * l2) / (2 * l1 * l2), -1, 1);
  const a2 = elbowSign * Math.acos(cos_t2);
  const a1 = Math.atan2(dy, dx) - Math.atan2(l2 * Math.sin(a2), l1 + l2 * Math.cos(a2));
  return { a1, a2 };
}

// Forward 2-link: positions of mid + tip from root + angles (verification helper).
export function fk2(root: V2, a1: number, a2: number, l1: number, l2: number) {
  const mid = add(root, rot(V(l1, 0), a1));
  const tip = add(mid, rot(V(l2, 0), a1 + a2));
  return { mid, tip };
}

// 2-link IK with a pole vector: solves both elbow signs and returns the one
// whose mid (elbow/knee) lies nearest `pole`. This is what makes a mid-joint
// draggable — grab the elbow/knee handle, drag it, and the chain bends to
// follow while the tip still tracks its own target. For a target exactly on the
// root–pole line both mids are equidistant; we break ties toward `pole`'s side.
export function ik2Pole(root: V2, target: V2, l1: number, l2: number, pole: V2) {
  const s1 = ik2(root, target, l1, l2, 1);
  const s2 = ik2(root, target, l1, l2, -1);
  const m1 = fk2(root, s1.a1, s1.a2, l1, l2).mid;
  const m2 = fk2(root, s2.a1, s2.a2, l1, l2).mid;
  const d1 = dist(m1, pole);
  const d2 = dist(m2, pole);
  return d1 <= d2 ? { ...s1, mid: m1 } : { ...s2, mid: m2 };
}

// 3-link leg IK with a foot-direction constraint:
// hip --l1--> knee --l2--> ankle, then a foot of length lFoot whose WORLD
// direction is `footAng`. Solves hip+knee as a 2-link to the ankle position,
// then sets the ankle joint so the foot points at footAng. Returns absolute
// hip, relative knee, relative ankle (apply as nested group rotates).
export function ikLeg(
  hip: V2, footTip: V2, l1: number, l2: number, lFoot: number,
  footAng: number, kneeSign = 1,
) {
  const ankle = sub(footTip, rot(V(lFoot, 0), footAng));
  const { a1, a2 } = ik2(hip, ankle, l1, l2, kneeSign);
  const shinAbs = a1 + a2;
  const ankleRel = footAng - shinAbs;     // foot world dir = shinAbs + ankleRel = footAng
  return { hip: a1, knee: a2, ankle: ankleRel, anklePos: ankle };
}

// 3-link leg IK with a knee POLE (drag the knee to set bend direction).
// Like ikLeg but the knee folds toward `kneePole` instead of a fixed sign.
export function ikLegPole(
  hip: V2, footTip: V2, l1: number, l2: number, lFoot: number,
  footAng: number, kneePole: V2,
) {
  const ankle = sub(footTip, rot(V(lFoot, 0), footAng));
  const { a1, a2 } = ik2Pole(hip, ankle, l1, l2, kneePole);
  const shinAbs = a1 + a2;
  const ankleRel = footAng - shinAbs;
  return { hip: a1, knee: a2, ankle: ankleRel, anklePos: ankle };
}

// Forward leg (verification).
export function fkLeg(
  hip: V2, hipA: number, kneeA: number, ankleA: number,
  l1: number, l2: number, lFoot: number,
) {
  const knee = add(hip, rot(V(l1, 0), hipA));
  const ankle = add(knee, rot(V(l2, 0), hipA + kneeA));
  const toe = add(ankle, rot(V(lFoot, 0), hipA + kneeA + ankleA));
  return { knee, ankle, toe };
}

// Gait foot target for one leg. `phase` advances with scroll (+ idle time);
// two legs offset by π alternate steps. y-down: `stance` extends the foot
// downward from the hip, `lift` raises it (smaller y) during the forward swing.
export function gaitFoot(
  hip: V2, phase: number, stride: number, stance: number, lift: number,
): V2 {
  const fx = hip.x + stride * Math.sin(phase);
  const swing = Math.max(0, Math.sin(phase));   // 0 except during the forward swing
  const fy = hip.y + stance - lift * swing;
  return { x: fx, y: fy };
}

export const smooth = (t: number) => t * t * (3 - 2 * t);   // smoothstep 0..1
