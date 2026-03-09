#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SKILLS_DIR"

for dir in "$SCRIPT_DIR"/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  target="$SKILLS_DIR/$name"

  if [ -L "$target" ]; then
    echo "skip: $name (symlink already exists)"
  elif [ -e "$target" ]; then
    echo "skip: $name (non-symlink already exists at $target)"
  else
    ln -s "$dir" "$target"
    echo "linked: $name -> $target"
  fi
done
