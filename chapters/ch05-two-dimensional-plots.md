# Chapter 5: Two-Dimensional Plots

## Core Idea
`plot(x, y)` draws line segments connecting (x[i], y[i]); x and y must be same-length vectors. Optional string specifiers control line style, color, and markers. This chapter is the core of 2-D visualization: linear, semi-log, log-log, bar, stairs, polar, and subplot layouts.

## Frameworks Introduced
- **Plot command forms**:
  - `plot(y)` — plots element values vs. element index.
  - `plot(x, y)` — the standard form; x is abscissa, y is ordinate.
  - `plot(x, y, 'spec')` — spec string combines line style (`-`, `--`, `:`, `-.`), color (`r`,`g`,`b`,`c`,`m`,`y`,`k`,`w`), and marker (`o`,`s`,`^`,`v`,`p`,`*`).
- **Axis scaling**: `semilogx`, `semilogy`, `loglog` — use when data spans orders of magnitude (e.g., frequency response, decay curves).
- **Alternative plot types**: `bar`, `stairs`, `polar`, `hist`, `compass` — pick by data type, not habit.
- **Multiple curves / subplots**: `hold on` overlays curves in one axes; `subplot(m,n,k)` tiles several plots on one figure; `legend` labels overlaid curves.

## Key Concepts
- **Line specifiers**: `-` solid (default), `--` dashed, `:` dotted, `-.` dash-dot.
- **Color specifiers**: `r g b c m y k w`.
- **Markers**: `o` circle, `s` square, `^` up-triangle, `v` down-triangle, `p` pentagon, `*` star.
- **Figure Window**: opens automatically on the first plotting command; one figure per window; `close`/`close all` manage it.
- **Formatting**: `title`, `xlabel`, `ylabel`, `grid on`, `legend`, `text` for annotations, `axis` to set limits.

## Mental Models
- Think of `plot(x,y)` as connecting points in order — a non-monotonic x produces zig-zags; sort x first if your data is unsorted.
- Use `hold on` to compare model vs. measured data in one figure (the book's Figure 5-1 pattern: solid theory, dashed+markers for experiment).
- Choose `semilogy`/`loglog` when a quantity decays/exponentially — linear axes hide the shape.

## Anti-patterns
- **Forgetting `hold on`**: a second `plot` in the same axes replaces the first curve unless `hold on` is set.
- **Unsorted x data**: `plot` connects elements in array order; unsorted x gives criss-cross lines.
- **Linear axes for exponential data**: use semi-log/log-log; otherwise the decay looks like a flat line.
- **Cluttered subplots**: more than ~4-6 subplots per figure hurts readability; split into multiple figures.
- **Hardcoded figure size**: use `figure('Position', ...)` or `set(gcf, 'PaperSize', ...)` for publication-ready output instead of resizing by hand.

## Key Takeaways
1. `plot(x,y)` requires equal-length x, y; the first vector is always the abscissa.
2. Spec strings let you set line style + color + marker in one call: `plot(x, y, 'r--o')`.
3. `hold on` + `legend` is the standard pattern for overlaying model vs. data.
4. Use `semilogx`/`semilogy`/`loglog` for exponential or wide-range data.
5. `subplot(m,n,k)` for multi-panel figures; keep panel counts small.

## Connects To
- **Ch 2**: `linspace` vectors (time, frequency grids) feed the x-axis.
- **Ch 10**: 3-D plots (`surf`, `mesh`, `contour3d`) extend this chapter.
- **Repo SKILL.md**: plotting is one of the "visualization and reporting" layers to keep separate from computation.
