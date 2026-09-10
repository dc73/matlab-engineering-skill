# Patterns — MATLAB: An Introduction with Applications

Concrete techniques and decision rules distilled from the book.

## Pattern: Solve a linear system with left division
**When to use**: any `A*x = b` where A is square (Ch 3.3).
**How**: `x = A \ b` — uses LU/Cholesky under the hood.
**Trade-offs**: faster and more stable than `inv(A)*b`; avoid explicit inversion.

## Pattern: Preallocate arrays before loops
**When to use**: any loop that fills an array (Ch 2.2.1, Ch 6).
**How**: `a = zeros(n)` then `a(k) = ...` inside the loop.
**Trade-offs**: preallocation avoids the quadratic cost of `a(end+1) = ...` growth; costs knowing the size up front.

## Pattern: Bracket a root with fplot
**When to use**: `fzero` needs a bracket `[a, b]` with a sign change (Ch 9.1).
**How**: `fplot('x*exp(-x)-0.2', [0 8])` to see the crossings, then `fzero('x*exp(-x)-0.2', [a b])`.
**Trade-offs**: plotting first costs a figure but prevents `fzero` converging to the wrong root or returning NaN.

## Pattern: Surface plot pipeline
**When to use**: visualizing a function `z = f(x, y)` (Ch 10.2).
**How**: `[X, Y] = meshgrid(x, y)` → `Z = <element-wise f(X,Y)>` → `surf(X, Y, Z)` or `mesh(X, Y, Z)`.
**Trade-offs**: grid density controls resolution; coarse for checks, dense for publication.

## Pattern: Polynomial as coefficient vector
**When to use**: any polynomial model (Ch 8.1).
**How**: `p = [a_n ... a_0]` highest power first, zeros included; `polyval(p, x)`, `roots(p)`, `polyfit(xd, yd, n)`.
**Trade-offs**: reversed coefficient order silently evaluates the mirrored polynomial — the #1 bug in this domain.

## Pattern: Pass a function handle to a solver
**When to use**: `fzero`, `fminbnd`, `integral`, `ode45` (Ch 7.9, Ch 9).
**How**: `fzero(@(x) x*exp(-x)-0.2, [0 1])`; `ode45(@(t, y) rhs(t, y), [t0 tf], y0)`.
**Trade-offs**: handles are more efficient and clearer than string expressions, which cannot reference predefined variables.

## Pattern: Tolerance-based numeric assertion
**When to use**: validating solver outputs (repo SKILL.md, Ch 9).
**How**:
```matlab
err = abs(actual - expected);
limit = absTol + relTol * abs(expected);
assert(all(err <= limit, "all"), "Result exceeds tolerance.");
```
**Trade-offs**: `absTol`/`relTol` scale with the magnitude of the quantity; a bare `==` on floats is unreliable.

## Pattern: Symmetric covariance repair
**When to use**: estimation filters (repo SKILL.md, linear algebra/estimation section).
**How**: `P = (P + P.')/2` to restore numerical symmetry.
**Trade-offs**: cheap fix for drift; do not apply where asymmetry is meaningful.

## Anti-patterns
- **`inv(A)*b`** — use `A\b`.
- **Growing arrays in loops** — preallocate.
- **`fzero` with an unbracketed scalar far from a root** — use a `fplot` bracket.
- **Reversed polynomial coefficient order**.
- **String solver expressions with predefined variables** — inline the constants.
- **`ode45` for stiff systems** — switch to an `ode*s` solver only with stiffness evidence.
- **`==` on floats** — use a tolerance.
- **`clear all` mid-script** — it wipes functions and caches; clear specific names.
