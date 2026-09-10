# MATLAB Engineering Skill for OpenCode

A rigorous OpenCode skill for writing, debugging, and validating complex MATLAB code. It enforces mathematical correctness, unit and dimension checks, defensive implementation, numerical testing, and execution-based verification across aerospace simulations, orbital mechanics, control systems, ODEs, signal processing, estimation, and optimization.

## What it enforces

- Mathematical, dimensional, unit, frame, and interface checks before implementation
- Correct matrix and element-wise MATLAB operations
- Explicit state ordering, solver assumptions, tolerances, and failure behavior
- Analytical, nominal, boundary, invalid-input, and regression tests
- Numerical invariants such as conservation, orthogonality, covariance symmetry, residuals, and convergence
- Honest validation reporting when MATLAB cannot be executed

## Install globally

```bash
git clone https://github.com/dc73/matlab-engineering-skill.git
mkdir -p ~/.config/opencode/skills
cp -R matlab-engineering-skill/matlab-engineering ~/.config/opencode/skills/
```

Restart OpenCode after installation.

## Install for one project

From the target project's root directory:

```bash
mkdir -p .opencode/skills
cp -R /path/to/matlab-engineering-skill/matlab-engineering .opencode/skills/
```

## Usage

OpenCode can discover the skill automatically for MATLAB tasks. You can also request it explicitly:

```text
Use the matlab-engineering skill. Build and execution-validate this MATLAB implementation:
[requirements]
```

## License

MIT
