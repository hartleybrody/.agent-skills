#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SKILLS_DIRS=(
  "$HOME/.claude/skills"   # Claude Code
  "$HOME/.agents/skills"   # Codex
)

for SKILLS_DIR in "${SKILLS_DIRS[@]}"; do
  echo "==> $SKILLS_DIR"
  mkdir -p "$SKILLS_DIR"

  for dir in "$SCRIPT_DIR"/*/; do
    [ -d "$dir" ] || continue
    name="$(basename "$dir")"
    target="$SKILLS_DIR/$name"

    if [ -L "$target" ]; then
      echo "  skip: $name (symlink already exists)"
    elif [ -e "$target" ]; then
      echo "  skip: $name (non-symlink already exists at $target)"
    else
      ln -s "$dir" "$target"
      echo "  linked: $name -> $target"
    fi
  done

  # Remove stale symlinks pointing into this repo
  for link in "$SKILLS_DIR"/*; do
    [ -L "$link" ] || continue
    dest="$(readlink "$link")"
    case "$dest" in
      "$SCRIPT_DIR"/*)
        if [ ! -e "$link" ]; then
          rm "$link"
          echo "  removed stale: $(basename "$link") -> $dest"
        fi
        ;;
    esac
  done
done
