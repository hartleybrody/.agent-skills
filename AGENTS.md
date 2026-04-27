# AGENTS.md

This file provides guidance to AI coding agents working in this repository.

## Repository Overview

This is a collection of custom agent skills for Claude Code. Each skill is a self-contained prompt that extends an AI coding agent's capabilities with specialized workflows — committing, planning, PR review, CI debugging, and research.

Skills are pure Markdown instructions (no runtime code). They are installed by symlinking into `~/.claude/skills/`, where Claude Code discovers and loads them on demand. Humans invoke skills within an agent session via slash commands (e.g. `/commit`, `/pr-feedback`).

## Skill Format

Each skill is a directory containing a single `SKILL.md` file:

```
skill-name/
└── SKILL.md
```

`SKILL.md` uses YAML front matter for metadata and a Markdown body for the prompt instructions:

```yaml
---
name: skill-name          # Required. Kebab-case, matches directory name.
description: Short phrase  # Required. One line, shown in skill listings.
---

Prompt instructions the agent receives when this skill is invoked.
```

Keep the prompt concise and imperative. Include guardrails for actions the skill should NOT take automatically (e.g. "do NOT auto-commit").

## Directory Structure

```
.agent-skills/
├── install.sh              # Symlink manager
├── AGENTS.md               # This file (agent guidance)
├── CLAUDE.md               # Imports AGENTS.md for Claude Code
├── README.md               # Human-facing docs
├── commit/SKILL.md
├── plan-create/SKILL.md
├── plan-implement/SKILL.md
├── plan-update/SKILL.md
├── pr-ci-failures/SKILL.md
├── pr-feedback/SKILL.md
├── pr-local-ci/SKILL.md
└── research-latest/SKILL.md
```

## Installation

`install.sh` manages the connection between this repo and `~/.claude/skills/`:

- Creates a symlink in `~/.claude/skills/` for each skill directory
- Skips if a non-symlink already exists at the target path
- Removes stale symlinks that point to deleted skill directories in this repo
- Is idempotent — safe to re-run at any time

## Current Skills

| Skill | Description |
|-------|-------------|
| `commit` | Make a collaborative, descriptive commit |
| `plan-create` | Read research, context and intention to create a plan doc |
| `plan-implement` | Begin implementing from a plan doc |
| `plan-update` | Update the plan doc from user annotations |
| `pr-ci-failures` | Look for failing CI tests and fix issues |
| `pr-feedback` | Look at in-line code comments on PR and prepare response |
| `pr-local-ci` | Run all CI tests locally, push on success |
| `research-latest` | Get a deep understanding of a system, write research doc |

## Adding a New Skill

1. Create a new directory at the repo root with a kebab-case name
2. Add a `SKILL.md` file with `name` and `description` in the YAML front matter
3. Write the prompt instructions in the Markdown body
4. Run `./install.sh` to symlink into `~/.claude/skills/`
5. Update the skills table in this file and in `README.md`

## Removing a Skill

1. Delete the skill directory from this repo
2. Run `./install.sh` — it will clean up the stale symlink automatically

## Design Conventions

- **One file per skill**: Each skill is a single `SKILL.md`. No scripts, no build steps, no dependencies.
- **Guardrails**: Skills that modify code or git state should include explicit constraints (e.g. "only commit when explicitly asked", "do NOT push without asking").
- **Human checkpoints**: Multi-step workflows (plan-create -> plan-update -> plan-implement) separate phases so humans review between steps.
- **Output directories**: Skills that produce documents write to `.agents/` subdirectories:
  - `.agents/plan/` for implementation plans
  - `.agents/research/` for research reports
