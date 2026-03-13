# Saturated Agent Team Coding (饱和式编程)

A Claude Code skill that applies **ensemble methods to the FULL software lifecycle** — from planning to implementation to review. Multi-agent redundancy at every stage ensures the best outcome.

## Two Sub-Workflows

### `write-plans` — Saturated Planning
Dispatch 2-3 planning agents in parallel (using `superpowers:writing-plans` + `everything-claude-code:plan` methodologies). Each independently generates a complete implementation plan. The orchestrator reviews, scores, and merges them into one superior plan.

### `execute-plans` — Saturated Execution
Dispatch 3 coding agents in isolated git worktrees, each independently implementing with TDD. A senior architect scores all 3 on a 100-point rubric, merges the best, then runs a cross-review gauntlet (auto-codex + security + code quality) before shipping.

## Full Pipeline

```
User requirement
    ↓
[write-plans] → 2+ agents generate plans in parallel
    ↓              → Orchestrator reviews & merges → Final plan
    ↓
[execute-plans] → 3 agents implement in parallel (TDD)
    ↓               → Architect scores & merges best code
    ↓               → TDD verification on merged code
    ↓               → Auto-codex + security + code quality reviews
    ↓               → Documentation + git push
    ↓
Shipped!
```

## Scoring Rubric (100 points)

| Criterion | Weight | Focus |
|-----------|--------|-------|
| Correctness | 30% | Tests pass, spec compliance, edge cases |
| Code Quality | 25% | Clean, readable, well-structured |
| Test Coverage | 20% | Coverage %, TDD evidence, test quality |
| Performance | 10% | Efficient algorithms and data structures |
| Security | 10% | No vulnerabilities, input validation |
| Simplicity | 5% | YAGNI, minimal abstractions |

## Installation

### One-liner

```bash
bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)
```

### Manual

```bash
git clone git@github.com:Louis-Leee/saturation-agnet-team-coding.git /tmp/sat-skill
mkdir -p ~/.claude/skills/saturated-agent-team-coding
cp /tmp/sat-skill/skills/saturated-agent-team-coding/* ~/.claude/skills/saturated-agent-team-coding/
rm -rf /tmp/sat-skill
```

## Usage

```
# Full pipeline (plan → execute)
/saturated-agent-team-coding

# Planning only
"saturated plan for feature X" or "饱和式 plan"

# Execution only (plan already exists)
"execute with agent team" or "饱和式执行"
```

## File Structure

```
skills/saturated-agent-team-coding/
├── SKILL.md                      # Main entry + router (write-plans vs execute-plans)
├── write-plans.md                # Saturated planning workflow
│                                  # - 2-3 parallel planning agents
│                                  # - Plan scoring rubric & comparison
│                                  # - Merge strategy + review loop
├── execute-plans.md              # Saturated execution workflow (7 phases)
│                                  # - 3 parallel coding agents in worktrees
│                                  # - Spec compliance review per agent
│                                  # - Architect scoring + merge
│                                  # - Cross-review gauntlet (codex + security + quality)
├── agent-prompt-template.md       # Template for coding agent dispatch
├── architect-review-template.md   # 100-point scoring rubric for architect
└── merge-strategy.md              # Decision matrix for selecting winners
```

## Dependencies (Sub-skills)

**Required:**
- `superpowers:test-driven-development`
- `superpowers:writing-plans`
- `superpowers:using-git-worktrees`
- `superpowers:verification-before-completion`
- `auto-codex-review`

**Used by planning agents:**
- `everything-claude-code:plan`
- `everything-claude-code:multi-plan` (if available)

## Inspired By

- [ChatDev](https://github.com/OpenBMB/ChatDev) — Role-based multi-agent development
- [MetaGPT](https://github.com/geekan/MetaGPT) — SOPs for agent collaboration
- Ensemble code generation (best-of-N sampling)
- Tournament selection from genetic algorithms

## License

MIT
