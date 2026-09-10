<div align="center">

![MATLAB Engineering — one rigorous engineering brain shared across AI agents](assets/matlab-engineering-hero.png)

# MATLAB Engineering Skill

### One engineering brain. Every AI agent. MATLAB you can trust.

[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-portable-ff8c00?style=for-the-badge)](SKILL.md)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2016a%2B-0076a8?style=for-the-badge)](https://www.mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-34a853?style=for-the-badge)](LICENSE)

**A host-neutral skill that teaches AI coding agents to design, debug, review, and validate serious MATLAB engineering software.**

[Install](#install-in-seconds) · [What it changes](#what-it-changes) · [Knowledge map](#knowledge-map) · [Use it](#put-it-to-work)

</div>

---

MATLAB code can look convincing while being dimensionally wrong, numerically fragile, or physically impossible. This skill gives an agent a contract-first engineering workflow: preserve equations and units, catch MATLAB-specific traps, build numerical evidence, and say plainly when execution was not possible.

It is **not tied to a model, vendor, IDE, or tool protocol**. The repository follows the portable Agent Skills convention: a root [`SKILL.md`](SKILL.md) with progressively disclosed Markdown references. Any agent that can load instruction files can use it; hosts with native skill discovery can install it directly.

## What it changes

| Without the skill | With the skill |
|---|---|
| “The plot looks right.” | Analytical cases, invariants, residuals, and convergence checks |
| Shapes inferred from context | Inputs, outputs, units, frames, and dimensions stated explicitly |
| `inv(A)*b`, accidental `*`, silent transpose bugs | Stable solves and intentional matrix/element-wise operations |
| Solver defaults accepted blindly | Tolerances, stiffness, exit flags, and termination criteria examined |
| Octave results presented as MATLAB proof | MATLAB execution reported honestly; Octave clearly labeled |
| One giant prompt loaded every time | Core rules first; topic chapters loaded only when relevant |

## Install in seconds

### Universal installer

Clone the repository, then point the installer at any agent's skills directory:

```bash
git clone https://github.com/dc73/matlab-engineering-skill.git
cd matlab-engineering-skill
./scripts/install.sh ~/.your-agent/skills
```

The installer creates a symlink named `matlab-engineering`, so updates are just `git pull`. Pass `--copy` if symlinks are unsuitable:

```bash
./scripts/install.sh --copy ~/.your-agent/skills
```

Common destinations:

| Agent host | User-level destination |
|---|---|
| Codex | `~/.codex/skills` |
| Claude Code | `~/.claude/skills` |
| Gemini CLI | `~/.gemini/skills` |
| Cursor | `~/.cursor/skills` |
| OpenCode | `~/.config/opencode/skills` |
| Any other agent | Its configured skills/instructions directory |

> Host paths can evolve. The only requirement is that the host loads the installed folder's `SKILL.md` and keeps its relative reference files beside it.

### Agent Skills CLI

If your host uses the cross-agent `skills` CLI:

```bash
npx skills add https://github.com/dc73/matlab-engineering-skill --skill matlab-engineering
```

### No native skill support?

Attach [`SKILL.md`](SKILL.md) as project instructions, or ask the agent to read it before MATLAB work. Keep the `chapters/`, `cheatsheet.md`, `patterns.md`, and `glossary.md` files at the same relative paths.

## Put it to work

Most agents discover the skill automatically when MATLAB work appears. You can also invoke it explicitly:

```text
Use the matlab-engineering skill to implement a two-body orbital propagator.
State frames and units, add conservation-law tests, and run MATLAB validation.
```

```text
Review this Kalman filter for dimension, covariance, and numerical-stability bugs.
Do not change its public API.
```

```text
Use matlab-engineering ch09 to diagnose why this ode45 model diverges.
```

Every substantial result ends with the evidence that matters: changed files, assumptions, commands actually run, invariants checked, and an exact **passed**, **failed**, or **NOT EXECUTION-VALIDATED** status.

## Knowledge map

```text
SKILL.md                         contract → inspect → design → implement → validate
├── chapters/                   focused MATLAB knowledge, loaded on demand
│   ├── ch01–ch04               workspace, arrays, operators, scripts, data
│   ├── ch05–ch07               plots, programming, functions
│   └── ch08–ch11               fitting, numerical methods, 3D, symbolic math
├── cheatsheet.md               fast decisions and code-smell checks
├── patterns.md                 reusable numerical implementation patterns
└── glossary.md                 searchable MATLAB terminology
```

The engineering layer covers ODEs and dynamics, linear algebra and estimation, control systems, signal processing and FFTs, optimization, and orbital/aerospace simulations. The fundamentals are distilled from *MATLAB: An Introduction with Applications*, 6th edition, by Amos Gilat.

## Design principles

- **Evidence over appearance.** A clean figure is not a test.
- **Math before syntax.** Equations, units, frames, shapes, and tolerances form the contract.
- **Progressive disclosure.** Agents load only the chapter relevant to the task.
- **Host neutrality.** Instructions describe outcomes and capabilities, not one vendor's tools.
- **Honest verification.** No MATLAB runtime means no claim of MATLAB execution.
- **User intent stays sovereign.** Existing APIs, conventions, and unrelated changes are preserved.

## Requirements

The skill itself requires only Markdown. Executing and validating generated code requires MATLAB on `PATH`; individual tasks may require domain toolboxes. The knowledge material uses MATLAB R2016a as a broad baseline, while newer language features must be gated by the target release.

## Contributing

Contributions are welcome, especially minimal reproductions of MATLAB-specific failure modes, stronger numerical invariants, and release-compatibility corrections. Keep guidance compact, technically defensible, and useful across agent hosts.

## License and artwork

Code and written skill material are available under the [MIT License](LICENSE). The original README artwork was generated for this project with OpenAI image generation.

<div align="center">

**Make plausible MATLAB code prove itself.**

</div>
