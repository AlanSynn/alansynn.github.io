#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude:*

#show: main.with(
  title: "Typesetting Math with Typst",
  desc: "A quick tour of writing equations in Typst.",
  date: "2026-06-01",
  tags: ("typst", "math"),
  show-outline: true,
)

Because this site compiles *Typst* to HTML at build time, equations become MathML — no client-side MathJax, no layout shift. A quick tour.

== Inline and display

Inline math is wrapped in dollar signs: the mean-squared loss is $cal(L)(theta) = (1)/(2n) sum_(i=1)^n (hat(y)_i - y_i)^2$.

A display equation:

$ integral_0^infinity e^(-x^2) dif x = (sqrt(pi))/(2) $

== A reinforcement-learning objective

PPO's clipped surrogate objective, written almost as you would on paper:

$ cal(J)_text("PPO")(theta) = bb(E)_((q,a)~cal(D)) [ min(r_t(theta) hat(A)_t, "clip"(r_t(theta), 1 - epsilon, 1 + epsilon) hat(A)_t) ] $

where $r_t(theta) = (pi_theta(a_t | s_t))/(pi_(theta_text("old"))(a_t | s_t))$ is the importance-sampling ratio and $hat(A)_t$ is the advantage estimate.

That is the whole pipeline — write math, get crisp typeset output.
