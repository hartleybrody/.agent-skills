# Agent Skills

A repository of custom agent skills for Claude Code.

## Installation

Run the install script to symlink all skills into `~/.claude/skills/`:

```sh
./install.sh
```

Each top-level directory is symlinked individually, so adding or removing a skill directory and re-running the script is all that's needed.

## Skills

| Skill | Description |
|-------|-------------|
| `commit` | Makes collaborative, descriptive multi-line commits from context |
