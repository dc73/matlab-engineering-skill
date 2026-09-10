# Chapter 6: Programming in MATLAB

## Core Idea
MATLAB programs extend simple sequential scripts with flow control: relational/logical operators (6.1), `if`/`elseif`/`else` (6.2), `switch` (6.3), and `for`/`while` loops (6.4). Decisions come from comparing values with `==`, `<`, `>`, `<=`, `>=`, `~=` combined with `&`, `|`, `~`.

## Frameworks Introduced
- **Relational operators**: `<`, `>`, `<=`, `>=`, `==`, `~=`. Array comparison is element-by-element and yields a logical array usable for **logical indexing** (extract elements where the mask is 1).
  - When to use: any branching or masked extraction.
  - Note: arithmetic operators bind tighter than relational ones; use parentheses to be explicit.
- **Logical operators**: `&` (AND), `|` (OR), `~` (NOT). Nonzero = true, zero = false.
- **`if`/`elseif`/`else`**: branch on a logical condition; the book's pattern is to keep the condition a single boolean expression.
- **`switch`/`case`**: multi-way branch on a discrete value (service type, category).
- **`for` loops**: iterate a known count (`for k = 1:n`). Preallocate any array the loop fills.
- **`while` loops**: iterate until a condition flips (e.g., error < tolerance in root-finding). Always include a max-iteration guard to prevent infinite loops.

## Key Concepts
- **Logical indexing**: `v(v > 0.5)` returns elements of `v` that satisfy the mask — a core MATLAB idiom replacing explicit loops for filtering.
- **Short-circuit vs. element-wise**: use `&&`, `||` for scalar control flow (short-circuit); use `&`, `|` for element-wise array logic.
- **`break` / `continue`**: exit a loop or skip to the next iteration.
- **`and`/`or`/`xor`/`any`/`all`**: convenience functions over arrays (`all(v > 0)`, `any(isnan(y))`).

## Mental Models
- Think of comparisons as producing logical masks, not just booleans — the mask *is* the filter.
- Use `for` for known iteration counts, `while` for convergence-based stops; always bound the `while` with a max iteration.
- Prefer logical indexing over explicit loops when filtering (`v(mask)`) — it is both faster and shorter.

## Anti-patterns
- **Growing arrays inside loops**: preallocate outside the loop (`a = zeros(n,1)`), then assign `a(k) = ...`.
- **Unbounded `while` loops**: without `if iter > maxiter, break`, a non-converging solver spins forever.
- **Using `&&` on arrays**: `&&` only accepts scalars; use `&` (or `all`/`any`) for arrays.
- **Nested `if` pyramids**: more than 2 levels deep — refactor into early returns or `switch`.
- **`==` on floats**: use a tolerance, not exact equality.

## Key Takeaways
1. Flow control = relational + logical operators driving `if`/`switch`/`for`/`while`.
2. Logical masks (`v(v > t)`) replace most filtering loops.
3. Preallocate loop output arrays before the loop body.
4. Bound every `while` loop with a max-iteration escape.
5. Scalar control flow: `&&`/`||`; array logic: `&`/`|` or `all`/`any`.

## Connects To
- **Ch 7**: user-defined functions wrap these constructs into reusable, validated units.
- **Ch 9**: `while` loops implement root-finding and ODE stepping; the convergence guard pattern is essential.
- **Repo SKILL.md**: "implement in small verifiable units" maps directly onto this chapter's function decomposition.
