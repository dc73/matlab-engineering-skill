---
name: matlab-engineering
description: Design, write, debug, review, and validate nontrivial MATLAB scripts, functions, simulations, numerical algorithms, control models, signal processing, optimization, and aerospace engineering code. Use whenever MATLAB or Simulink code must be mathematically and numerically correct, especially for complex multi-file work. Do not use for Python-only or symbolic derivations that will not become MATLAB code.
license: MIT
metadata:
  audience: engineers-and-researchers
  language: matlab
---

# MATLAB Engineering

Produce MATLAB code that is correct by construction and supported by evidence. Treat plausible-looking output as insufficient.

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
