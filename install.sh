#!/bin/bash
# Install saturated-coding skill for Claude Code
# Usage: bash install.sh  (run from cloned repo)
#    or: bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)

set -e

SKILLS_DIR="$HOME/.claude/skills"
REPO_URL="https://github.com/Louis-Leee/saturation-agnet-team-coding.git"

# If not running from repo, clone to temp dir
if [ ! -f "SKILL.md" ]; then
    TMP_DIR=$(mktemp -d)
    echo "Cloning repo..."
    git clone --depth 1 "$REPO_URL" "$TMP_DIR" 2>/dev/null || {
        echo "Error: Failed to clone. Try: git clone $REPO_URL /tmp/saturated-coding && bash /tmp/saturated-coding/install.sh"
        rm -rf "$TMP_DIR"
        exit 1
    }
    cd "$TMP_DIR"
fi

echo "Installing saturated-coding skill..."

# 1. Main skill (router + detailed docs)
mkdir -p "$SKILLS_DIR/saturated-coding"
cp SKILL.md research.md write-plan.md execute-plan.md verification.md \
   agent-prompt-template.md architect-review-template.md merge-strategy.md \
   "$SKILLS_DIR/saturated-coding/"

# 2. Sub-skills (independently invocable phases)
for phase in saturated-research saturated-write-plan saturated-execute-plan saturated-verify; do
    mkdir -p "$SKILLS_DIR/$phase"
    cp "sub-skills/$phase/SKILL.md" "$SKILLS_DIR/$phase/"
done

# Clean up temp dir if used
[ -n "$TMP_DIR" ] && rm -rf "$TMP_DIR"

# Verify
if [ -f "$SKILLS_DIR/saturated-coding/SKILL.md" ]; then
    echo ""
    echo "Installed! Available commands:"
    echo "  /saturated-coding        Full pipeline"
    echo "  /saturated-research      Phase 1: Research"
    echo "  /saturated-write-plan    Phase 2: Planning"
    echo "  /saturated-execute-plan  Phase 3: Execution"
    echo "  /saturated-verify        Phase 4: Verification"
else
    echo "Error: Installation failed."
    exit 1
fi
