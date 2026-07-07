// @ts-nocheck
// robot-ik.ts — real-time IK engine, lazily imported by RobotIK.astro.
// @ts-nocheck (line 1): DOM glue (DOMPoint/getScreenCTM/rAF); correctness proven
// by the Playwright DOM-FK test + ik.ts, not types. Directive MUST be line 1.
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

// legs: two 3-DOF chains (hip/knee/ankle + foot), links drawn +Y. viewBox 140×260.
const LEG_HIPS = [V(50, 10), V(90, 10)];
const LEG = { l1: 92, l2: 86, lFoot: 22, stride: 14, stance: 186, lift: 14 };
const kneePivot = (hip) => V(hip.x, hip.y + LEG.l1); // rest y = 102
const anklePivot = (hip) => V(hip.x, hip.y + LEG.l1 + LEG.l2); // rest y = 188
const kneePoleDefault = (hip) => V(hip.x - 16, hip.y + 50); // knee bends LEFT

// arm: 3-DOF (shoulder/elbow/wrist + hand), links drawn −Y. viewBox 180×360.
const ARM = { shoulder: V(90, 340), l1: 95, l2: 88, lHand: 33 };
const elbowPivot = V(ARM.shoulder.x, ARM.shoulder.y - ARM.l1); // rest y = 245
const wristPivot = V(ARM.shoulder.x, ARM.shoulder.y - ARM.l1 - ARM.l2); // rest y = 157
const elbowPoleDefault = V(ARM.shoulder.x + 30, ARM.shoulder.y - 60); // elbow folds right
const FINGERS = [
  { sel: '.f-t', mcp: V(78, 150), l1: 12, l2: 10, l3: 8, base: -0.55, sign: 1 },
  { sel: '.f-i', mcp: V(88, 146), l1: 14, l2: 12, l3: 9, base: -0.18, sign: 1 },
  { sel: '.f-m', mcp: V(98, 145), l1: 15, l2: 12, l3: 10, base: 0.0, sign: 1 },
  { sel: '.f-r', mcp: V(108, 147), l1: 14, l2: 11, l3: 9, base: 0.18, sign: 1 },
];

// pointer + drag state. PULL = end-effector tracks pointer + springs back; mid-joint
// (knee/elbow) = DANGLE: distal chain rigid, blends back to the IK solve.
const ptr = { x: 0, y: 0, rx: 0, ry: 0 };
let lastDt = 16;
const drag = { active: null, pull: new Map() };
const overrides = {}; // mid-joint dangle blend state
const lastSolves = {}; // frozen angles at drag start (seeds the dangle)

// per-frame CTM cache: the CTM is immutable within one rAF callback, so multiple
// screenToFrame calls on the same svg in a frame reuse one getScreenCTM().inverse().
// _frame++ each step → stale after a frame (correct once scroll/resize re-lays-out).
let _frame = 0;
const _ctm = new WeakMap();
function screenToFrame(el, x, y) {
  if (!el || !el.getScreenCTM || typeof DOMPoint === 'undefined') return V(0, 0);
  let e = _ctm.get(el);
  if (!e || e.frame !== _frame) {
    const ctm = el.getScreenCTM();
    if (!ctm) return V(0, 0);
    e = { frame: _frame, inv: ctm.inverse() };
    _ctm.set(el, e);
  }
  const p = new DOMPoint(x, y).matrixTransform(e.inv);
  return V(p.x, p.y);
}

// end-effector target: pointer while dragged; home + decaying pull otherwise.
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
  if (Math.hypot(np.x, np.y) < 0.25) {
    drag.pull.delete(id);
    return home;
  }
  drag.pull.set(id, np);
  return add(home, np);
}

// dangle override for a mid-joint (knee/elbow); blends IK solve toward a dragged pose.
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
  let dx = ov.target.x - piv.x,
    dy = ov.target.y - piv.y;
  const dd = Math.hypot(dx, dy) || 1;
  if (dd > l1) {
    dx = (dx / dd) * l1;
    dy = (dy / dd) * l1;
  }
  const rootAng = Math.atan2(dy, dx);
  const b = ov.blend;
  if (b < 0.01 && !(drag.active && drag.active.id === id)) {
    delete overrides[id];
    return ikSol;
  }
  return {
    hip: lerp(ikSol.hip, rootAng, b),
    knee: lerp(ikSol.knee, ov.shinAbs - rootAng, b),
    ankle: lerp(ikSol.ankle, ov.footAbs - ov.shinAbs, b),
  };
}

function driveLegs(c, topScroll, t) {
  const svg = c.svg;
  const phaseBase = topScroll * Math.PI * 3 + t * 0.0006;
  c.legs.forEach((leg, i) => {
    const hip = LEG_HIPS[i] ?? LEG_HIPS[0];
    const phase = phaseBase + (i ? Math.PI : 0);
    const f = gaitFoot(hip, phase, LEG.stride, LEG.stance, LEG.lift);
    const footAng = PI2 + 0.22 * Math.sin(t * 0.004 + phase * 0.5); // foot below ankle, idle tap
    const footTip = chainTarget(`leg:${i}:foot`, V(f.x, f.y), svg);
    const s = ikLegPole(hip, footTip, LEG.l1, LEG.l2, LEG.lFoot, footAng, kneePoleDefault(hip));
    const kid = `leg:${i}:knee`;
    const ikMid = fkLeg(hip, s.hip, s.knee, 0, LEG.l1, LEG.l2, 0).knee;
    const sol = dangleAngles(kid, svg, hip, LEG.l1, s, s.hip + s.knee, ikMid, footAng);
    setJ(leg.hip, sol.hip, hip, PI2);
    setJ(leg.knee, sol.knee, kneePivot(hip), 0);
    setJ(leg.ankle, sol.ankle, anklePivot(hip), 0);
    const kneePos = fkLeg(hip, sol.hip, sol.knee, 0, LEG.l1, LEG.l2, 0).knee;
    const toePos = fkLeg(hip, sol.hip, sol.knee, sol.ankle, LEG.l1, LEG.l2, LEG.lFoot).toe;
    setHandle(leg.footH, toePos);
    setHandle(leg.kneeH, kneePos);
    lastSolves[kid] = { shinAbs: s.hip + s.knee, footAbs: footAng };
  });
}

function driveArm(c, rise, t) {
  // --arm drives the rig transform AND the footer "Say hi" underline (not a rig
  // descendant → inherits from :root). Delta-gate: toFixed(4) is bit-identical on
  // idle frames, so skip both writes when unchanged (kills style recalc when still).
  const css = rise.toFixed(4);
  if (css !== _lastArm) {
    c.el.style.setProperty('--arm', css);
    document.documentElement.style.setProperty('--arm', css);
    _lastArm = css;
  }
  const svg = c.svg;
  const WSLOW = Math.PI / 1000; // π rad/s → 2s wave period
  const wristTarget = chainTarget('arm:wrist', V(96 + 4 * Math.sin(t * 0.0008), 140), svg);
  const handDir = -PI2 + 0.1 * Math.sin(t * 0.0011); // hand points up, gentle sway
  const a = ikLegPole(
    ARM.shoulder,
    wristTarget,
    ARM.l1,
    ARM.l2,
    ARM.lHand,
    handDir,
    elbowPoleDefault,
  );

  const eid = 'arm:elbow';
  const ikMid = fkLeg(ARM.shoulder, a.hip, a.knee, 0, ARM.l1, ARM.l2, 0).knee;
  const sol = dangleAngles(eid, svg, ARM.shoulder, ARM.l1, a, a.hip + a.knee, ikMid, handDir);

  const shoulderSway = 0.06 * Math.sin(t * 0.0014); // slow shoulder breath
  setJ(c.shoulder, sol.hip + shoulderSway, ARM.shoulder, -PI2);
  setJ(c.elbow, sol.knee, elbowPivot, 0);
  const wave = 0.38 * Math.sin(t * WSLOW); // ±22° wrist wave (2s)
  setJ(c.wrist, sol.ankle + wave, wristPivot, 0);
  setHandle(c.wristH, wristTarget);
  setHandle(c.elbowH, fkLeg(ARM.shoulder, sol.hip, sol.knee, 0, ARM.l1, ARM.l2, 0).knee);

  // fingers curl-wave synced with the wrist (phase-offset per finger); ext stays
  // high so PIP/DIP curl gently. footAng = dir − π/2 (dir is angle-from-up, ikLeg's
  // footAng is absolute) so the distal points up and PIP/DIP actually fold.
  const open = clamp01(rise);
  c.fingers.forEach((fng, idx) => {
    const f = fng.spec;
    const sync = 0.5 + 0.5 * Math.sin(t * WSLOW + idx * 0.4);
    const ext = 0.85 + 0.12 * open - 0.07 * sync;
    const dir = f.base + 0.03 * Math.sin(t * 0.0012 + idx);
    const reachLen = (f.l1 + f.l2 + f.l3) * ext;
    const tip = chainTarget(
      `finger:${f.sel}`,
      V(f.mcp.x + Math.sin(dir) * reachLen, f.mcp.y - Math.cos(dir) * reachLen),
      c.hand,
    );
    const r = ikLeg(f.mcp, tip, f.l1, f.l2, f.l3, dir - PI2, f.sign);
    setJ(fng.mcp, r.hip, f.mcp, -PI2);
    setJ(fng.pip, r.knee, V(f.mcp.x, f.mcp.y - f.l1), 0);
    setJ(fng.dip, r.ankle, V(f.mcp.x, f.mcp.y - f.l1 - f.l2), 0);
    setHandle(fng.tipH, tip);
  });
  lastSolves[eid] = { shinAbs: a.hip + a.knee, footAbs: handDir };
}

// Ease --arm from its CSS default (1) toward the scroll rise over ~420ms after
// start. CSS defaults --arm to 1 so a short unscrollable page still shows the arm;
// this hands control to scroll without a jump (short page: rise≈1, nothing moves).
let bootStart = 0;
function boot(t) {
  if (!bootStart) bootStart = t;
  return Math.min(1, (t - bootStart) / 420);
}

let _lastArm = '';
// scrollHeight cache: reading it after a frame's setAttribute writes can force a
// layout flush. It changes only on resize/font-load → cache + invalidate on resize,
// re-read every 1s as a staleness fallback for late web-font swap.
let _dh = 0,
  _dhAt = 0;
// rig partition + per-rig cached DOM refs (rig markup is static post-boot). Built
// once in init(); step() iterates these instead of re-querying every frame.
let LEG_RIGS = [],
  ARM_RIGS = [];

let last = 0;
function step(t) {
  _frame++;
  const dt = Math.min(48, t - last) || 16;
  last = t;
  lastDt = dt;
  const kp = 1 - Math.exp(-dt / 80);
  ptr.x += (ptr.rx - ptr.x) * kp;
  ptr.y += (ptr.ry - ptr.y) * kp;

  const vh = innerHeight,
    sy = scrollY;
  if (!_dh || t - _dhAt > 1000) {
    _dh = document.documentElement.scrollHeight;
    _dhAt = t;
  }
  const dh = _dh;
  const top = clamp01(sy / vh);
  const start = dh - vh * 1.8;
  // Rise ramps in over the last 0.8 vh (reaches 1 at the bottom). Short-page guard:
  // a page ≤ ~1.2 viewports can't scroll to the footer → force rise=1 so the arm
  // stands fully (matches long-page scrolled-to-footer; keeps it visible on /blog).
  const rise = dh <= vh * 1.2 ? 1 : clamp01((sy - start) / (dh - vh - start));
  for (const c of LEG_RIGS) driveLegs(c, top, t);
  const b = boot(t);
  const armRise = 1 - b + b * rise; // ease CSS default (1) → scroll rise
  for (const c of ARM_RIGS) driveArm(c, armRise, t);
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
  ptr.rx = e.clientX;
  ptr.ry = e.clientY;
  ptr.x = e.clientX;
  ptr.y = e.clientY;
  // seed the dangle override for mid-joint drags (knee, elbow) from the live solve
  const isDangle = id.endsWith(':knee') || id.endsWith(':elbow');
  if (isDangle && lastSolves[id]) {
    const s = lastSolves[id];
    overrides[id] = {
      blend: 1,
      target: screenToFrame(frame, ptr.x, ptr.y),
      shinAbs: s.shinAbs,
      footAbs: s.footAbs,
    };
  }
  try {
    h.setPointerCapture(e.pointerId);
  } catch {}
}
function onPointerMove(e) {
  ptr.rx = e.clientX;
  ptr.ry = e.clientY;
}
function onPointerUp(e) {
  if (drag.active) {
    try {
      e.target.releasePointerCapture && e.target.releasePointerCapture(e.pointerId);
    } catch {}
    drag.active = null; // pull map + overrides keep state → it decays (spring-back)
  }
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
  addEventListener(
    'resize',
    () => {
      _dh = 0;
    },
    { passive: true },
  );

  // build per-rig caches + partition into legs/arm arrays (DOM is static post-boot).
  for (const rig of rigs) {
    const svg = rig.querySelector('svg');
    if (rig.getAttribute('data-rig') === 'legs') {
      LEG_RIGS.push({
        svg,
        legs: [...rig.querySelectorAll('[data-side]')].map((leg, i) => ({
          hip: leg.querySelector('.j-hip'),
          knee: leg.querySelector('.j-knee'),
          ankle: leg.querySelector('.j-ankle'),
          footH: rig.querySelector(`.h-leg-${i}-foot`),
          kneeH: rig.querySelector(`.h-leg-${i}-knee`),
        })),
      });
    } else {
      const hand = rig.querySelector('.hand');
      ARM_RIGS.push({
        el: rig,
        svg,
        hand,
        shoulder: rig.querySelector('.j-shoulder'),
        elbow: rig.querySelector('.j-elbow'),
        wrist: rig.querySelector('.j-wrist'),
        wristH: rig.querySelector('.h-arm-wrist'),
        elbowH: rig.querySelector('.h-arm-elbow'),
        fingers: FINGERS.map((f) => ({
          spec: f,
          mcp: hand ? hand.querySelector(`${f.sel} .j-mcp`) : null,
          pip: hand ? hand.querySelector(`${f.sel} .j-pip`) : null,
          dip: hand ? hand.querySelector(`${f.sel} .j-dip`) : null,
          tipH: hand ? hand.querySelector(`.h-${f.sel.slice(1)}`) : null,
        })),
      });
    }
  }
  if (!LEG_RIGS.length && !ARM_RIGS.length) return;

  const visible = new Set();
  let raf = 0;
  const loop = (t) => {
    step(t);
    raf = visible.size ? requestAnimationFrame(loop) : 0;
  };
  const ensure = () => {
    if (!raf) raf = requestAnimationFrame(loop);
  };
  const io = new IntersectionObserver(
    (entries) => {
      for (const e of entries) e.isIntersecting ? visible.add(e.target) : visible.delete(e.target);
      if (visible.size) ensure();
    },
    { rootMargin: '200px' },
  );
  rigs.forEach((r) => io.observe(r));
  addEventListener('scroll', ensure, { passive: true });
  addEventListener('resize', ensure, { passive: true });
  ensure();
}

init();
