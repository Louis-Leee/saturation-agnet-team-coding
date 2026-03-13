#!/bin/bash
# Install saturated-agent-team-coding skill for Claude Code
# Usage: bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)

set -e

SKILL_DIR="$HOME/.claude/skills/saturated-agent-team-coding"
REPO_URL="https://github.com/Louis-Leee/saturation-agnet-team-coding.git"
TMP_DIR=$(mktemp -d)

echo "Installing saturated-agent-team-coding skill..."

# Clone repo
git clone --depth 1 "$REPO_URL" "$TMP_DIR" 2>/dev/null || {
    echo "Error: Failed to clone repo. Check your network connection."
    rm -rf "$TMP_DIR"
    exit 1
}

# Create skill directory
mkdir -p "$SKILL_DIR"

# Copy skill files
cp "$TMP_DIR/skills/saturated-agent-team-coding/"*.md "$SKILL_DIR/"

# Clean up
rm -rf "$TMP_DIR"

# Verify
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    echo ""
    echo "Installed successfully!"
    echo "Location: $SKILL_DIR"
    echo ""
    echo "Files installed:"
    ls -1 "$SKILL_DIR"
    echo ""
    echo "Usage in Claude Code:"
    echo "  /saturated-agent-team-coding"
    echo '  Or say: "Use agent team to implement X"'
    echo '  Or say: "饱和式编程: implement X"'
else
    echo "Error: Installation failed. SKILL.md not found."
    exit 1
fi
