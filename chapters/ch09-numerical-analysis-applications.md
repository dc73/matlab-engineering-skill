# Chapter 9: Applications in Numerical Analysis

## Core Idea
MATLAB's numerical-analysis toolkit: `fzero` for root-finding, `fminbnd`/`fminunc` for extrema, `quad`/`quadv` for numerical integration, and `ode45` (RK45) for first-order ODEs. This chapter is where the function-file and anonymous-function patterns from Ch 7 become the glue between your math and MATLAB's solvers.

## Frameworks Introduced
- **`fzero(function, x0)`**: finds a zero where the function *crosses* the x-axis.
  - `function` as string (no predefined variables allowed) or as a function handle (preferred — more efficient, see Ch 7.9.1).
  - `x0`: scalar guess near a crossing, or a two-element bracket `[a b]` with `f(a)` and `f(b)` of opposite sign.
  - Output: `[x, fval] = fzero(...)` also returns the residual; `optimset('display','iter')` shows iterations.
  - Limitation: finds crossings only — a root where the curve merely touches the axis is missed.
  - If no solution is found, returns `NaN`.
- **`fminbnd(f, a, b)` / `fminunc(f, x0)`**: local minimum within a bound or unbounded. For a maximum, minimize the negative of the function.
- **Numerical integration**: `quadl`/`quadg` (legacy) or `integral` (modern): `[val, err] = quad(f, a, b)` — adaptive Simpson/Gauss-Kronrod; returns the estimate and an error bound.
- **`ode45(@rhs, tspan, y0)`**: explicit Runge-Kutta (4,5) for non-stiff first-order ODE systems.
  - `@rhs` is an anonymous function (Ch 7.8); `tspan` is `[t0 tfinal]`; `y0` is the initial state vector (orientation from Ch 2/3).
  - Output: `[t, Y]` where each row of `Y` is the state at the corresponding `t`.
  - Stiff systems need `ode15s`/`ode23s` — only switch when the evidence (time-scale separation) supports it (matches the repo SKILL.md rule).

## Key Concepts
- **Function-handle passing**: `fzero`, `fminbnd`, `integral`, `ode45` are "function functions" (Ch 7.9) — they take another function as an argument.
- **Bracketing for `fzero`**: a two-element `x0` must straddle a sign change; plot the function first (`fplot`) to locate brackets.
- **State-vector orientation**: `ode45` returns `Y` as rows of states over time — keep state ordering identical across init, dynamics, events, plotting (repo SKILL.md).
- **Residual check**: `[x, fval] = fzero(...)` lets you verify the found root by checking `abs(fval)` is small.

## Mental Models
- Think of `fzero` as "find where the curve crosses zero" — it will not find tangent roots.
- Use `fplot` before root-finding: the plot tells you how many roots exist and where to bracket.
- Treat `ode45` output `Y` as a state-history table: rows = time samples, columns = state variables — don't transpose by habit.
- For maxima, minimize `-f(x)` with `fminbnd`/`fminunc`.

## Anti-patterns
- **String functions with predefined variables**: `'x*exp(-x)-b'` fails if `b` is a variable — inline the constant (`'x*exp(-x)-0.2'`).
- **Unbracketed `fzero` with a bad scalar guess**: a scalar `x0` far from a root can converge to the wrong root or fail; use a bracket from `fplot`.
- **Using `ode45` for stiff systems**: without evidence of stiffness, RK45 is fine; switch to an `ode*s` solver only when time-scale separation demands it.
- **Ignoring `fval`**: always capture `[x, fval]` and assert `abs(fval) < tol` — a root finder returning `x` with a large residual is not a root.
- **Mixing row/column state conventions**: `ode45`'s `Y` is time × states; keep it consistent with your dynamics function's output orientation.

## Key Takeaways
1. `fzero(function, x0)`: crossings only; bracket with a sign-change pair from a `fplot`.
2. `fminbnd`/`fminunc` for minima; minimize the negative for maxima.
3. `integral`/`quad` for numerical integration with an error bound.
4. `ode45(@rhs, tspan, y0)` for non-stiff first-order ODEs; `Y` rows are states over time.
5. Always check the residual (`fval`) and state ordering before trusting a solver's output.

## Connects To
- **Ch 7**: anonymous functions and function handles are the mechanism this chapter relies on.
- **Ch 8**: polynomial `roots` can replace `fzero` when the equation is a polynomial.
- **Repo SKILL.md**: "check conserved quantities, equilibrium cases, and convergence under tighter tolerances" applies directly to `ode45` validation.
