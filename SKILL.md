---
name: matlab-engineering
description: Design, write, debug, review, and validate nontrivial MATLAB scripts, functions, simulations, numerical algorithms, control models, signal processing, optimization, and aerospace engineering code. Use when MATLAB or Simulink work must be mathematically and numerically correct, especially for complex or multi-file tasks. Do not use for Python-only work or symbolic derivations that will not become MATLAB code.
license: MIT
metadata:
  audience: engineers-and-researchers
  language: matlab
---

# MATLAB Engineering

Produce MATLAB code that is correct by construction and supported by evidence. Treat plausible-looking output as insufficient.

This skill also distills the fundamentals taught in *MATLAB: An Introduction with Applications* (6th ed., Amos Gilat): arrays as MATLAB's core data structure, vector vs. matrix operations, script files, programming flow control, user-defined functions, and numerical-analysis applications. Per-chapter knowledge lives in `chapters/`; quick decision guides are in `cheatsheet.md`, techniques in `patterns.md`, and terms in `glossary.md`.

<!-- argument-hint: [topic, framework name, or chapter number] -->

## Portable operation

These instructions are host-neutral. Use the current agent's available filesystem, search, shell, documentation, and test capabilities; do not assume a particular vendor, tool name, or UI. Preserve normal authorization boundaries before external or destructive actions.

Resolve every relative link from the directory containing this `SKILL.md`. Load supporting material progressively:

- For a named chapter such as `ch05` or `ch09`, read only that chapter file.
- For a topic outside the core guidance, locate the matching chapter in the index and read it before answering.
- Read `cheatsheet.md` for fast operator or solver choices, `patterns.md` for reusable techniques, and `glossary.md` when terminology is unclear.
- Do not load all references by default.

## How to use this skill

- **Without arguments** — apply the core engineering workflow.
- **With a topic** — for `arrays`, `plotting`, `root-finding`, `ODEs`, `symbolic`, or another indexed topic, read the relevant chapter.
- **With a chapter** — for `ch05` or `ch09`, read that specific chapter file.
- **Browse** — when asked what is covered, show the chapter index.

For a topic not covered in Core Frameworks below, read the relevant chapter file before answering.

## Non-negotiable rules

1. Reconstruct the mathematical and software contract before editing code.
2. Inspect the relevant repository files, data shapes, call sites, tests, and toolbox constraints. Do not guess an existing interface.
3. Preserve the user's equations, coordinate frames, units, conventions, file layout, and public APIs unless a change is explicitly required.
4. Implement in small verifiable units. Separate computation from plotting, file I/O, UI, and workspace side effects.
5. Run MATLAB tests when MATLAB is available. A successful parse or a figure appearing is not proof of correctness.
6. Never claim code is validated unless it was executed and its numerical invariants were checked.
7. If MATLAB cannot run, perform static checks, provide a runnable validation command, and label the result `NOT EXECUTION-VALIDATED`.
8. Do not silently replace MATLAB behavior with GNU Octave behavior. Octave may be used only for a clearly labeled compatibility smoke test.

## Phase 1: Establish the contract

Before writing complex code, state or infer a compact contract containing:

- Required inputs, types, shapes, units, frames, domains, and valid ranges.
- Required outputs, shapes, units, frames, ordering, and tolerances.
- Governing equations or algorithm, including sign and normalization conventions.
- Initial conditions, boundary conditions, solver requirements, and stopping criteria.
- MATLAB release and required toolboxes when compatibility matters.
- Expected failure behavior for invalid, singular, empty, NaN, Inf, or out-of-range input.

Ask a question only when an unresolved item can materially change the result. Otherwise make the smallest reasonable assumption and record it in code comments or the final summary.

For equations, translate each symbol deliberately. Check dimensions and units before implementation. For matrix expressions, record expected dimensions beside non-obvious operations.

## Phase 2: Inspect before modifying

For an existing project:

- Locate the entry point, dependent functions, scripts, classes, tests, MAT files, configuration, and data import paths.
- Search every function being changed and inspect its callers.
- Determine whether the project relies on scripts sharing a base workspace. Avoid introducing hidden workspace coupling.
- Inspect existing naming, plotting, testing, error-handling, and toolbox conventions.
- Confirm whether arrays represent samples by rows or columns. Never infer this independently in different functions.
- Preserve unrelated user changes.

For a new project, prefer functions over monolithic scripts. Use a short driver script only to configure, call, and visualize the computation.

## Phase 3: Design the implementation

Decompose complex work into:

1. Pure numerical kernels.
2. Input validation and unit/frame conversion.
3. Solver or orchestration layer.
4. Visualization and reporting.
5. Automated tests and reference cases.

Prefer explicit data flow. Avoid `eval`, `evalin`, `assignin`, `clear all`, `close all`, `clc`, global variables, unexplained `persistent` state, and broad warning suppression.

Do not vectorize blindly. Choose the clearest implementation first, then optimize measured bottlenecks without changing numerical meaning.

## MATLAB correctness traps

Check each applicable item explicitly:

- Use `*`, `/`, and `^` for linear algebra; use `.*`, `./`, and `.^` for element-wise operations.
- Use `'` for conjugate transpose and `.'` for nonconjugating transpose. Choose intentionally.
- Distinguish row vectors, column vectors, pages, timetables, tables, cells, structs, and string arrays.
- Do not rely on implicit expansion unless the required MATLAB release supports it and the shapes are unambiguous.
- Preallocate arrays whose size is predictable.
- Avoid explicit matrix inversion. Use `A\b`, decompositions, or problem-specific solvers.
- Check conditioning, rank, singularity, scaling, cancellation, overflow, underflow, and division by nearly zero.
- Do not compare floating-point values with `==` unless exact representation is guaranteed. Use justified absolute and relative tolerances.
- Define angle units. MATLAB trig functions use radians; use `sind`, `cosd`, and related functions only for degrees.
- Define index meaning carefully: MATLAB indexing is one-based and inclusive.
- Confirm endpoint behavior in `colon`, `linspace`, interpolation grids, FFT frequency axes, and time vectors.
- Handle complex values intentionally. Never discard imaginary parts merely to silence a warning.
- Treat NaN and Inf deliberately; do not allow them to disappear through filtering without justification.
- Use deterministic random streams for reproducible tests.
- Keep local functions in valid locations for the supported MATLAB release.
- Use `arguments` blocks or `validateattributes` when they improve interface safety, but honor release compatibility.
- Never shadow MATLAB functions with variables or files such as `sum`, `mean`, `plot`, `table`, or `length`.

## Solver-specific requirements

### ODEs and dynamics

- Make state ordering explicit and keep it identical in initialization, dynamics, events, logging, and plotting.
- Confirm derivative output has the same orientation and length as the state.
- Pass parameters explicitly instead of depending on a mutable workspace.
- Choose tolerances from the scale and required accuracy, not by habit.
- Use events for physical termination conditions.
- Check conserved quantities, equilibrium cases, and convergence under tighter tolerances.
- Use stiff solvers only when the system or evidence supports that choice.

### Linear algebra and estimation

- Check dimensions and conditioning before solving.
- Preserve covariance symmetry numerically with `(P + P.')/2` when mathematically appropriate.
- Test positive semidefiniteness and innovation dimensions in filters.
- Prefer numerically stable factorizations and Joseph-form covariance updates when needed.

### Control systems

- State continuous versus discrete time and sample time.
- Confirm state, input, output, and feedthrough matrix dimensions.
- Check controllability and observability when relevant, while recognizing that rank tests can be scale-sensitive.
- Verify pole, frequency, and unit conventions.
- For discretization, record the method and sample time; do not substitute Euler integration without authorization.

### Signal processing and FFTs

- State sample rate, record length, window, normalization, one-sided/two-sided convention, and frequency units.
- Test with a synthetic signal whose amplitude and frequency are known.
- Treat spectral leakage, aliasing, detrending, and DC handling intentionally.

### Optimization

- Define decision-vector ordering, bounds, constraint sign conventions, scaling, and solver exit criteria.
- Independently evaluate the returned objective and constraints.
- Test sensitivity to starting points when local minima are possible.
- Report solver status rather than presenting any returned vector as a valid solution.

### Orbital and aerospace simulations

- State the frame for every vector: ECI, ECEF, LVLH/RTN, body, wind, or another named frame.
- State the epoch, time standard, gravity parameter, central body, and distance/time units.
- Distinguish active from passive rotations and document rotation order.
- Keep quaternion convention explicit: scalar-first/scalar-last and direction of mapping.
- Check handedness, right-hand rules, DCM orthogonality, determinant, and quaternion normalization.
- Validate two-body propagation against energy and angular-momentum conservation before adding perturbations.
- Add perturbations one at a time and compare against a simpler reference case.
- For attitude dynamics, verify inertia-tensor symmetry/positive definiteness and torque units.
- Never mix degrees and radians, kilometers and meters, or UTC and elapsed seconds implicitly.

## Phase 4: Implement defensively

Use meaningful names with units where ambiguity is likely, such as `time_s`, `position_eci_km`, or `sampleRate_Hz`. Add comments explaining equations, conventions, and non-obvious decisions; do not narrate obvious syntax.

For every public function:

- Provide a concise help block with syntax, inputs, outputs, units, assumptions, and one minimal example when useful.
- Validate inputs at the boundary.
- Keep output order and shape stable.
- Emit specific error identifiers for expected validation failures in reusable code.

Do not invent toolbox functions. Before using an unfamiliar API, inspect `help`, `doc`, `which`, project usage, or official MathWorks documentation. Check release availability and toolbox ownership.

## Phase 5: Build numerical evidence

Create or extend tests for the actual risk. Use `matlab.unittest` for reusable projects; a compact assertion-based test script is acceptable for a small standalone task.

Minimum test set for complex code:

1. A hand-calculable or analytically solvable case.
2. A nominal representative case.
3. A boundary or degenerate case.
4. Invalid-input behavior.
5. A regression case for the reported failure.
6. A numerical invariant or independent implementation when applicable.

Useful invariants include conservation laws, symmetry, monotonicity, normalization, orthogonality, positive semidefiniteness, dimensional consistency, bounded residuals, and agreement under grid or tolerance refinement.

Use tolerances based on scale and conditioning. Prefer a combined criterion such as:

```matlab
err = abs(actual - expected);
limit = absTol + relTol .* abs(expected);
assert(all(err <= limit, "all"), "Result exceeds absolute/relative tolerance.");
```

Do not generate expected values by calling the same implementation under test. Use an analytical result, trusted reference data, an independent formulation, or a simpler limiting case.

## Phase 6: Execute and diagnose

Prefer these commands from the project root when available:

```bash
matlab -batch "results = runtests; assertSuccess(results)"
matlab -batch "checkcode('path/to/file.m')"
```

For a targeted test:

```bash
matlab -batch "results = runtests('tests/TestName.m'); assertSuccess(results)"
```

Before running, use `which matlab` and inspect project instructions. Do not add paths recursively with `genpath` when it may include build, cache, private, generated, or conflicting directories.

When a test fails:

1. Preserve the complete error, stack, inputs, and failing assertion.
2. Determine whether the defect is in implementation, test oracle, assumptions, environment, toolbox availability, or data.
3. Fix the root cause.
4. Run the targeted test, then the relevant suite.
5. Check that the fix did not weaken tolerances or delete meaningful coverage.

Do not solve failures by commenting out assertions, widening tolerances without analysis, catching all errors, or suppressing warnings globally.

## Required completion report

Finish MATLAB work with:

- Files changed and their purpose.
- Mathematical assumptions, units, frames, and conventions that affect results.
- Validation commands actually run.
- Test cases and numerical invariants checked.
- Exact outcome: passed, failed, or `NOT EXECUTION-VALIDATED`.
- Remaining limitations, toolbox requirements, or unverified behaviors.

If results are not execution-validated, do not use phrases such as “fully working,” “correct,” or “production ready.”

## Core Frameworks & Mental Models
<!-- From Gilat, MATLAB: An Introduction with Applications, 6th ed. -->
- **Array-first mindset**: every value — including scalars — is an array. Use `zeros`/`ones`/`eye` to preallocate; never grow arrays in loops (Ch 2).
- **Operator discipline**: `*` = matrix product, `.*` = element-wise; `A\b` solves systems (avoid `inv`); `'` conjugates, `.'` doesn't. Pick the operator from the math, not convenience (Ch 3).
- **Workspace model**: Command Window and script files share one workspace; function files (Ch 7) use a private workspace. Audit with `whos` before trusting any variable (Ch 1, Ch 4).
- **Script vs. function files**: scripts run top-to-bottom in the shared workspace; function files are reusable, independently testable building blocks with declared inputs/outputs (Ch 4, Ch 7).
- **Flow control**: relational + logical operators drive `if`/`switch`/`for`/`while`; use logical masks (`v(v > t)`) instead of filtering loops; bound every `while` with a max iteration (Ch 6).
- **Function-handle solvers**: `fzero`, `fminbnd`, `integral`, `ode45` take a function (string, handle, or anonymous). Handles are preferred; strings can't reference predefined variables (Ch 7.9, Ch 9).
- **Root-finding**: `fzero` finds crossings only; bracket with `fplot` first; check the residual `[x, fval]` (Ch 9.1).
- **Polynomial toolkit**: coefficient vector = highest power first, zeros included; `polyval`/`roots`/`polyfit`/`polyder` (Ch 8).
- **Interpolation vs. fitting**: `interp1` passes through points (`'pchip'` for monotone data); `polyfit` models the trend with the smallest degree that fits (Ch 8).
- **Surface pipeline**: `meshgrid` → element-wise Z → `mesh`/`surf`; grid density controls resolution (Ch 10).
- **Symbolic math**: `syms`/`sym` create exact symbolic objects; `solve`, `diff`, `int`, `dsolve`; `subs` bridges to numerical code (Ch 11).

## Chapter Index

| # | Title | Key Frameworks |
|---|-------|----------------|
| [ch01](chapters/ch01-starting-with-matlab.md) | Starting with MATLAB | Calculator vs. script workflow, workspace model, display formats |
| [ch02](chapters/ch02-creating-arrays.md) | Creating Arrays | Vector/matrix construction, `zeros`/`ones`/`eye`, `linspace` |
| [ch03](chapters/ch03-math-operations-with-arrays.md) | Mathematical Operations with Arrays | Matrix vs. element-wise, `A\b`, transpose choice |
| [ch04](chapters/ch04-script-files-and-data.md) | Script Files and Managing Data | Three input modes, `save`/`load`, `disp`/`fprintf`, `whos` |
| [ch05](chapters/ch05-two-dimensional-plots.md) | Two-Dimensional Plots | `plot` specifiers, `hold on`+`legend`, semi-log/log-log, `subplot` |
| [ch06](chapters/ch06-programming-in-matlab.md) | Programming in MATLAB | Relational/logical operators, `if`/`switch`/`for`/`while`, logical masks |
| [ch07](chapters/ch07-user-defined-functions.md) | User-Defined Functions | Function file anatomy, local workspace, anonymous functions, subfunctions, `arguments` |
| [ch08](chapters/ch08-polynomials-curve-fitting.md) | Polynomials, Curve Fitting, Interpolation | Coefficient-vector convention, `polyval`/`roots`/`polyfit`, `interp1` |
| [ch09](chapters/ch09-numerical-analysis-applications.md) | Numerical Analysis | `fzero` bracketing, `fminbnd`, `integral`, `ode45` state ordering |
| [ch10](chapters/ch10-three-dimensional-plots.md) | Three-Dimensional Plots | `meshgrid` pipeline, `mesh`/`surf`, `plot3`, camera control |
| [ch11](chapters/ch11-symbolic-math.md) | Symbolic Math | `syms`/`sym`, `solve`/`diff`/`int`/`dsolve`, `subs` |

## Topic Index
- **`A\b` / left division** → ch03
- **`arguments` block** → ch07
- **`clear` / `who` / `whos`** → ch01, ch04
- **`csvread` / `importdata`** → ch04
- **`fzero`** → ch09
- **`fminbnd` / `fminunc`** → ch09
- **`integral` / `quad`** → ch09
- **`interp1` / interpolation** → ch08
- **`linspace` / `:`** → ch02
- **`meshgrid` / surface plots** → ch10
- **`ode45` / ODEs** → ch09
- **`polyfit` / `polyval` / `roots`** → ch08
- **`sym` / `syms` / symbolic** → ch11
- **`zeros` / preallocation** → ch02
- **arrays / vectors / matrices** → ch02, ch03
- **bracketing roots** → ch09
- **curve fitting** → ch08
- **element-wise vs. matrix ops** → ch03
- **flow control / loops / conditionals** → ch06
- **function files / anonymous functions** → ch07
- **interpolation** → ch08
- **numerical integration** → ch09
- **polynomials** → ch08
- **script files / workspace** → ch01, ch04
- **symbolic math** → ch11
- **tolerance-based assertions** → ch09 (repo SKILL.md)

## Supporting Files
- [glossary.md](glossary.md) — all key terms with chapter references
- [patterns.md](patterns.md) — concrete techniques and decision patterns
- [cheatsheet.md](cheatsheet.md) — quick reference tables and decision guides

## Scope & Limits
This skill covers MATLAB fundamentals (Gilat 6th ed.) plus the repo's engineering-rigor layer. For domain-specific MATLAB work (medical imaging, deep learning, wavelets), pair with the corresponding domain skills. Symbolic derivations that will not become MATLAB code are out of scope.
