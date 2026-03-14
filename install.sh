#!/bin/bash
# Install saturated-coding skill for Claude Code
# Usage: bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)

set -e

SKILL_DIR="$HOME/.claude/skills/saturated-coding"
REPO_URL="https://github.com/Louis-Leee/saturation-agnet-team-coding.git"
TMP_DIR=$(mktemp -d)

echo "Installing saturated-coding skill..."

git clone --depth 1 "$REPO_URL" "$TMP_DIR" 2>/dev/null || {
    echo "Error: Failed to clone repo."
    rm -rf "$TMP_DIR"
    exit 1
}

mkdir -p "$SKILL_DIR"
cp "$TMP_DIR/skills/saturated-coding/"*.md "$SKILL_DIR/"
rm -rf "$TMP_DIR"

if [ -f "$SKILL_DIR/SKILL.md" ]; then
    echo "Installed successfully to $SKILL_DIR"
    echo "Usage: /saturated-coding"
else
    echo "Error: Installation failed."
    exit 1
fi
