# Chapter 1: Starting with MATLAB

## Core Idea
MATLAB is a workspace of variables plus a command interpreter: type expressions directly (calculator mode), or save a list of commands to a `.m` script file and run it. Everything lives in the Command Window / Editor / Figure windows of the desktop layout.

## Frameworks Introduced
- **Calculator vs. script-file workflow**: use the Command Window for quick single expressions; move repeated or multi-step work into a script file (`.m`) saved in the current folder, then execute by filename.
  - When to use: any computation you would re-type or that spans multiple lines.
  - How: Editor → New Script, type commands top-to-bottom, save, run.
- **Workspace model**: all variables created in the Command Window and in script files share one workspace (same memory space). `who`/`whos` list them; `clear` removes them. Function files (Ch 7) use a *separate* local workspace.
  - When to use: inspecting or cleaning up the session.
- **Display formats**: `format short` (default, 4 digits), `format long`, `format bank`, `format rat` for rational approximation of pi etc. Choose a format before comparing numeric outputs.

## Key Concepts
- **Command Window**: main entry point; `clc` clears it, `;` suppresses output.
- **Editor Window**: where scripts are written and debugged (F5 run, F9 break).
- **Script file**: a saved `.m` file executed in the shared workspace.
- **Current Folder**: where scripts must be saved so `run` can find them; change with `cd` or the Current Folder toolbar.
- **Predefined variables/keywords**: `pi`, `eps`, `realmax`, `ans`, `lasterr`, `inf`, `nan` — never shadow them with variables or filenames.

## Mental Models
- Think of MATLAB as an array machine: every value — including scalars — is an array.
- Use scripts as reproducible, savable, reviewable units of work instead of ad-hoc command typing.
- Use `whos` as a session audit: it shows name, class, size, bytes — the first stop when a variable looks wrong.

## Anti-patterns
- **Re-typing multi-step work in the Command Window**: save it as a script file; only one-off explorations belong in the Command Window.
- **Shadowing built-ins**: naming a variable `pi`, `ans`, or a file `plot.m` hides the built-in function and silently breaks calls to it.
- **Running scripts from the wrong folder**: if the current folder is not the script's folder, execution fails; `cd` first.
- **Trusting the default display**: `format short` rounds to 4 decimals; switch to `format long` before judging a numeric result.

## Key Takeaways
1. Every scalar you type in the Command Window is a one-element array; the array mindset starts here.
2. Move anything repeated or multi-line into a script file in the current folder.
3. The Command Window and script files share one workspace; function files (Ch 7) do not.
4. Pick the display format before comparing values.
5. Never name variables or files after MATLAB built-ins (`pi`, `ans`, `plot`, `sum`...).

## Connects To
- **Ch 2**: arrays introduced as the fundamental data form (vectors/matrices).
- **Ch 4**: script files and data I/O expand the script-file workflow.
- **Whos/who**: workspace inspection continues into Ch 4 data management.
