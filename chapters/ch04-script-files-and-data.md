# Chapter 4: Using Script Files and Managing Data

## Core Idea
Script files run top-to-bottom in the shared MATLAB workspace; variables can be defined inside the script, in the Command Window, or imported from external files. This chapter also covers displaying, saving (`.mat`), and importing/exporting data.

## Frameworks Introduced
- **Three ways to define script inputs**:
  1. Hardcode assignments in the script (edit + re-run for new values).
  2. Assign in the Command Window before running (re-run with new values without editing the script).
  3. Import from external files via `load`, `dlmread`, `csvread`, `importdata`, or `textread` — the data enters the workspace as variables.
  - When to use 2: parameterized runs where only values change.
  - When to use 3: when data lives outside MATLAB (CSV, Excel, binary).
- **Data persistence**: `save filename var1 var2` writes variables to a `.mat` file; `load filename` restores them. Use versioned filenames (`data_v2.mat`) for experiments.
- **Display control**: `disp` for labeled output, `fprintf` for formatted output, `diary` to log the Command Window session.

## Key Concepts
- **Shared workspace**: Command Window and script files share one memory space; function files (Ch 7) do NOT.
- **`who` / `whos`**: audit what's in the workspace (name, class, size, bytes).
- **Workspace Window / Variable Editor**: GUI view/edit of workspace variables (double-click a variable to edit in a table).
- **`clear varname` / `clear all`**: remove variables; `clear all` also clears functions and caches.
- **File I/O**: `load`/`save` for `.mat`; `csvread`/`dlmread`/`importdata` for tabular data; `type` prints a text file.

## Mental Models
- Think of the workspace as a shared blackboard: anything written by the Command Window or a script is visible to everything in the session; function files write on their own separate board.
- Use `whos` as your first diagnostic when a variable "looks wrong" — it surfaces class and size before you dig into values.
- Treat `save`/`load` as experiment checkpoints: name `.mat` files per experiment so you can replay or compare.

## Anti-patterns
- **Global workspace coupling**: script files and the Command Window share variables; avoid relying on variables defined "elsewhere" without knowing which file created them.
- **`clear all` in the middle of a script**: it wipes functions and caches too; prefer `clear` with specific names.
- **Reading CSV with `csvread` on modern MATLAB**: prefer `readtable`/`readmatrix` (or `dlmread` for delimited text).
- **Trusting `disp` for precise numeric work**: `disp` prints with the current display format; use `fprintf` with explicit format specifiers.

## Key Takeaways
1. Scripts run sequentially in the shared workspace; function files (Ch 7) use a private workspace.
2. Parameters can live in the script, the Command Window, or imported files — pick the one matching how you re-run.
3. `save`/`load` give reproducible experiment checkpoints.
4. Use `whos` to audit before trusting any variable.
5. `clear` specific names; reserve `clear all` for session resets.

## Connects To
- **Ch 1**: script-file basics (`cd`, current folder) are the entry point.
- **Ch 6**: flow control (if/for/while) extends script structure beyond sequential execution.
- **Ch 7**: function files introduce local workspaces and input validation (`arguments`).
