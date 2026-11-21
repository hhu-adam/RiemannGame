import Game.Levels.Riemann

Title "Alpöge's Theorem"
Introduction
"
The **Riemann hypothesis** says that all non-trivial zeros of the Riemann zeta function
have real part `1/2`. The **generalized Riemann hypothesis** says the same for all Dirichlet
`L`-functions.

In this game you first show that GRH implies RH, using the definitions and theorems of
Mathlib. Then you prove GRH.

On 2026-11-20, Levent Alpöge announced a Lean formalization with a proof of both.
For a mirror of the announced proof, see
[leanprover-community/riemann-hypothesis](https://github.com/leanprover-community/riemann-hypothesis).
"

Conclusion
"
You have proven the generalized Riemann hypothesis. Well done!
"

Info "
A small game about the Riemann hypothesis, built on Mathlib.

* Mathlib's `RiemannHypothesis`: `Mathlib/NumberTheory/LSeries/RiemannZeta.lean`
* Mirror of the announced proof: [leanprover-community/riemann-hypothesis](https://github.com/leanprover-community/riemann-hypothesis)

The game is written by Claude, it does not use any of the announced
proof. It is meant as a small test for the new user interface. Hope you enjoy.

by Jon Eugster
"

Languages "en" "de"
CaptionShort "The Riemann Hypothesis"
CaptionLong "Prove the Riemann Hypothesis"
CoverImage "images/cover.png"

MakeGame
