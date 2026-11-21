import GameApi
import Mathlib

/-! # Inventory: tactics, theorems and definitions -/

/-! ## Tactics -/

/-- `intro x` introduces a variable or hypothesis from a `∀` or `→` goal. -/
TacticDoc intro
/-- `rintro ⟨x, hx⟩` introduces and destructs at once. -/
TacticDoc rintro
/-- `apply h` reduces the goal to the hypotheses of `h`. -/
TacticDoc apply
/-- `exact h` closes the goal with `h`. -/
TacticDoc exact
/-- `refine ⟨?_, ?_⟩` like `exact`, with holes `?_` left as new goals. -/
TacticDoc refine
/-- `rw [h]` rewrites with an equation or equivalence `h`. -/
TacticDoc rw
/-- `simp` simplifies the goal with the simp set; `simp [h]` uses `h` too. -/
TacticDoc simp
/-- `simp_all` simplifies all hypotheses and the goal with each other. -/
TacticDoc simp_all
/-- `unfold f` unfolds the definition `f`. -/
TacticDoc unfold
/-- `by_contra h` proves the goal by contradiction, with its negation as `h`. -/
TacticDoc by_contra
/-- `push Not` pushes negations inwards, e.g. `¬ a < b` becomes `b ≤ a`.
`push Not at h` does it in `h`. -/
TacticDoc push
/-- `contrapose! h` replaces goal and `h` by their negations, swapped. -/
TacticDoc contrapose
/-- `exfalso` changes the goal to `False`. -/
TacticDoc exfalso
/-- `constructor` splits `∧` and `↔` goals. -/
TacticDoc constructor
/-- `use x` provides the witness of an `∃` goal. -/
TacticDoc use
/-- `obtain ⟨x, hx⟩ := h` destructs `h`. -/
TacticDoc obtain
/-- `rcases h with ⟨x, hx⟩ | h'` destructs `h` with a pattern. -/
TacticDoc rcases
/-- `have h : P := proof` adds a new hypothesis. -/
TacticDoc «have»
/-- `specialize h x` applies the hypothesis `h` to `x`. -/
TacticDoc specialize
/-- `calc` proves a chain of (in)equalities step by step. -/
TacticDoc «calc»
/-- `ext` proves an equality of functions pointwise. -/
TacticDoc ext
/-- `linarith` proves linear (in)equalities over ordered fields. -/
TacticDoc linarith
/-- `nlinarith` is `linarith` with some products of hypotheses. -/
TacticDoc nlinarith
/-- `positivity` proves goals of the form `0 < e` and `0 ≤ e`. -/
TacticDoc positivity
/-- `norm_num` normalises numerals, e.g. proves `(1 : ℝ) / 2 < 1`. -/
TacticDoc norm_num
/-- `ring` proves equalities in commutative rings. -/
TacticDoc ring
/-- `field_simp` clears denominators. -/
TacticDoc field_simp
/-- `gcongr` proves inequalities by monotonicity. -/
TacticDoc gcongr
/-- `omega` proves linear arithmetic over `ℕ` and `ℤ`. -/
TacticDoc omega
/-- `decide` proves decidable propositions by computation. -/
TacticDoc decide
/-- `tauto` proves propositional tautologies. -/
TacticDoc tauto
/-- `aesop` searches for a proof with many rules. -/
TacticDoc aesop
/-- `grind` proves goals by congruence closure, case splits and arithmetic. -/
TacticDoc grind

/-! ## Definitions -/

/-- The Riemann zeta function `ζ(s)`, meromorphically continued to `ℂ`.
Its value at the pole `s = 1` is a junk value. -/
DefinitionDoc riemannZeta as "riemannZeta" in "ζ"
/-- `ζ` completed by its Gamma factor, symmetric under `s ↦ 1 - s`. -/
DefinitionDoc completedRiemannZeta as "completedRiemannZeta" in "ζ"
/-- The Hurwitz zeta function `ζ(s, a)`. -/
DefinitionDoc hurwitzZeta as "hurwitzZeta" in "ζ"
/-- Mathlib's statement of the Riemann hypothesis: every zero of `ζ`, except the trivial
zeros `-2, -4, …` (and the junk value at `1`), has real part `1/2`. -/
DefinitionDoc RiemannHypothesis as "RiemannHypothesis" in "ζ"
/-- A Dirichlet character of modulus `N`: a multiplicative character of `ZMod N`.
[[mathlib_doc]] -/
DefinitionDoc DirichletCharacter as "DirichletCharacter" in "L"
/-- The `L`-function `L(χ, s)` of a Dirichlet character, continued to `ℂ`. -/
DefinitionDoc DirichletCharacter.LFunction as "LFunction" in "L"
/-- Whether a Dirichlet character is primitive, i.e. not induced from a smaller modulus.
[[mathlib_doc]] -/
DefinitionDoc DirichletCharacter.IsPrimitive as "IsPrimitive" in "L"
/-- The generalized Riemann hypothesis: every zero of a Dirichlet `L`-function in the
critical strip `0 < re s < 1` has real part `1/2`. -/
DefinitionDoc GeneralizedRiemannHypothesis as "GRH" in "L"
/-- The real part of a complex number. -/
DefinitionDoc Complex.re as "re" in "ℂ"
/-- The imaginary part of a complex number. -/
DefinitionDoc Complex.im as "im" in "ℂ"
/-- The Gamma function on `ℂ`. -/
DefinitionDoc Complex.Gamma as "Gamma" in "ℂ"

/-! ## Theorems -/

/-- `ζ(0) = -1/2`. -/
TheoremDoc riemannZeta_zero as "riemannZeta_zero" in "ζ"
/-- The trivial zeros: `ζ(-2(n+1)) = 0`. -/
TheoremDoc riemannZeta_neg_two_mul_nat_add_one as "riemannZeta_neg_two_mul_nat_add_one" in "ζ"
/-- The functional equation of `ζ`. -/
TheoremDoc riemannZeta_one_sub as "riemannZeta_one_sub" in "ζ"
/-- `ζ(s) ≠ 0` for `1 ≤ re s`. -/
TheoremDoc riemannZeta_ne_zero_of_one_le_re as "riemannZeta_ne_zero_of_one_le_re" in "ζ"
/-- `ζ(s) ≠ 0` for `1 < re s`. -/
TheoremDoc riemannZeta_ne_zero_of_one_lt_re as "riemannZeta_ne_zero_of_one_lt_re" in "ζ"
/-- For `re s ≤ 0`, the zeros of `ζ` are exactly the trivial ones. -/
TheoremDoc riemannZeta_eq_zero_iff_of_re_nonpos as "riemannZeta_eq_zero_iff_of_re_nonpos" in "ζ"
/-- The residue of `ζ` at `s = 1` is `1`. -/
TheoremDoc riemannZeta_residue_one as "riemannZeta_residue_one" in "ζ"
/-- `ζ` is differentiable away from `1`. -/
TheoremDoc differentiableAt_riemannZeta as "differentiableAt_riemannZeta" in "ζ"
/-- `ζ(s) = ∑ 1 / n ^ s` for `1 < re s`. -/
TheoremDoc zeta_eq_tsum_one_div_nat_cpow as "zeta_eq_tsum_one_div_nat_cpow" in "ζ"
/-- `ζ(2) = π² / 6`. -/
TheoremDoc riemannZeta_two as "riemannZeta_two" in "ζ"
/-- `ζ(4) = π⁴ / 90`. -/
TheoremDoc riemannZeta_four as "riemannZeta_four" in "ζ"
/-- The functional equation of the completed zeta function. -/
TheoremDoc completedRiemannZeta_one_sub as "completedRiemannZeta_one_sub" in "ζ"

/-- The `L`-function of the (trivial) character mod `1` is `ζ`. -/
TheoremDoc DirichletCharacter.LFunction_modOne_eq as "LFunction_modOne_eq" in "L"
/-- `L(χ, s)` is its Dirichlet series for `1 < re s`. -/
TheoremDoc DirichletCharacter.LFunction_eq_LSeries as "LFunction_eq_LSeries" in "L"
/-- `L(χ, s) ≠ 0` for `1 ≤ re s`, except for the trivial character at `1`. -/
TheoremDoc DirichletCharacter.LFunction_ne_zero_of_one_le_re as "LFunction_ne_zero_of_one_le_re" in "L"
/-- `L(χ, 1) ≠ 0` for non-trivial `χ`: the heart of Dirichlet's theorem. -/
TheoremDoc DirichletCharacter.LFunction_apply_one_ne_zero as "LFunction_apply_one_ne_zero" in "L"
/-- The zeros of a primitive `L`-function in `re s ≤ 0` are those of its Gamma factor.
[[mathlib_doc]] -/
TheoremDoc DirichletCharacter.LFunction_eq_zero_iff_of_re_nonpos as "LFunction_eq_zero_iff_of_re_nonpos" in "L"
/-- How `L(χ, s)` changes when `χ` is lifted to a larger modulus. -/
TheoremDoc DirichletCharacter.LFunction_changeLevel as "LFunction_changeLevel" in "L"
/-- The `L`-function of the trivial character is `ζ` times Euler factors. -/
TheoremDoc DirichletCharacter.LFunctionTrivChar_eq_mul_riemannZeta as "LFunctionTrivChar_eq_mul_riemannZeta" in "L"
/-- The functional equation of a primitive `L`-function. -/
TheoremDoc DirichletCharacter.IsPrimitive.completedLFunction_one_sub as "completedLFunction_one_sub" in "L"
/-- The trivial character mod `1` is primitive. -/
TheoremDoc DirichletCharacter.isPrimitive_one_level_one as "isPrimitive_one_level_one" in "L"
/-- The root number of a primitive character has absolute value `1`. -/
TheoremDoc DirichletCharacter.norm_rootNumber as "norm_rootNumber" in "L"

/-- `re (z + w) = re z + re w`. -/
TheoremDoc Complex.add_re as "add_re" in "ℂ"
/-- `re (z - w) = re z - re w`. -/
TheoremDoc Complex.sub_re as "sub_re" in "ℂ"
/-- `re (z * w) = re z * re w - im z * im w`. -/
TheoremDoc Complex.mul_re as "mul_re" in "ℂ"
/-- `re (-z) = - re z`. -/
TheoremDoc Complex.neg_re as "neg_re" in "ℂ"
/-- `re 1 = 1`. -/
TheoremDoc Complex.one_re as "one_re" in "ℂ"
/-- `re 0 = 0`. -/
TheoremDoc Complex.zero_re as "zero_re" in "ℂ"
/-- `re (x : ℂ) = x` for real `x`. -/
TheoremDoc Complex.ofReal_re as "ofReal_re" in "ℂ"
/-- `re (conj z) = re z`. -/
TheoremDoc Complex.conj_re as "conj_re" in "ℂ"
/-- Two complex numbers are equal iff their real and imaginary parts are. -/
TheoremDoc Complex.ext_iff as "ext_iff" in "ℂ"
/-- `z = re z + im z * I`. -/
TheoremDoc Complex.re_add_im as "re_add_im" in "ℂ"

/-- `¬ a < b ↔ b ≤ a`. -/
TheoremDoc not_lt as "not_lt" in "≤"
/-- `¬ a ≤ b ↔ b < a`. -/
TheoremDoc not_le as "not_le" in "≤"
/-- `a < b ∨ a = b ∨ b < a`. -/
TheoremDoc lt_trichotomy as "lt_trichotomy" in "≤"
/-- `a ≤ b → b ≤ a → a = b`. -/
TheoremDoc le_antisymm as "le_antisymm" in "≤"
/-- `¬ a < a`. -/
TheoremDoc lt_irrefl as "lt_irrefl" in "≤"
/-- `a ≤ b ∨ b < a`. -/
TheoremDoc le_or_gt as "le_or_gt" in "≤"
/-- `0 < a → 0 < a / 2`. -/
TheoremDoc half_pos as "half_pos" in "≤"
/-- `0 < 1 / 2`. -/
TheoremDoc one_half_pos as "one_half_pos" in "≤"
/-- `1 / 2 < 1`. -/
TheoremDoc one_half_lt_one as "one_half_lt_one" in "≤"
