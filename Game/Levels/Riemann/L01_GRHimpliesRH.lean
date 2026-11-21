import Game.Metadata

World "Riemann"
Level 1

Title "GRH implies RH"

Introduction "
The **generalized Riemann hypothesis** (GRH) says that the zeros of every Dirichlet
`L`-function in the critical strip `0 < re s < 1` lie on the line `re s = 1/2`.

The Riemann zeta function is the `L`-function of the trivial character modulo `1`, so GRH
should imply the Riemann hypothesis (RH). The catch: Mathlib's `RiemannHypothesis` is not
phrased with the critical strip, but excludes the trivial zeros `-2, -4, …` and the pole
`s = 1`. So you have to show that every other zero of `ζ` lies in the critical strip.
"

/-- The generalized Riemann hypothesis implies the Riemann hypothesis. -/
TheoremDoc grh_imp_rh as "grh_imp_rh" in "L"

/-- The generalized Riemann hypothesis implies the Riemann hypothesis. -/
Statement grh_imp_rh
    (preamble := dsimp only [GeneralizedRiemannHypothesis, RiemannHypothesis] at *; intro s hs htriv hpole)
    (grh : GeneralizedRiemannHypothesis) : RiemannHypothesis := by
  Hint (hidden := true) "Apply GRH to the modulus `1` and its (only) character `1`:
  `apply {grh} 1 1 {s}`."
  apply grh 1 1 s
  · Hint "Why is `0 < re {s}`? Otherwise `{s}` would be a trivial zero, which `{htriv}` rules
    out. Start with `by_contra hneg`."
    by_contra hneg
    Hint (hidden := true) "`rw [not_lt] at {hneg}` turns it into `re {s} ≤ 0`."
    rw [not_lt] at hneg
    Hint "For `re s ≤ 0`, the zeros of `ζ` are the trivial ones:
    `riemannZeta_eq_zero_iff_of_re_nonpos`."
    Hint (hidden := true) "`exact {htriv} ((riemannZeta_eq_zero_iff_of_re_nonpos {hneg}).mp {hs})`"
    exact htriv ((riemannZeta_eq_zero_iff_of_re_nonpos hneg).mp hs)
  · Hint "Why is `re {s} < 1`? Because `ζ` has no zeros with `1 ≤ re s`. Again by
    contradiction: `by_contra hge`."
    by_contra hge
    Hint (hidden := true) "`rw [not_lt] at {hge}`"
    rw [not_lt] at hge
    Hint (hidden := true) "`exact riemannZeta_ne_zero_of_one_le_re {hge} {hs}`"
    exact riemannZeta_ne_zero_of_one_le_re hge hs
  · Hint "The `L`-function of the character mod `1` is `ζ`: `LFunction_modOne_eq`."
    Hint (hidden := true) "`rw [DirichletCharacter.LFunction_modOne_eq]`, then `exact {hs}`."
    rw [DirichletCharacter.LFunction_modOne_eq]
    exact hs

Conclusion "
So GRH implies RH, and only the second level is missing…
"

NewTactic intro rintro apply exact refine rw simp simp_all unfold by_contra push contrapose
  exfalso constructor use obtain rcases «have» specialize «calc» ext linarith nlinarith
  positivity norm_num ring field_simp gcongr omega decide tauto aesop grind
NewDefinition riemannZeta completedRiemannZeta hurwitzZeta RiemannHypothesis DirichletCharacter
  DirichletCharacter.LFunction DirichletCharacter.IsPrimitive GeneralizedRiemannHypothesis
  Complex.re Complex.im Complex.Gamma
NewTheorem riemannZeta_zero riemannZeta_neg_two_mul_nat_add_one riemannZeta_one_sub
  riemannZeta_ne_zero_of_one_le_re riemannZeta_ne_zero_of_one_lt_re
  riemannZeta_eq_zero_iff_of_re_nonpos riemannZeta_residue_one differentiableAt_riemannZeta
  zeta_eq_tsum_one_div_nat_cpow riemannZeta_two riemannZeta_four completedRiemannZeta_one_sub
  DirichletCharacter.LFunction_modOne_eq DirichletCharacter.LFunction_eq_LSeries
  DirichletCharacter.LFunction_ne_zero_of_one_le_re DirichletCharacter.LFunction_apply_one_ne_zero
  DirichletCharacter.LFunction_eq_zero_iff_of_re_nonpos DirichletCharacter.LFunction_changeLevel
  DirichletCharacter.LFunctionTrivChar_eq_mul_riemannZeta
  DirichletCharacter.IsPrimitive.completedLFunction_one_sub
  DirichletCharacter.isPrimitive_one_level_one DirichletCharacter.norm_rootNumber
  Complex.add_re Complex.sub_re Complex.mul_re Complex.neg_re Complex.one_re Complex.zero_re
  Complex.ofReal_re Complex.conj_re Complex.ext_iff Complex.re_add_im
  not_lt not_le lt_trichotomy le_antisymm lt_irrefl le_or_gt half_pos one_half_pos
  one_half_lt_one
TheoremTab "ζ"
