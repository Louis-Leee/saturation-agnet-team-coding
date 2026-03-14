# Saturated Coding (饱和式编程)

Multi-agent orchestration for Claude Code. Each phase spawns parallel agents using different skills, then a thin orchestrator merges the best results.

```
Research (4 agents) -> Plan (4 agents) -> Execute (4 agents) -> Verify (2 agents)
```

## Install

```bash
git clone git@github.com:Louis-Leee/saturation-agnet-team-coding.git /tmp/saturated-coding \
  && bash /tmp/saturated-coding/install.sh \
  && rm -rf /tmp/saturated-coding
```

Or manually:

```bash
# 1. Clone
git clone git@github.com:Louis-Leee/saturation-agnet-team-coding.git /tmp/saturated-coding

# 2. Copy main skill (full pipeline + detailed agent prompts)
cp -r /tmp/saturated-coding ~/.claude/skills/saturated-coding

# 3. Copy sub-skills (each phase independently invocable)
for phase in saturated-research saturated-write-plan saturated-execute-plan saturated-verify; do
  mkdir -p ~/.claude/skills/$phase
  cp /tmp/saturated-coding/sub-skills/$phase/SKILL.md ~/.claude/skills/$phase/
done

# 4. Clean up
rm -rf /tmp/saturated-coding
```

## Prerequisites

These Claude Code plugins/skills must be installed:

- [superpowers](https://github.com/anthropics/superpower-skills) - brainstorming, writing-plans, executing-plans
- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) - tdd, code-review
- [auto-codex-review](https://github.com/anthropics/auto-codex-review) - automated review loop

## Commands

| Command | Phase | What it does |
|---------|-------|-------------|
| `/saturated-coding` | All | Full 4-phase pipeline |
| `/saturated-research` | 1 | 4 parallel researchers (stack, solutions, architecture, risks) |
| `/saturated-write-plan` | 2 | 4 parallel planners, checker loop, merge best-of-4 |
| `/saturated-execute-plan` | 3 | 4 parallel coders in isolated worktrees, architect scores |
| `/saturated-verify` | 4 | 2 cross-reviewers (code-review + codex-review) |

Each phase can be run independently. The orchestrator prompts you with the next phase when done.

## How it works

Each phase follows the same pattern:

1. **Orchestrator** prepares context
2. **Spawns N parallel agents** (each using a different skill/methodology)
3. **Health check** - verify agents completed (min 3 of 4)
4. **Orchestrator** scores, merges, presents results
5. **Handoff** to next phase

All agents use `opus` model. All docs saved to `claude_docs/saturation-run-{TIMESTAMP}/`.

## File structure

```
~/.claude/skills/
├── saturated-coding/          # Main skill (router + full docs)
│   ├── SKILL.md               # Router: /saturated-coding
│   ├── research.md            # Phase 1 detailed instructions
│   ├── write-plan.md          # Phase 2 detailed instructions
│   ├── execute-plan.md        # Phase 3 detailed instructions
│   ├── verification.md        # Phase 4 detailed instructions
│   ├── agent-prompt-template.md
│   ├── architect-review-template.md
│   └── merge-strategy.md
├── saturated-research/        # Sub-skill: /saturated-research
│   └── SKILL.md
├── saturated-write-plan/      # Sub-skill: /saturated-write-plan
│   └── SKILL.md
├── saturated-execute-plan/    # Sub-skill: /saturated-execute-plan
│   └── SKILL.md
└── saturated-verify/          # Sub-skill: /saturated-verify
    └── SKILL.md
```

**Why separate directories?** Claude Code local skills don't support colon syntax (`skill:subcommand`) - that's a plugin-only feature. Each sub-skill needs its own directory under `~/.claude/skills/` to be independently invocable.

## License

MIT
