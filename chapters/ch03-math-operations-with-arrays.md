# Chapter 3: Mathematical Operations with Arrays

## Core Idea
Arrays support two kinds of operations: matrix (linear-algebra) operations using `*`, `/`, `\`, `^` and element-wise operations using `.*`, `./`, `.^`. Choosing the right kind is the central skill of this chapter.

## Frameworks Introduced
- **Matrix vs. element-wise decision rule**:
  - `*` = matrix product, `/` = matrix right division, `\` = matrix left division (solve `A*x = b` as `x = A\b`), `^` = matrix power.
  - `.*` `./` `.^` = element-wise multiplication, division, power.
  - When to use `A\b` over `inv(A)*b`: solving linear systems — `A\b` uses LU/Cholesky under the hood, faster and more stable than explicit inversion.
  - When to use `.*`: when you need each element scaled individually (e.g., `y = .*` per-sample), not a linear transformation.
- **Transpose choices**: `'` conjugate transpose vs `.'` plain transpose. Choose deliberately: for real data they coincide; for complex data only `'` conjugates.
- **Special matrix generators in computation**: `eye(n)` for identity, `diag(v)` for diagonal matrices, `triu`/`tril` for triangular parts.

## Key Concepts
- **Element-wise vs. matrix operations**: the dot prefix (`.*`) switches to per-element behavior — the single most common source of "why is my result a 1x1 or an error?".
- **Left division `\`**: solves systems; the recommended way to solve `Ax = b`.
- **Matrix power `^`**: integer powers via repeated multiplication.
- **Element-wise power `.^`**: raises each element.
- **Conjugate transpose `'`**: conjugates complex data; `.'` does not.

## Mental Models
- Use `A\b` instead of `inv(A)*b` — it is both faster and numerically better.
- Before multiplying two arrays, ask: linear transformation (`*`) or per-element scaling (`.*`)?
- For complex data, pick `'` vs `.'` intentionally; never default without thinking.
- Check shapes before operations: a (m×n) `*` (n×p) yields (m×p); a mismatch is the most common runtime error.

## Anti-patterns
- **Explicit `inv(A)`**: almost always use `A\b`; inversion wastes a full factorization and adds error.
- **Using `*` when you meant element-wise**: `v * v` is a matrix product (a scalar if both are column vectors); `v .* v` squares each element.
- **Using `.'` on complex data when conjugation is mathematically required** (or vice versa) — pick the operator that matches the math, not habit.
- **Growing arrays in loops** (from Ch 2): preallocate with `zeros`, assign by index.
- **Floating-point `==` comparisons**: use tolerance-based checks (`abs(a-b) < tol`), never `==`.

## Code Examples
```matlab
% Solve Ax = b
A = [1 2 3; 4 5 6; 7 8 10];
b = [1; 2; 3];
x = A \ b;            % preferred
x2 = inv(A) * b;      % avoid: slower, less stable

% Element-wise square of a vector
v = 1:5;
squared = v.^2;       % element-wise
dot = v' * v;         % matrix product: inner product (scalar)
```
- **What it demonstrates**: left division for systems, `.^` for per-element power, `'` for transpose giving an inner product.

## Key Takeaways
1. `*`/`/`/`\`/`^` = matrix ops; `.*`/`./`/`.^` = element-wise. Pick by the math, not by convenience.
2. Solve `Ax=b` with `A\b`; avoid `inv(A)`.
3. `'` conjugates complex data; `.'` does not.
4. Preallocate with `zeros`; never grow in a loop.
5. Compare floats with tolerances, never `==`.

## Connects To
- **Ch 8**: `polyfit`/`polyval` build on matrix operations for curve fitting.
- **Ch 9**: ODE state vectors (from Ch 2) combined with element-wise ops for dynamics.
- **Numerical invariants**: orthogonality, symmetry (`(A+A')/2`), conservation — the same checks the repo SKILL.md already requires.
