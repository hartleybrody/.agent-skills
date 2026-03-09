# Agent Skills

A repository of custom agent skills for Claude Code.

## Installation

Run the install script to symlink all skills into `~/.claude/skills/`:

```sh
./install.sh
```

Each top-level directory is symlinked individually. Re-running the script links new skills and removes stale symlinks for skills that have been deleted from this repo.

## Skills

| Skill | Description |
|-------|-------------|
| `commit` | Make a collaborative, descriptive commit |
| `plan-create` | Read research, context and intention to create plan doc |
| `plan-implement` | Begin implementing from a plan doc |
| `plan-update` | Update the plan doc, from my annotations |
| `pr-ci-failures` | Look for failing CI tests and fix issues |
| `pr-feedback` | Look at in-line code comments on PR and prepare response |
| `pr-local-ci` | Run all CI tests locally, push on success |
| `research-latest` | Get a deep understanding of a system, write research doc |

## Agent Guidance

`AGENTS.md` provides instructions for AI coding agents working in this repo. It covers skill format, directory structure, and design conventions. `CLAUDE.md` imports it for Claude Code compatibility.
