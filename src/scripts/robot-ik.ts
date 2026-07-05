// robot-ik.ts — the real-time IK engine, lazily imported by RobotIK.astro's
// bootstrap (on idle / when a rig nears the viewport). Running it is gated there
// by prefers-reduced-motion and by the rigs actually existing on the page, so by
// the time this module loads it should always run. See RobotIK.astro for the
// rigging convention and drag (pull / dangle) models.
// @ts-nocheck — DOM glue (DOMPoint, getScreenCTM, rAF). Correctness is proven by
// the Playwright DOM-FK test + ik.ts, not by static types.
import { ikLeg, ikLegPole, gaitFoot, V, add, sub, fkLeg } from '@/lib/ik';

const PI2 = Math.PI / 2;
const clamp01 = (x) => (x < 0 ? 0 : x > 1 ? 1 : x);
const lerp = (a, b, t) => a + (b - a) * t;
const setJ = (el, ang, piv, rest) => {
  if (!el) return;
  const deg = ((ang - rest) * 180) / Math.PI;
  el.setAttribute('transform', `rotate(${deg.toFixed(2)} ${piv.x} ${piv.y})`);
};
const setHandle = (el, p) => {
  if (!el) return;
  el.setAttribute('cx', p.x.toFixed(2));
  el.setAttribute('cy', p.y.toFixed(2));
};

// ---- legs: two 3-DOF chains (hip/knee/ankle + foot), links drawn +Y --------
const LEG_HIPS = [V(50, 10), V(90, 10)];            // viewBox 0 0 140 260
const LEG = { l1: 92, l2: 86, lFoot: 22, stride: 14, stance: 186, lift: 14 };
const kneePivot = (hip) => V(hip.x, hip.y + LEG.l1);          // rest y = 102
const anklePivot = (hip) => V(hip.x, hip.y + LEG.l1 + LEG.l2); // rest y = 188
// default knee pole: modestly left of each leg → the knee bends to face LEFT
const kneePoleDefault = (hip) => V(hip.x - 16, hip.y + 50);

// ---- arm: 3-DOF chain (shoulder/elbow/wrist + hand), links drawn −Y --------
const ARM = { shoulder: V(90, 340), l1: 95, l2: 88, lHand: 33 }; // viewBox 0 0 180 360
const elbowPivot = V(ARM.shoulder.x, ARM.shoulder.y - ARM.l1);        // rest y = 245
const wristPivot = V(ARM.shoulder.x, ARM.shoulder.y - ARM.l1 - ARM.l2); // rest y = 157
const elbowPoleDefault = V(ARM.shoulder.x + 30, ARM.shoulder.y - 60);  // elbow folds right
const FINGERS = [
  { sel: '.f-t', mcp: V(78, 150), l1: 12, l2: 10, l3: 8, base: -0.55, sign: 1 },
  { sel: '.f-i', mcp: V(88, 146), l1: 14, l2: 12, l3: 9, base: -0.18, sign: 1 },
  { sel: '.f-m', mcp: V(98, 145), l1: 15, l2: 12, l3: 10, base: 0.00, sign: 1 },
  { sel: '.f-r', mcp: V(108, 147), l1: 14, l2: 11, l3: 9, base: 0.18, sign: 1 },
];

// ---- pointer + drag state ------------------------------------------------
const ptr = { x: 0, y: 0, rx: 0, ry: 0 };
let lastDt = 16;
// pull model (end-effectors): per-chain offset in the chain's solve frame,
// eased to the pointer while dragged and to 0 on release.
const drag = { active: null, pull: new Map() };
// dangle model (mid-joints knee/elbow): per-chain blend toward a dragged pose.
const overrides = {};
const lastSolves = {};   // for capturing frozen angles at drag start

function screenToFrame(el, x, y) {
  const ctm = el && el.getScreenCTM && el.getScreenCTM();
  if (!ctm || typeof DOMPoint === 'undefined') return V(0, 0);
  const p = new DOMPoint(x, y).matrixTransform(ctm.inverse());
  return V(p.x, p.y);
}

// end-effector target: pointer while dragged, home + decaying pull otherwise.
function chainTarget(id, home, frame) {
  if (drag.active && drag.active.id === id) {
    const np = sub(screenToFrame(frame, ptr.x, ptr.y), home);
    drag.pull.set(id, np);
    return add(home, np);
  }
  const p = drag.pull.get(id);
  if (!p) return home;
  const k = 1 - Math.exp(-lastDt / 110);
  const np = V(p.x * (1 - k), p.y * (1 - k));
  if (Math.hypot(np.x, np.y) < 0.25) { drag.pull.delete(id); return home; }
  drag.pull.set(id, np);
  return add(home, np);
}

// Apply a dangle override for a mid-joint (knee/elbow). Returns blended
// {hip,knee,ankle} angles. `ikShin`/`ikTip` are the current IK shin-abs angle
// and mid-joint position to ease back toward; `footAbs` is the IK distal angle.
function dangleAngles(id, frame, piv, l1, ikSol, ikShin, ikMid, footAbs) {
  const ov = overrides[id];
  if (!ov) return ikSol;
  if (drag.active && drag.active.id === id) {
    ov.blend = 1;
    ov.target = screenToFrame(frame, ptr.x, ptr.y);
  } else {
    const k = 1 - Math.exp(-lastDt / 140);
    ov.blend = lerp(ov.blend, 0, k);
    ov.target = V(lerp(ov.target.x, ikMid.x, k), lerp(ov.target.y, ikMid.y, k));
    ov.shinAbs = lerp(ov.shinAbs, ikShin, k);
    ov.footAbs = lerp(ov.footAbs, footAbs, k);
  }
  let dx = ov.target.x - piv.x, dy = ov.target.y - piv.y;
  const dd = Math.hypot(dx, dy) || 1;
  if (dd > l1) { dx = (dx / dd) * l1; dy = (dy / dd) * l1; }
  const rootAng = Math.atan2(dy, dx);
  const b = ov.blend;
  if (b < 0.01 && !(drag.active && drag.active.id === id)) { delete overrides[id]; return ikSol; }
  return {
    hip: lerp(ikSol.hip, rootAng, b),
    knee: lerp(ikSol.knee, ov.shinAbs - rootAng, b),
    ankle: lerp(ikSol.ankle, ov.footAbs - ov.shinAbs, b),
  };
}

function driveLegs(rig, topScroll, t) {
  const svg = rig.querySelector('svg');
  const phaseBase = topScroll * Math.PI * 3 + t * 0.0006;
  rig.querySelectorAll('[data-side]').forEach((leg, i) => {
    const hip = LEG_HIPS[i] ?? LEG_HIPS[0];
    const phase = phaseBase + (i ? Math.PI : 0);
    const f = gaitFoot(hip, phase, LEG.stride, LEG.stance, LEG.lift);
    const footAng = PI2 + 0.22 * Math.sin(t * 0.004 + phase * 0.5);   // foot below ankle, idle tap
    const footHome = V(f.x, f.y);
    const footTip = chainTarget(`leg:${i}:foot`, footHome, svg);
    const s = ikLegPole(hip, footTip, LEG.l1, LEG.l2, LEG.lFoot, footAng, kneePoleDefault(hip));
    const kid = `leg:${i}:knee`;
    const ikMid = fkLeg(hip, s.hip, s.knee, 0, LEG.l1, LEG.l2, 0).knee;
    const sol = dangleAngles(kid, svg, hip, LEG.l1, s, s.hip + s.knee, ikMid, footAng);
    setJ(leg.querySelector('.j-hip'), sol.hip, hip, PI2);
    setJ(leg.querySelector('.j-knee'), sol.knee, kneePivot(hip), 0);
    setJ(leg.querySelector('.j-ankle'), sol.ankle, anklePivot(hip), 0);
    const kneePos = fkLeg(hip, sol.hip, sol.knee, 0, LEG.l1, LEG.l2, 0).knee;
    const toePos = fkLeg(hip, sol.hip, sol.knee, sol.ankle, LEG.l1, LEG.l2, LEG.lFoot).toe;
    setHandle(rig.querySelector(`.h-leg-${i}-foot`), toePos);
    setHandle(rig.querySelector(`.h-leg-${i}-knee`), kneePos);
    lastSolves[kid] = { shinAbs: s.hip + s.knee, footAbs: footAng };
  });
}

function driveArm(rig, rise, t) {
  rig.style.setProperty('--arm', rise.toFixed(4));
  document.documentElement.style.setProperty('--arm', rise.toFixed(4));
  const svg = rig.querySelector('svg');
  // Bent "waving" stance, centered on the footer line — hand up, palm forward. It never
  // tracks the "Say hi" link on screen, so it can never slide onto the text;
  // the Say-hi underline (CSS, driven by --arm) ties the arm to the link.
  const WSLOW = Math.PI / 1000;                          // π rad/s → 2s period (brisk greeting)
  // NOTE: ikLegPole's `foot` is the END-EFFECTOR TIP (end of lHand), so this
  // target is where the hand-tip reaches — the wrist sits lHand below it. Set
  // high so the hand is raised (waving), not hanging low in the viewBox.
  const wristHome = V(96 + 4 * Math.sin(t * 0.0008), 140);
  const wristTarget = chainTarget('arm:wrist', wristHome, svg);
  const handDir = -PI2 + 0.10 * Math.sin(t * 0.0011);    // hand points up, gentle sway
  const a = ikLegPole(ARM.shoulder, wristTarget, ARM.l1, ARM.l2, ARM.lHand, handDir, elbowPoleDefault);

  // Elbow dangle (draggable like the knee): blend toward pointer while grabbed,
  // ease back to the IK solve on release.
  const eid = 'arm:elbow';
  const ikMid = fkLeg(ARM.shoulder, a.hip, a.knee, 0, ARM.l1, ARM.l2, 0).knee;
  const sol = dangleAngles(eid, svg, ARM.shoulder, ARM.l1, a, a.hip + a.knee, ikMid, handDir);

  // Shoulder SWAYS (slow breath) so the whole rig is alive, not frozen.
  const shoulderSway = 0.06 * Math.sin(t * 0.0014);
  setJ(rig.querySelector('.j-shoulder'), sol.hip + shoulderSway, ARM.shoulder, -PI2);
  setJ(rig.querySelector('.j-elbow'), sol.knee, elbowPivot, 0);
  // THE WAVE: side-to-side wrist rotation (±~22°, 2s period) = the greeting.
  const wave = 0.38 * Math.sin(t * WSLOW);
  setJ(rig.querySelector('.j-wrist'), sol.ankle + wave, wristPivot, 0);
  setHandle(rig.querySelector('.h-arm-wrist'), wristTarget);
  const elbowPos = fkLeg(ARM.shoulder, sol.hip, sol.knee, 0, ARM.l1, ARM.l2, 0).knee;
  setHandle(rig.querySelector('.h-arm-elbow'), elbowPos);

  const hand = rig.querySelector('.hand');
  const open = clamp01(rise);
  FINGERS.forEach((f, idx) => {
    // ALL four fingers curl-wave IN SYNC with the wrist (greeting fingers open
    // and close together), each with a small phase offset so they stay lively.
    // ext stays high (fingers mostly extended) with a small sync modulation so
    // the PIP/DIP curl gently (~30–60°), not clench.
    const sync = 0.5 + 0.5 * Math.sin(t * WSLOW + idx * 0.4);
    const ext = (0.85 + 0.12 * open) - 0.07 * sync;
    const dir = f.base + 0.03 * Math.sin(t * 0.0012 + idx);
    const reachLen = (f.l1 + f.l2 + f.l3) * ext;
    const tipHome = V(f.mcp.x + Math.sin(dir) * reachLen, f.mcp.y - Math.cos(dir) * reachLen);
    const tip = chainTarget(`finger:${f.sel}`, tipHome, hand);
    // footAng = dir − π/2: `dir` is angle-from-up (0 = up), but ikLeg's footAng
    // is an absolute angle (0 = +X). Convert so the distal link points up and
    // the PIP/DIP actually fold (a straight finger means a convention clash).
    const r = ikLeg(f.mcp, tip, f.l1, f.l2, f.l3, dir - PI2, f.sign);
    setJ(hand?.querySelector(`${f.sel} .j-mcp`), r.hip, f.mcp, -PI2);
    setJ(hand?.querySelector(`${f.sel} .j-pip`), r.knee, V(f.mcp.x, f.mcp.y - f.l1), 0);
    setJ(hand?.querySelector(`${f.sel} .j-dip`), r.ankle, V(f.mcp.x, f.mcp.y - f.l1 - f.l2), 0);
    setHandle(hand?.querySelector(`.h-${f.sel.slice(1)}`), tip);
  });
  lastSolves[eid] = { shinAbs: a.hip + a.knee, footAbs: handDir };
}

// Hydration smoothing: the engine loads lazily (on idle / when a rig nears the
// viewport), which can be MID-SCROLL on inner pages where the footer arm is the
// only rig. Without this, --arm would jump to its scroll value on load and the
// arm would pop half-risen into view. `boot` ramps the ARM's rise 0→1 over the
// first ~420ms after the engine starts, so it rises smoothly out of the ground
// line instead. The legs are left at full strength (their engine loads almost
// immediately on the homepage hero, so there's nothing to smooth).
let bootStart = 0;
function boot(t) {
  if (!bootStart) bootStart = t;
  return Math.min(1, (t - bootStart) / 420);
}

let last = 0;
function step(t) {
  const dt = Math.min(48, t - last) || 16; last = t; lastDt = dt;
  const kp = 1 - Math.exp(-dt / 80);
  ptr.x += (ptr.rx - ptr.x) * kp;
  ptr.y += (ptr.ry - ptr.y) * kp;

  const vh = innerHeight, sy = scrollY;
  const dh = document.documentElement.scrollHeight;
  const top = clamp01(sy / vh);
  const start = dh - vh * 1.8;
  const rise = clamp01((sy - start) / (dh - vh - start));
  document.querySelectorAll('[data-rig="legs"]').forEach((r) => driveLegs(r, top, t));
  const armRise = rise * boot(t);
  document.querySelectorAll('[data-rig="arm"]').forEach((r) => driveArm(r, armRise, t));
}

function onPointerDown(e) {
  const h = e.target.closest && e.target.closest('.handle');
  if (!h) return;
  const rig = h.closest('[data-rig]');
  if (!rig) return;
  const id = h.getAttribute('data-drag');
  if (!id) return;
  e.preventDefault();
  const frame = id.indexOf('finger:') === 0 ? rig.querySelector('.hand') : rig.querySelector('svg');
  drag.active = { id, rig, frame };
  ptr.rx = e.clientX; ptr.ry = e.clientY; ptr.x = e.clientX; ptr.y = e.clientY;
  // seed the dangle override for mid-joint drags (knee, elbow) from the live solve
  const isDangle = id.endsWith(':knee') || id.endsWith(':elbow');
  if (isDangle && lastSolves[id]) {
    const s = lastSolves[id];
    overrides[id] = { blend: 1, target: screenToFrame(frame, ptr.x, ptr.y), shinAbs: s.shinAbs, footAbs: s.footAbs };
  }
  try { h.setPointerCapture(e.pointerId); } catch {}
}
function onPointerMove(e) { ptr.rx = e.clientX; ptr.ry = e.clientY; }
function onPointerUp(e) {
  if (drag.active) {
    try { e.target.releasePointerCapture && e.target.releasePointerCapture(e.pointerId); } catch {}
    drag.active = null;           // pull map + overrides keep state → it decays (spring-back)
  }
}

// Responsive arm sizing (homepage only, where a.say-hi exists). The arm's job
// is to wave just BELOW the "Say hi" underline — reach up toward it without
// crossing into the link text. Size it to the actual gap between the footer
// line and that link's bottom, measured live. The waving fingertips sit at a
// stable ≈1.23×arm-w above the line (the wave is a rotation, so tip height
// barely moves — ~4px over a cycle; calibrated by sampling 5s at armRise=1).
// Solve arm-w so the fingertips land `clearance` below the underline. Re-run on
// resize + font load; the gap is layout-stable so this needs no per-frame reflow.
function sizeArmToSayHi() {
  const stage = document.querySelector('.robot-arm-stage');
  const sayHi = document.querySelector('a.say-hi');
  const footer = document.querySelector('.site-footer');
  if (!stage || !sayHi || !footer) return;
  const gap = footer.getBoundingClientRect().top - sayHi.getBoundingClientRect().bottom;
  if (!isFinite(gap) || gap < 40 || gap > 620) return;   // bail on weird layouts → keep CSS default
  const armW = (gap - 8) / 1.23;
  stage.style.setProperty('--arm-w', `${Math.max(90, Math.min(180, armW))}px`);
}

function init() {
  const rigs = [...document.querySelectorAll('[data-rig]')];
  if (!rigs.length) return;
  ptr.x = ptr.rx = innerWidth / 2;
  ptr.y = ptr.ry = innerHeight / 2;
  addEventListener('pointerdown', onPointerDown);
  addEventListener('pointermove', onPointerMove, { passive: true });
  addEventListener('pointerup', onPointerUp, { passive: true });
  addEventListener('pointercancel', onPointerUp, { passive: true });

  sizeArmToSayHi();
  addEventListener('resize', sizeArmToSayHi, { passive: true });
  addEventListener('load', sizeArmToSayHi);
  if (document.fonts && document.fonts.ready) document.fonts.ready.then(sizeArmToSayHi);

  const visible = new Set();
  let raf = 0;
  const loop = (t) => { step(t); raf = visible.size ? requestAnimationFrame(loop) : 0; };
  const ensure = () => { if (!raf) raf = requestAnimationFrame(loop); };
  const io = new IntersectionObserver((entries) => {
    for (const e of entries) e.isIntersecting ? visible.add(e.target) : visible.delete(e.target);
    if (visible.size) ensure();
  }, { rootMargin: '200px' });
  rigs.forEach((r) => io.observe(r));
  addEventListener('scroll', ensure, { passive: true });
  addEventListener('resize', ensure, { passive: true });
  ensure();
}

init();
