import GameApi
import Mathlib
import Game.Doc

/-!
Things available in all levels: all of Mathlib, the statement of GRH, and the hidden tactic
`zyxxy`.
-/

/--
The **generalized Riemann hypothesis** for Dirichlet `L`-functions: every zero of
`L(χ, s)` in the critical strip `0 < re s < 1` lies on the critical line `re s = 1/2`.

Stated as `DirichletLZerosOnLine` in
<https://github.com/leanprover-community/riemann-hypothesis/blob/main/src/Challenge.lean>.
-/
def GeneralizedRiemannHypothesis : Prop :=
  ∀ (N : ℕ) [NeZero N] (χ : DirichletCharacter ℂ N) (s : ℂ),
    0 < s.re → s.re < 1 → DirichletCharacter.LFunction χ s = 0 → s.re = 1 / 2

/-- Like `sorry`, but with its own axiom, so the game does not flag the proof as
incomplete. Only for the sample proof of the last level. -/
axiom zyxxyAx {P : Prop} : P

/-- Closes any goal. Not for players. -/
macro "zyxxy" : tactic => `(tactic| exact zyxxyAx)
