import Game.Levels.Riemann.L01_GRHimpliesRH

World "Riemann"
Level 2

Title "GRH"

Introduction "
Now prove the generalized Riemann hypothesis.
"

/-- The generalized Riemann hypothesis. -/
TheoremDoc grh as "grh" in "L"

/-- The generalized Riemann hypothesis. -/
Statement grh (preamble := dsimp only [GeneralizedRiemannHypothesis, RiemannHypothesis]; intro n hn χ s hs hs₂ hzero) :
    GeneralizedRiemannHypothesis := by
  Hint "Good luck, have fun!"
  Hint (hidden := true) "If you get stuck: on 2026-11-20 Levent Alpöge announced a Lean formalization
of RH and of GRH for Dirichlet `L`-functions. See for example the mirror at
[leanprover-community/riemann-hypothesis](https://github.com/leanprover-community/riemann-hypothesis)."
  zyxxy

Conclusion "
Congratulations, you have proven the generalized Riemann hypothesis!
"

NewHiddenTactic zyxxy
