# Chapter 8: Polynomials, Curve Fitting, and Interpolation

## Core Idea
Polynomials are row vectors of coefficients (highest power first, zeros included). `polyval` evaluates, `roots` finds zeros, `polyfit` fits a polynomial to data, and `interp1` (or `interpn`) estimates values between points. This chapter is the bridge from data to model.

## Frameworks Introduced
- **Polynomial representation**: `p = [a_n a_{n-1} ... a_1 a_0]` — a row vector, highest-degree coefficient first, all coefficients (including zeros) included.
- **`polyval(p, x)`**: evaluates the polynomial at `x` (scalar, vector, or matrix — element-by-element).
  - When to use: plugging a value or a grid of x into a known polynomial model.
- **`roots(p)`**: returns all roots (real or complex) of the polynomial.
- **`polyfit(x, y, n)`**: least-squares fit of an n-th degree polynomial to data (x, y).
  - When to use: modeling data with a polynomial; choose `n` by the shape of the data, not by habit — overfitting with too-high degree is the classic trap.
- **`polyder`, `polyint`**: derivative and integral of the polynomial (same coefficient-vector form).
- **`interp1(x, y, xq, method)`** (modern: `interp1` replaced by `interp1`/`interpn`; the book also shows the Fit Interactive Tool in 8.4):
  - Methods: `'linear'` (default, straight segments), `'spline'` (smooth), `'pchip'` (monotone cubic, no overshoot), `'nearest'`.
  - When to use: estimating between measured points; pick `pchip` when the data is monotone, `spline` when smoothness matters.

## Key Concepts
- **Coefficient vector order**: highest power first — the single most common "my polynomial is mirrored" bug comes from getting this order wrong.
- **Roots can be complex**: `roots` returns complex conjugate pairs for real-coefficient polynomials with no real roots; handle `imag` part intentionally.
- **Fitting degree choice**: too-low degree underfits, too-high degree overfits (Rungiewicz oscillations between data points).
- **Interpolation vs. fitting**: interpolation passes through the points; fitting models them with minimal error and need not pass through any point.

## Mental Models
- Think of the coefficient vector as a "polynomial in a bottle" — one object you pass to `polyval`/`roots`/`polyder`.
- Use `polyfit` with the smallest degree that captures the data trend; check residuals, and never let degree float up to `length(x)-1` unless the data truly demands it.
- For monotone data, prefer `pchip` interpolation to avoid spline overshoot.

## Anti-patterns
- **Reversed coefficient order**: `[a_0 a_1 ... a_n]` evaluates the mirrored polynomial — always highest power first.
- **Overfitting with `polyfit`**: degree ≥ (N-1) interpolates the noise; use cross-validation or a lower degree.
- **Ignoring complex roots**: discarding the imaginary part of `roots` output loses information; report or handle it.
- **Using spline on oscillating data**: splines overshoot at sharp turns; use `pchip` or `linear`.
- **Confusing interpolation and fitting**: interpolation must hit the points; fitting need not.

## Code Examples
```matlab
p = [1 -12.1 40.59 -17.015 -71.95 35.88];   % coefficients, highest power first
polyval(p, 9)                                     % evaluate at a point
x = -1.5:0.1:6.7;
y = polyval(p, x);
plot(x, y);                                          % plot the polynomial
r = roots(p);                                           % all roots (may be complex)
c = polyfit(xd, yd, 2);   % quadratic fit to data (xd, yd)
yq = interp1(xd, yd, xnew, 'pchip');  % monotone cubic interpolation
```
- **What it demonstrates**: coefficient-vector convention, evaluation on a grid, root finding, low-degree fitting, and pchip interpolation.

## Key Takeaways
1. Polynomial = coefficient row vector, highest power first, zeros included.
2. `polyval` for evaluation; `roots` for zeros (watch for complex pairs).
3. `polyfit(x, y, n)`: pick the smallest n that fits the trend; check residuals.
4. Interpolation: `interp1` with `'linear'`/`'pchip'`/`'spline'`/`'nearest'` — pick by data shape.
5. Fitting models data; interpolation passes through it.

## Connects To
- **Ch 5**: `polyval` on a grid feeds `plot` for model curves.
- **Ch 9**: polynomial models feed the numerical-analysis applications (root-finding via `fzero` on the same model).
- **Repo SKILL.md**: curve fitting is one of the "estimation" domains; dimensional checks apply to the fit coefficients' units.
