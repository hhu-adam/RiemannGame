"""ζ(s) for |Im s| ≲ 60 by Euler–Maclaurin summation, pure Python."""
from fractions import Fraction
from math import factorial

def _bernoulli(m):
    A = [Fraction(0)] * (m + 1)
    B = []
    for n in range(m + 1):
        A[n] = Fraction(1, n + 1)
        for j in range(n, 0, -1):
            A[j - 1] = j * (A[j - 1] - A[j])
        B.append(A[0])
    return B

_B = _bernoulli(40)
N, K = 40, 18

def zeta(s: complex) -> complex:
    total = sum(n ** -s for n in range(1, N))
    total += N ** (1 - s) / (s - 1) + N ** -s / 2
    poch = s  # s (s+1) ... (s+2k-2)
    for k in range(1, K + 1):
        total += float(_B[2 * k]) / factorial(2 * k) * poch * N ** (-s - 2 * k + 1)
        poch *= (s + 2 * k - 1) * (s + 2 * k)
    return total

ZEROS = [14.134725142, 21.022039639, 25.010857580, 30.424876126, 32.935061588,
         37.586178159, 40.918719012, 43.327073281, 48.005150881, 49.773832478]

if __name__ == "__main__":
    print(zeta(2), 3.14159265358979**2 / 6)
    print(zeta(-1), -1 / 12)
    for z in ZEROS:
        print(z, abs(zeta(0.5 + 1j * z)))
