# Skills System - Research Report

**Last updated**: 2026-03-09

---

## Overview

The skills system extends Claude Code with custom, reusable prompt-based capabilities invoked via slash commands (e.g. `/commit`, `/pr-feedback`). Skills are stored as directories in `~/.claude/skills/`, each containing a `SKILL.md` file with YAML front matter and markdown instructions. There is no runtime code — skills are pure prompt injection that Claude receives when a user invokes them.

---

## Architecture

### Skill Definition Format

Every skill is a directory containing at minimum a `SKILL.md` file:

```
skill-name/
└── SKILL.md
```

`SKILL.md` uses YAML front matter for metadata and markdown body for the prompt:

```yaml
---
name: skill-name
description: Short description shown in skill listings
version: x.y.z          # optional
author: author-name      # optional
allowed-tools:           # optional - restricts tool access
  - Read
  - Edit
---

[Prompt instructions that Claude receives when the skill is invoked]
```

Complex skills (e.g. Vercel's) may also include:
- `rules/` directory with individual rule files (each with their own YAML front matter for title, impact, tags)
- `README.md` for human documentation
- `metadata.json` for version/org info
- `AGENTS.md` compiled from rules via a build step

### Installation & Registration

Skills become available by existing in `~/.claude/skills/`. Three installation methods are in use:

1. **Symlinks from the agent-skills repo** (`~/.agent-skills/`) — managed by `install.sh`
2. **Symlinks from external sources** (e.g. `~/.agents/skills/` for Vercel skills)
3. **Direct directories** (e.g. the `humanizer` skill lives directly in `~/.claude/skills/humanizer/`)

### install.sh

The repo's `install.sh` script:
- Iterates over each top-level directory in the repo
- Creates a symlink in `~/.claude/skills/` pointing back to the repo
- Skips if a non-symlink already exists at the target
- **Cleans up stale symlinks**: removes any symlink in `~/.claude/skills/` that points into the repo but whose source directory no longer exists

This means adding a new skill is: create directory with `SKILL.md`, re-run `install.sh`.

### Permissions

A settings file at `~/.claude/skills/.claude/settings.local.json` controls auto-trigger permissions. Currently only the `humanizer` skill is listed in `permissions.allow`.

---

## Current Skills Inventory (15 total)

### Custom Skills (from `~/.agent-skills/`)

| Skill | Invocation | Purpose |
|-------|-----------|---------|
| **commit** | `/commit` | Creates a collaborative, descriptive git commit. Only commits already-staged files. Uses multi-line messages describing the intention from conversation context. Will not auto-commit on future messages. |
| **plan-create** | `/plan-create` | Reads research docs, context, and intention statements to produce a step-by-step implementation plan. Outputs to `.scratch/plan/<FEATURE_SUMMARY>.md`. Includes date, LOC estimate, and flags ambiguities. |
| **plan-implement** | `/plan-implement` | Executes implementation from an existing plan document. Updates the plan doc as sections complete, marks progress, notes issues. Ensures linters/formatters pass. Implements tests but doesn't require them to pass. |
| **plan-update** | `/plan-update` | Updates an existing plan doc based on user annotations. Looks for lines starting with `->` as annotation markers. Provides a summary of decisions and changes at the bottom of the doc. |
| **pr-ci-failures** | `/pr-ci-failures` | Checks automated CI checks (linters, tests) on a GitHub PR, identifies failures, and fixes the errors. Short, actionable skill for CI debugging. |
| **pr-feedback** | `/pr-feedback` | Reviews unresolved inline code comments on a PR. Buckets repeated issues, assigns identifiers, flags already-fixed items, triages as good/bad suggestions. Does NOT implement changes — presents findings for human review first. |
| **pr-local-ci** | `/pr-local-ci` | Runs linters, formatters, and all relevant tests locally. Flags any failures with reasons. On full success, runs `git push origin @` to trigger remote CI. Does not make additional commits or stage uncommitted files. |
| **research-latest** | `/research-latest` | Deep-dives into a specified system to understand how it works. Requires a system name and source paths as arguments. Writes a detailed report to `.scratch/research/{SYSTEM_NAME}-latest.md` with a timestamp. |

### Third-Party Skills (from `~/.agents/skills/`)

| Skill | Invocation | Purpose |
|-------|-----------|---------|
| **find-skills** | `/find-skills` | Helps users discover and install agent skills. Uses `npx skills find [query]` and `npx skills add` to search a skill registry and install matches. |
| **vercel-react-best-practices** | `/vercel-react-best-practices` | 40+ rules for React/Next.js performance optimization organized in 8 categories: eliminating waterfalls (CRITICAL), bundle size (CRITICAL), server-side perf (HIGH), client-side data fetching (MEDIUM-HIGH), re-render optimization (MEDIUM), rendering perf (MEDIUM), JS perf (LOW-MEDIUM), advanced patterns (LOW). |
| **vercel-composition-patterns** | `/vercel-composition-patterns` | React composition patterns for scalable component APIs. 4 categories: component architecture (HIGH), state management (MEDIUM), implementation patterns (MEDIUM), React 19 APIs (MEDIUM). Addresses boolean prop proliferation, compound components, render props, context providers. |
| **vercel-react-native-skills** | `/vercel-react-native-skills` | React Native and Expo best practices. 8 categories: list performance (CRITICAL), animation (HIGH), navigation (HIGH), UI patterns (HIGH), state management (MEDIUM), rendering (MEDIUM), monorepo (MEDIUM), configuration (LOW). |
| **web-design-guidelines** | `/web-design-guidelines` | Audits UI code against Web Interface Guidelines. Fetches latest guidelines from a GitHub URL, reads specified files, checks against all rules, and outputs findings in `file:line` format. |

### Local Skills (in `~/.claude/skills/` directly)

| Skill | Invocation | Purpose |
|-------|-----------|---------|
| **humanizer** | `/humanizer` | Identifies and removes 24 patterns of AI-generated writing. Covers content patterns (significance inflation, notability name-dropping), language patterns (AI vocabulary, copula avoidance, negative parallelisms), style patterns (em dash overuse, boldface overuse, emojis), communication patterns (chatbot artifacts), and filler/hedging patterns. Version 2.1.1. |

### Duplicate/Alternate

| Skill | Notes |
|-------|-------|
| **react-best-practices** | Alternate symlink to `vercel-react-best-practices` from a different source path (`~/.claude/agent-skills/skills/`). Same content. |

---

## Skill Design Patterns

### Simple Skills (custom agent-skills)
- Single `SKILL.md` file, ~5-20 lines of prompt
- No build step, no dependencies
- Direct, imperative instructions to Claude
- Often include guardrails ("only do X when explicitly asked", "do NOT auto-commit")

### Complex Skills (Vercel)
- Modular `rules/` directory with one `.md` file per rule
- Each rule has YAML front matter: `title`, `impact`, `impactDescription`, `tags`
- Rule content follows Incorrect -> Correct pattern with explanations
- Filename convention: `{category-prefix}-{description}.md`
- Build system compiles rules into a single `AGENTS.md`
- Validation and test extraction tooling

### Output Conventions
- Plans go to `.scratch/plan/`
- Research goes to `.scratch/research/`
- Both use descriptive filenames with content summaries

### Safety Patterns
- Skills that modify code include "don't auto-commit" / "don't push without asking" guardrails
- PR feedback skill explicitly defers implementation to human review
- Plan workflow separates create -> review -> implement into distinct steps with human checkpoints

---

## How It All Fits Together

```
~/.agent-skills/          (git repo - custom skills source)
  ├── install.sh          (symlink manager)
  ├── commit/SKILL.md
  ├── plan-create/SKILL.md
  ├── ...
  └── research-latest/SKILL.md

~/.agents/skills/         (external skills source, e.g. Vercel)
  ├── find-skills/SKILL.md
  ├── vercel-react-best-practices/
  │   ├── SKILL.md
  │   └── rules/*.md
  └── ...

~/.claude/skills/         (active skills directory - what Claude reads)
  ├── commit -> ~/.agent-skills/commit
  ├── plan-create -> ~/.agent-skills/plan-create
  ├── find-skills -> ~/.agents/skills/find-skills
  ├── vercel-react-best-practices -> ~/.agents/skills/vercel-react-best-practices
  ├── humanizer/          (direct, not symlinked)
  └── ...
```

The workflow: user types `/skill-name [args]` -> Claude Code loads the skill's `SKILL.md` (and any referenced rules) -> the prompt is injected into the conversation -> Claude follows the instructions with the provided context.
