# Chapter 11: Symbolic Math

## Core Idea
Symbolic operations (Symbolic Math Toolbox, executed by MuPad) let you manipulate expressions with unassigned variables — differentiation, integration, equation solving, and symbolic plotting — in contrast to the numerical-only work of Chapters 1–10.

## Frameworks Introduced
- **Symbolic objects**: created with `sym('x')` (single object) or `syms y z d` (batch). These are the atoms of symbolic math.
- **Symbolic expressions**: `expr = 2*a/3 + 4*a/7 - 6.5*x + x/3 + 4*5/3 - 1.5` — MATLAB simplifies exactly (no float approximation) at creation.
- **Solving equations**: `solve(eq, var)` returns symbolic solutions in terms of the other variables.
- **Calculus**: `diff(expr, var)` for derivatives, `int(expr, var)` for integrals (indefinite by default; specify limits for definite).
- **ODE solving**: `dsolve(ode, cond)` for differential equations with initial conditions.
- **Symbolic plotting**: `fplot` / `ezplot` (legacy) render symbolic functions directly.
- **Numerical use of symbolic expressions**: substitute values (`subs(expr, [x], [val])`) to feed into numerical code.

## Key Concepts
- **`sym` vs `syms`**: `sym` creates one object (from a string or number); `syms` creates several same-named symbolic variables in one call.
- **Exact arithmetic**: `1/3` stays `1/3` symbolically; numerical mode would give `0.3333`.
- **Toolbox check**: `ver` lists installed toolboxes — the Symbolic Math Toolbox is required; included in Student, separate purchase in standard MATLAB.
- **MuPad engine**: the symbolic functions are executed by the embedded MuPad; the commands keep MATLAB's syntax.

## Mental Models
- Think of symbolic variables as "placeholders with no numeric value" — the operations run on the expression itself, not on numbers.
- Use `syms` to declare all needed variables in one line, then build expressions from them.
- When a symbolic result must drive numerical code, use `subs` to instantiate it rather than re-deriving.

## Anti-patterns
- **Mixing symbolic and numerical variables in one expression**: a numeric variable (e.g., a preassigned `b`) in a symbolic expression forces numerical evaluation — keep the expression fully symbolic or fully numerical.
- **Forgetting the Symbolic Math Toolbox**: `sym`/`syms` error without it; check `ver` first.
- **Using `int` without limits for definite integrals**: specify `[var, a, b]` for definite results.
- **Trusting `solve` without checking assumptions**: symbolic solutions may be parametric or conditional; verify against a numerical check before using them.
- **Re-deriving instead of `subs`**: if you already have a symbolic expression, substitute values with `subs` — don't re-type the math.

## Key Takeaways
1. `sym`/`syms` create the symbolic objects; expressions built from them are simplified exactly.
2. `solve`, `diff`, `int`, `dsolve` cover equations, derivatives, integrals, and ODEs.
3. The Symbolic Math Toolbox (MuPad engine) is required — check `ver`.
4. `subs` bridges symbolic results into numerical code.
5. Keep expressions fully symbolic (no preassigned numeric variables) to preserve exactness.

## Connects To
- **Ch 8**: polynomial `roots` (numerical) vs. symbolic `solve` — pick by whether the equation is a polynomial.
- **Ch 9**: `dsolve` is the symbolic counterpart to `ode45` (numerical ODEs); use `dsolve` for closed-form, `ode45` for general IVPs.
- **Repo SKILL.md**: "do not use for symbolic derivations that will not become MATLAB code" — the description's scope gate matches this chapter's symbolic domain.
