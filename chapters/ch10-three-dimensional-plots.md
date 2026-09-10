# Chapter 10: Three-Dimensional Plots

## Core Idea
3-D plots extend Chapter 5's 2-D plotting to functions of two independent variables (x, y → z). The core pattern: build a grid with `meshgrid`, compute z element-wise on that grid, then render with `mesh`/`surf`/`plot3`.

## Frameworks Introduced
- **`plot3(x, y, z)`**: 3-D line plot connecting (x,y,z) points — same specifiers as 2-D `plot` (line style, color, markers).
- **Three-step surface pipeline** (Sections 10.2):
  1. `[X, Y] = meshgrid(x, y)` — X has identical rows, Y has identical columns.
  2. Compute `Z` element-wise: `Z = X.*Y.^2./(X.^2 + Y.^2)` (dot operators, Ch 3).
  3. Render: `mesh(X, Y, Z)` (wireframe) or `surf(X, Y, Z)` (shaded surface).
- **`contour` / `contour3d`**: 2-D contour lines or 3-D contour surfaces over the (x,y) domain.
- **`view` / `cam`**: control the camera azimuth/elevation and distance for 3-D views.

## Key Concepts
- **`meshgrid(x, y)`**: builds the X (rows of x) and Y (columns of y) matrices that match the grid layout.
- **Element-wise z computation**: X, Y, Z are same-size matrices; use `.*`, `.^`, `./` (Ch 3) — never matrix `*`.
- **Grid density**: the number of elements in `x` and `y` sets the resolution; endpoints are the domain boundaries.
- **`mesh` vs. `surf`**: mesh draws lines only (wireframe), surf fills and shades.

## Mental Models
- Think of the surface pipeline as "grid → values → render": always build the grid first, then compute, then plot.
- Use `meshgrid` rather than hand-building X/Y — it guarantees the row/column structure that `mesh`/`surf` expect.
- For smooth surfaces, increase the grid density (more points in `x` and `y`); for quick checks, a coarse grid suffices.

## Anti-patterns
- **Hand-building X/Y matrices**: `meshgrid` exists precisely to avoid the row/column structure bugs.
- **Using matrix `*` on the grid**: X, Y, Z are same-size matrices — use element-wise `.*`/`./`/`.^`.
- **Coarse grid for publication figures**: bump density before finalizing a figure.
- **Mixing 2-D and 3-D specifiers**: 3-D plots accept the same line/color/marker specifiers as 2-D (Ch 5) — keep them consistent.

## Key Takeaways
1. Surface plots follow grid (`meshgrid`) → element-wise z → `mesh`/`surf`.
2. `plot3` for 3-D line plots; same specifiers as 2-D `plot`.
3. Grid density (elements in `x`, `y`) controls resolution; endpoints bound the domain.
4. `contour`/`contour3d` for level sets; `view`/`cam` to aim the camera.
5. Use `meshgrid`, never hand-build X/Y.

## Connects To
- **Ch 3**: element-wise operators are how Z is computed on the grid.
- **Ch 5**: 3-D plotting is the direct extension of 2-D plotting (specifiers, formatting, `grid on`, labels).
- **Repo SKILL.md**: "visualization and reporting" is a separate layer from computation — keep plotting code out of numerical kernels.
