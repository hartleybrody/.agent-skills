# Agent Skills

A repository of custom agent skills for Claude Code.

➡️ [More information on how to use them here](https://blog.hartleybrody.com/markdown-research-planning/).

## Installation

Run the install script to symlink all skills into `~/.claude/skills/` (Claude Code) and `~/.agents/skills/` (Codex):

```sh
./install.sh
```

Each top-level directory is symlinked individually. Re-running the script links new skills and removes stale symlinks for skills that have been deleted from this repo.

## Skills

| Skill | Description |
|-------|-------------|
| `commit` | Make a collaborative, descriptive commit |
| `research-latest` | Get a deep understanding of a system, write research doc |
| `plan-create` | Read research, context and intention to create plan doc |
| `plan-update` | Update the plan doc, from my annotations |
| `plan-implement` | Begin implementing from a plan doc |
| `pr-local-ci` | Run all CI tests locally, push on success |
| `pr-create` | Create a new Pull Request (PR) |
| `pr-ci-failures` | Look for failing CI tests and fix issues |
| `pr-feedback` | Look at in-line code comments on PR and prepare response |
| `pr-update-desc` | Update description of existing PR |
| `pr-review` | Begin a review for a set of changes in a PR |

## Agent Guidance

`AGENTS.md` provides instructions for AI coding agents working in this repo. It covers skill format, directory structure, and design conventions. `CLAUDE.md` imports it for Claude Code compatibility.
