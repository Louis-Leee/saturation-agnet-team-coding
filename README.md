# Saturated Agent Team Coding (饱和式编程)

A Claude Code skill that applies **ensemble methods to software engineering** — spawning 3 independent coding agents to implement the same requirement in parallel, then selecting and merging the best code through an architect review.

## How It Works

```
Phase 0: Setup        → Create 3 git worktrees + documentation structure
Phase 1: Parallel     → 3 agents independently implement with TDD (RED-GREEN-REFACTOR)
Phase 2: Architect    → Senior architect scores all 3 on a 100-point rubric
Phase 3: Merge+Verify → Merge winner, full TDD verification, 80%+ coverage
Phase 4: Auto-Review  → Auto-codex-review loop until clean
Phase 5: Ship         → Document, commit, push, clean up worktrees
```

### Scoring Rubric (100 points)

| Criterion | Weight | Focus |
|-----------|--------|-------|
| Correctness | 30% | Tests pass, spec compliance, edge cases |
| Code Quality | 25% | Clean, readable, well-structured |
| Test Coverage | 20% | Coverage %, TDD evidence, test quality |
| Performance | 10% | Efficient algorithms and data structures |
| Security | 10% | No vulnerabilities, input validation |
| Simplicity | 5% | YAGNI, minimal abstractions |

## Installation

### One-liner (recommended)

```bash
bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)
```

### Manual Installation

```bash
# Clone the repo
git clone git@github.com:Louis-Leee/saturation-agnet-team-coding.git /tmp/sat-skill

# Copy skill files to Claude Code skills directory
mkdir -p ~/.claude/skills/saturated-agent-team-coding
cp /tmp/sat-skill/skills/saturated-agent-team-coding/* ~/.claude/skills/saturated-agent-team-coding/

# Clean up
rm -rf /tmp/sat-skill
```

### Verify Installation

```bash
ls ~/.claude/skills/saturated-agent-team-coding/
# Should show: SKILL.md  agent-prompt-template.md  architect-review-template.md  merge-strategy.md
```

## Usage

### In Claude Code

```
# Direct invocation
/saturated-agent-team-coding

# Or just describe your task with keywords:
"Use agent team to implement the retry mechanism"
"饱和式编程: add a caching layer"
"Use best-of-3 parallel agents to build the API"
```

### Auto-trigger Keywords

The skill auto-activates when you mention:
- `agent team`
- `saturation coding` / `饱和式编程`
- `parallel agents`
- `best-of-3`

## File Structure

```
skills/saturated-agent-team-coding/
├── SKILL.md                      # Main reference (541 lines)
│                                  # - 6-phase workflow with flowcharts
│                                  # - Scoring rubric details
│                                  # - Quality gates and red flags
│                                  # - Integration with other skills
│
├── agent-prompt-template.md       # Template for coding agent dispatch
│                                  # - TDD requirements
│                                  # - Documentation format
│                                  # - Self-assessment criteria
│
├── architect-review-template.md   # Architect scoring rubric
│                                  # - Per-criterion scoring guide
│                                  # - Selection decision matrix
│                                  # - Review document template
│
└── merge-strategy.md              # Merge decision matrix
                                   # - Clear winner vs close race
                                   # - Hybrid merge (rare)
                                   # - Post-merge verification
```

## Documentation Output

Each run creates persistent documentation in `claude_docs/`:

```
claude_docs/saturation-run-YYYY-MM-DD-HHMM/
├── requirements.md              # What was requested
├── progress.md                  # Final summary with scores
├── agent-alpha/implementation.md  # Alpha's approach + TDD log
├── agent-beta/implementation.md   # Beta's approach + TDD log
├── agent-gamma/implementation.md  # Gamma's approach + TDD log
├── architect-review.md          # Comparative analysis + decision
└── final-review.md              # Auto-codex review results
```

## Dependencies (Sub-skills)

**Required:**
- `superpowers:test-driven-development` — TDD for each coding agent
- `superpowers:using-git-worktrees` — Worktree setup
- `auto-codex-review` — Final quality gate

**Recommended:**
- `superpowers:dispatching-parallel-agents` — Parallel dispatch patterns
- `superpowers:subagent-driven-development` — Subagent management
- `superpowers:verification-before-completion` — Final verification

## Customization

### Agent Count
```
Default: 3 agents (good diversity-to-cost ratio)
Minimum: 2 agents (still provides comparison)
Maximum: 5 agents (diminishing returns beyond this)
```

### Scoring Weights
Adjust in SKILL.md based on project priorities:
- Performance-critical → increase Performance weight
- Security-critical → increase Security weight

## Inspired By

- [ChatDev](https://github.com/OpenBMB/ChatDev) — Role-based multi-agent software development
- [MetaGPT](https://github.com/geekan/MetaGPT) — SOPs for agent collaboration
- Ensemble code generation (best-of-N sampling)
- Tournament selection from genetic algorithms

## License

MIT
