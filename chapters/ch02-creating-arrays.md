# Chapter 2: Creating Arrays

## Core Idea
The array is MATLAB's fundamental data form — scalars, vectors, matrices, and higher-dimensional arrays are all arrays. This chapter covers creating 1-D vectors and 2-D matrices, plus the special constructors `zeros`, `ones`, `eye`, `linspace`, and `rand`.

## Frameworks Introduced
- **Vector construction patterns**:
  - Known list: `v = [1 2 3 4]` or `v = [1; 2; 3; 4]` (row vs. column)
  - Constant spacing: `1:3:15` (start:step:stop)
  - Linear spacing: `linspace(0, 1, 6)` (first, last, N points)
  - When to use: use `:` or `linspace` for evenly spaced grids (time vectors, axes) rather than typing elements.
- **Matrix construction**: `A = [1 2; 3 4]` — `;` separates rows, spaces separate columns.
- **Special matrices**: `zeros(m,n)`, `ones(m,n)`, `eye(n)` — always preallocate with these instead of growing arrays in a loop.
- **Random data**: `rand(n)`, `randi`, `randn` — for test or Monte-Carlo data.

## Key Concepts
- **Row vector**: one row (`[1 2 3]`); **column vector**: one column (`[1; 2; 3]`). Orientation is a property, not a typo.
- **Matrix**: 2-D numeric array; rows separated by `;`.
- **`:` colon operator**: `a:b:c` produces an evenly spaced vector; `a:b` is spacing 1.
- **`linspace`**: N evenly spaced points between two endpoints — the go-to for axis vectors.
- **String arrays**: character lists (section 2.10); used later for plot labels (Ch 5) and function arguments (Ch 7).

## Mental Models
- Think of any number you type as a 1x1 array; the "everything is an array" mental model starts here.
- Use `zeros`/`ones`/`eye` as preallocation tools: decide sizes up front, never grow arrays in a loop.
- Treat orientation (row vs. column) as a semantic choice: state vectors in Ch 9 ODE work must have consistent orientation.

## Anti-patterns
- **Growing arrays in loops**: appending in a loop (`a(end+1) = ...`) is slow; preallocate with `zeros(n)` and index into it.
- **Mixing `:` and `linspace` endpoints**: `1:10` includes 10; `linspace(1, 10, 10)` includes both endpoints — check which endpoint behavior your grid needs.
- **Typing long element lists** when `:`/`linspace` covers it.
- **Ignoring string arrays**: strings are first-class arrays used in plotting and function arguments.

## Key Takeaways
1. Vectors: use `[list]`, `start:step:stop`, or `linspace` — not hand-typed long lists.
2. Matrices: `;` separates rows; `zeros`/`ones`/`eye` are your preallocation tools.
3. Orientation (row vs. column) is meaningful — fix it deliberately.
4. Strings are arrays too; remember they carry into plotting (Ch 5) and function args (Ch 7).

## Connects To
- **Ch 3**: the arrays created here are operated on with `*`, `.*`, matrix power, etc.
- **Ch 5**: `linspace` vectors become axis vectors for plots.
- **Ch 9**: state vectors for ODEs must have consistent orientation from this chapter's row/column distinction.
