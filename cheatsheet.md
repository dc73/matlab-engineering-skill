# Cheatsheet — MATLAB Engineering

Quick decision guides distilled from the book + repo SKILL.md.

## Operator choice (Ch 3)

| Need | Use | Avoid |
|---|---|---|
| Solve `A*x = b` | `x = A \ b` | `inv(A)*b` |
| Per-element scale | `v .* s`, `v .^ 2` | `v * s` when shapes don't match |
| Transpose (complex) | `'` conjugates, `.'` doesn't | Picking by habit |
| Compare floats | `abs(a-b) <= tol` | `a == b` |

## Root-finding (Ch 9)

| Situation | Do |
|---|---|
| Polynomial equation | `roots(p)` (Ch 8) |
| General equation, one crossing | `fzero(f, [a b])` with a sign-change bracket from `fplot` |
| Minimum | `fminbnd(f, a, b)` |
| Maximum | `fminbnd(@(x) -f(x), a, b)` |
| No bracket, only a guess | `fzero(f, x0)` — risk of wrong root or NaN; verify with `fval` |

## ODE choice (Ch 9, repo SKILL.md)

| System | Solver |
|---|---|
| Non-stiff first-order IVP | `ode45` |
| Stiff (time-scale separation) | `ode15s` / `ode23s` (only with evidence) |
| Closed-form needed | `dsolve` (Ch 11) |

Validation invariants: conservation (energy/angular momentum), state ordering identical across init/dynamics/events/plots, convergence under tighter tolerances.

## Interpolation vs. fitting (Ch 8)

| Goal | Tool |
|---|---|
| Pass through data points | `interp1(xd, yd, xq, method)` — `'pchip'` for monotone data, `'spline'` for smooth, `'linear'` default |
| Model the trend | `polyfit(xd, yd, n)` — smallest `n` that fits; check residuals |

## Grid & surface plots (Ch 10)

| Step | Command |
|---|---|
| 1. Grid | `[X, Y] = meshgrid(x, y)` |
| 2. Values | `Z = X.*Y.^2./(X.^2 + Y.^2)` (element-wise) |
| 3. Render | `mesh(X, Y, Z)` or `surf(X, Y, Z)` |
| Camera | `view(az, el)`, `cam` |

## Symbolic vs. numerical (Ch 11)

| Need | Use |
|---|---|
| Exact expression | `syms`, `diff`, `int`, `solve`, `dsolve` |
| Numeric answer | `fzero`, `fminbnd`, `integral`, `ode45` |
| Bridge symbolic → numeric | `subs(expr, [x], [val])` |

## Smells (fast heuristics)
- `inv(` in new code → replace with `\`.
- `a(end+1) =` inside a loop → preallocate with `zeros`.
- `fzero` returning `NaN` → no crossing in the bracket; re-bracket via `fplot`.
- Coefficient vector typed low-to-high → mirrored polynomial.
- `clear all` in a script → too destructive mid-run.
- `==` on floats → tolerance check.
- `ode45` on a stiff system → check for stiffness evidence before switching.
