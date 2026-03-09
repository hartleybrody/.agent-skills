# Plan: AGENTS.md for the Skills Repo

**Date**: 2026-03-09
**Estimated LOC changed**: ~80-120 lines (new file + minor edits)

---

## Context

The `~/.agent-skills/` repo has no CLAUDE.md or AGENTS.md. The user wants a single guidance file that works for both Claude Code and Codex (and other AGENTS.md-compatible tools) when working in this repo.

### Key Findings from Research

- **AGENTS.md** is the cross-tool open standard (Linux Foundation), supported natively by Codex, Jules, Gemini CLI, Cursor, Copilot, and 20+ tools.
- **Claude Code** does not natively read AGENTS.md — it reads `CLAUDE.md`. However, CLAUDE.md supports `@path` imports, so a one-line `CLAUDE.md` containing `@AGENTS.md` bridges the gap.
- Both formats are plain Markdown with no special syntax required.
- The existing Vercel `agent-skills` repo has an AGENTS.md that can serve as a structural reference (though its content is about Vercel-specific skill creation, not this repo).

---

## Plan

### Step 1: Create `AGENTS.md` in repo root -- DONE

Write an AGENTS.md file at `/Users/hartley/.agent-skills/AGENTS.md` that covers:

1. **Repository overview** — what this repo is, what skills are, how they're structured
2. **Skill format specification** — the `SKILL.md` format (YAML front matter + markdown body), required and optional fields
3. **Directory structure** — one directory per skill, each containing a `SKILL.md`
4. **Installation mechanism** — how `install.sh` symlinks skills into `~/.claude/skills/`
5. **Current skills inventory** — table of all skills with descriptions (pulled from README/research)
6. **How to add a new skill** — step-by-step instructions
7. **Design conventions** — guardrails pattern, output directory conventions (`.scratch/plan/`, `.scratch/research/`), safety patterns
8. **How to remove a skill** — delete the directory, re-run `install.sh`

This file should be **tool-agnostic** — no Claude-specific or Codex-specific syntax. Plain Markdown only.

**Notes**: Created at ~80 lines. Covers all 8 sections. Tool-agnostic plain Markdown. Also added `research-latest` to the skills table (was missing from README).

### Step 2: Create `CLAUDE.md` in repo root (one-liner bridge) -- DONE

Write a minimal `CLAUDE.md` at `/Users/hartley/.agent-skills/CLAUDE.md` containing:

```
@AGENTS.md
```

This makes Claude Code load the AGENTS.md content via its import mechanism. No duplication, single source of truth.

**Notes**: One-liner created. No issues.

### Step 3: Update README.md -- DONE

Add a brief note to the README mentioning that AGENTS.md exists and serves as the agent guidance file, and that CLAUDE.md imports it for Claude Code compatibility.

**Notes**: Added `research-latest` to the skills table (was previously missing) and added an "Agent Guidance" section at the bottom.

---

## Ambiguities & Options

### 1. Scope: project-only vs. also user-level?

The user mentioned "both in this project, as at a user (ie project/system-wide) level." Two interpretations:

- **Option A**: Write one AGENTS.md in this repo. It applies when agents work *in this repo*. For user-level guidance (across all projects), that would be a separate `~/.claude/CLAUDE.md` / `~/.codex/AGENTS.md` — out of scope for this repo.
- **Option B**: Write the AGENTS.md here, and *also* symlink or copy it to `~/.codex/AGENTS.md` (for Codex) and create `~/.claude/CLAUDE.md` with `@~/.agent-skills/AGENTS.md` (for Claude Code) so it applies globally.

**Decision**: Option A — project-scoped only. The AGENTS.md lives in this repo and applies only when agents work here.

### 2. Should the AGENTS.md also describe how skills are *used* (invocation), or only how they're *authored*?

- The repo is about **authoring** skills, not using them (usage happens in other projects).
- But an agent working in this repo might also want to know how to *test* a skill by invoking it.

**Decision**: Authoring only. Skills are invoked by humans within an agent session, not by agents themselves. No invocation/usage section needed.

### 3. Should we include the full skill inventory inline or reference the README?

- Inline: self-contained, but creates duplication with README.md
- Reference: "see README.md for the current skill list"

**Decision**: Inline table. Include the full skills list directly in AGENTS.md for self-contained context.

---

## Initial Prompt and Feature Intention

> can you please read @.scratch/research/skills-system-latest.md
>
> i'd like to write an AGENTS.md file that can be used both in this project, as at a user (ie project/system-wide) level, that can be used for both claude code as well as codex

---

## Decisions Summary (2026-03-09)

1. **Scope**: Project-only. No user-level or system-wide files — AGENTS.md applies only when working in this repo.
2. **Content focus**: Authoring only. No skill invocation/usage docs — humans invoke skills within agent sessions, agents don't need to know how to run them.
3. **Skill inventory**: Inline table included directly in AGENTS.md for self-contained agent context.

---

## Implementation Summary (2026-03-09)

All 3 steps completed. Files created/modified:

- **`AGENTS.md`** (new, ~80 lines) — Tool-agnostic agent guidance covering repo overview, skill format spec, directory structure, installation, skills inventory (8 skills), how to add/remove skills, and design conventions. No Claude-specific or Codex-specific syntax.
- **`CLAUDE.md`** (new, 1 line) — Single `@AGENTS.md` import so Claude Code loads the AGENTS.md content.
- **`README.md`** (edited) — Added missing `research-latest` to skills table. Added "Agent Guidance" section explaining the AGENTS.md/CLAUDE.md setup.

No issues encountered. No tests to implement (documentation-only change).
