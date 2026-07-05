#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude:*

#show: main.with(
  title: "Group Relative Policy Optimization",
  desc: "Group Relative Policy Optimization",
  date: "2025-06-08",
  tags: (
    "rl",
    "llms",
  ),
  show-outline: true,
)




==== Background: Proximal Policy Optimization (PPO)

PPO introduces a clipped surrogate objective for policy optimization. By constraining the policy updates within a proximal region of the previous policy using clip, PPO stabilizes training and improves sample efficiency. Specifically, PPO updates the policy by maximizing the following objective:
$ cal(J)_text("PPO")(theta) = bb(E)_((q,a)~cal(D))
[ 
min ( (pi_theta(o_t|q,o_(<t)))/(pi_(theta_text("old"))(o_t|q,o_(<t))) hat(A)_t,  
  "clip" ( (pi_theta(o_t|q,o_(<t)))/(pi_(theta_text("old"))(o_t|q,o_(<t))), 1 - epsilon, 1 + epsilon ) hat(A)_t ) ] $
where $(q,a)$ is a question-answer pair from the data distribution $cal(D)$, $epsilon$ is the clipping range of importance sampling ratio, and $hat(A)_t$ is an estimator of the advantage at time step $t$. Given the value function $V$ and the reward function $R$, $hat(A)_t$ is computed using the Generalized Advantage Estimation (GAE):
$ hat(A)_t^text("GAE")(gamma,lambda) = sum_(l=0)^infinity (gamma lambda)^l delta_(t+l), $
where
$ delta_l = R_l + gamma V(s_(l+1)) - V(s_l), quad 0 <= gamma, lambda <= 1. $


==== Group Relative Policy Optimization (GRPO)


Compared to PPO, GRPO eliminates the value function and estimates the advantage in a group-relative manner. 


*Objective Function*

Similar to PPO, GRPO maximizes a clipped objective, together with a directly imposed KL penalty term:
$ cal(J)_text("GRPO")(theta) = bb(E)_((q,a)~cal(D))  1/G sum_(i=1)^G 1/(|o_i|) sum_(t=1)^(|o_i|) [ 
min ( r_(i,t)(theta) hat(A)_(i,t),  
  "clip" ( r_(i,t)(theta), 1 - epsilon, 1 + epsilon ) hat(A)_(i,t) )
- beta D_text("KL")(pi_theta || pi_text("ref"))  ] $

where:
- $r_(i,t)(theta) = (pi_(theta)(o_(i,t) | q, o_(i,<t)))/(pi_(theta_text("old"))(o_(i,t) | q,o_(i,<t)))$ is the importance sampling ratio for the $i$-th response at time step $t$
- $hat(A)_(i,t)$ is the advantage for the $i$-th response at time step $t$
- $beta$ is the KL penalty coefficient
- $D_text("KL")(pi_theta || pi_text("ref"))$ is the KL divergence between the current policy and the reference policy
- $epsilon$ is the clipping range of importance sampling ratio
- $G$ is the group size
- $o_i$ is the $i$-th response
- $q$ is the question
- $o_(i,<t)$ is the sequence of tokens before position $t$ in response $i$
- $pi_(theta)(o_(i,t) | q, o_(i,<t))$ is the probability of generating token $o_(i,t)$ under current policy
- $pi_(theta_text("old"))(o_(i,t) | q, o_(i,<t))$ is the probability of generating token $o_(i,t)$ under the old policy

