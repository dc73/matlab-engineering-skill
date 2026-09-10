# matlab-engineering-skill — MATLAB engineering skill for all agent hosts

A cross-agent skill for writing, debugging, and validating complex MATLAB code. It enforces mathematical correctness, unit and dimension checks, defensive implementation, numerical testing, and execution-based verification across aerospace simulations, orbital mechanics, control systems, ODEs, signal processing, estimation, and optimization. The knowledge base is distilled from *MATLAB: An Introduction with Applications* (6th ed., Amos Gilat) plus an engineering-rigor layer.

Not a MATLAB IDE or toolbox replacement — it shapes how you reason about and verify MATLAB code in any agent host (OpenCode, Copilot CLI, Claude Code, Amp, Codex, Hermes).

## Highlights

- **Contract-first workflow**: mathematical/software contract, input/output specs, failure behavior — before touching code
- **Operator discipline**: matrix vs. element-wise, `A\b` over `inv`, intentional transpose choice
- **Execution-based verification**: `matlab -batch` test runs, numerical invariants (conservation, symmetry, convergence), honest `NOT EXECUTION-VALIDATED` reporting
- **Book-derived chapter knowledge**: 11 chapters (arrays → symbolic math) loaded on demand
- **Cross-agent installable**: root-level `SKILL.md` + `chapters/` layout works with the `npx skills add` CLI

## Skill layout

| File | Purpose |
|---|---|
| `SKILL.md` | Core frameworks, chapter/topic index, usage hints |
| `chapters/` | 11 per-chapter summaries (on-demand) |
| `glossary.md` | Alphabetical term index with chapter refs |
| `patterns.md` | Concrete techniques and decision patterns |
| `cheatsheet.md` | Quick decision tables and "smells" heuristics |

## Installation

Install globally (any cross-agent host):

```bash
npx skills add https://github.com/dc73/matlab-engineering-skill --skill matlab-engineering
```

Or clone manually:

```bash
git clone https://github.com/dc73/matlab-engineering-skill.git
mkdir -p ~/.agents/skills
cp -R matlab-engineering-skill ~/.agents/skills/matlab-engineering
```

For OpenCode specifically, `~/.config/opencode/skills/matlab-engineering` also works.

## Usage

OpenCode (and other hosts) discover the skill automatically for MATLAB tasks. Request it explicitly:

```text
Use the matlab-engineering skill. Build and execution-validate this MATLAB implementation:
[requirements]
```

With a topic: `matlab-engineering root-finding` → loads ch09.
With a chapter: `matlab-engineering ch05` → loads that chapter file.

## Requirements

- MATLAB R2016a or newer (the book's baseline); Symbolic Math Toolbox for ch11 topics
- `matlab` on PATH for execution validation; Octave is a labeled compatibility smoke test only

## License

MIT — synthesized summaries, not raw book text.
