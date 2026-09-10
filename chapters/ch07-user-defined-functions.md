# Chapter 7: User-Defined Functions and Function Files

## Core Idea
A function file turns a computation into a reusable, independently testable building block: `function [outs] = name(ins)` as the first line, a local workspace (not shared with the session), and `end` to close it. This is the chapter that makes large MATLAB programs composable.

## Frameworks Introduced
- **Function file anatomy** (Section 7.2):
  - Line 1: `function [outs] = name(ins)` — must be the first executable line; its presence is what marks a function file.
  - Comments block: syntax, inputs, outputs, units, assumptions, minimal example.
  - Body: computation in terms of the input arguments (scalars, vectors, or arrays).
  - `end`: closes the definition (optional for simple functions; required when subfunctions or local functions are present).
- **Local workspace**: function files do NOT share variables with the Command Window or scripts — the only data paths are the declared inputs/outputs (plus explicit file I/O or `input`/`disp`/`plot`).
- **Variants**:
  - **Anonymous functions** (7.8): `f = @(x) x^2 + 1` — inline, no separate file; used as callbacks to built-ins like `fzero`, `fminbnd`, `integral`.
  - **Function functions** (7.9): pass function handles to built-ins (`fzero(@(...), x0)`, `fminbnd(f, a, b)`, `ode45(@rhs, tspan, y0)`).
  - **Subfunctions / nested functions** (7.10/7.11): multiple functions in one file; subfunctions are private, nested functions close over outer variables.
- **Input validation**: the book's base pattern is manual `if` checks on the arguments; modern MATLAB adds `arguments` blocks (release-dependent) for typed/validated interfaces.

## Key Concepts
- **Function definition line**: `function [mpay, tpay] = loan(amount, rate, years)` — names must follow variable naming rules; never shadow built-ins.
- **Argument passing**: inputs are values (scalars/vectors/arrays/strings); outputs are assigned inside the body.
- **`@(x) expr` anonymous function**: one-line callable; ideal for solvers that take a function handle.
- **Subfunctions**: defined after the main function, callable only within that file.
- **Nested functions**: defined inside the main function; can read (and, in modern MATLAB, write to) outer variables via closure.
- **`persistent`**: keeps a variable's value across calls — use sparingly and document it.

## Mental Models
- Think of a function file as a black box with declared ports: data enters only through inputs and leaves only through outputs (or explicit I/O).
- Use anonymous functions as the "glue" between your math and MATLAB's solvers (`fzero`, `fminbnd`, `ode45`).
- Decompose big programs into small, independently testable functions — the repo SKILL.md's "implement in small verifiable units" rule.

## Anti-patterns
- **Shadowing built-ins**: naming a function `sum.m` or `plot.m` hides the built-in; check with `which`.
- **Global variables in functions**: reaching for `evalin`/`assignin` or a global `g` breaks encapsulation; pass data through arguments.
- **Undocumented `persistent`**: hidden state that survives calls is a classic source of "it worked yesterday" bugs.
- **Omitting input validation**: the repo baseline requires validating inputs at the boundary; the book's manual `if` checks are the minimum.
- **Mixing script and function in one file**: the first line decides the file type; a `function` line makes it a function file — no script statements allowed at top level.

## Key Takeaways
1. `function [outs] = name(ins)` as line 1 is what makes a file a function file.
2. Function files use a private workspace; only declared inputs/outputs cross the boundary.
3. Anonymous functions (`@(...)`) are the bridge to MATLAB's solver APIs (`fzero`, `fminbnd`, `ode45`).
4. Subfunctions keep helpers private to the file; nested functions add closure over outer state.
5. Validate inputs at the boundary (manual `if` or `arguments` block) before doing the math.

## Connects To
- **Ch 6**: flow control inside function bodies (loops, conditionals).
- **Ch 9**: `ode45(@rhs, tspan, y0)` and `fzero(@f, x0)` from this chapter power the numerical-analysis applications.
- **Repo SKILL.md Phase 4**: "provide a concise help block with syntax, inputs, outputs, units, assumptions" maps to this chapter's comments block.
