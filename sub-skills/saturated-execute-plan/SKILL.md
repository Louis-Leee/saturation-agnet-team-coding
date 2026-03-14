---
name: saturated-execute-plan
description: "Saturated execution (Phase 3 of saturated-coding): dispatch 4 parallel coding agents (2x superpowers:executing-plans + 2x everything-claude-code:tdd), each in isolated worktree with fresh 1M context. Architect scores, merges winner. Trigger: 'saturated execute', '饱和式执行', 'execute with agent team'."
user-invocable: true
---

# Saturated Execution (Phase 3 of /saturated-coding)

> Full instructions at: `~/.claude/skills/saturated-coding/execute-plan.md`
> Previous phase: `/saturated-write-plan` | Next phase: `/saturated-verify`

## Overview

**4 parallel coding agents implement the same plan independently, each with a fresh 1M context window in an isolated git worktree.** Two use `superpowers:executing-plans`, two use `everything-claude-code:tdd`. A senior architect scores all 4, merges the best.

All agents use **opus model only**. No downgrades. Don't be stingy with tokens.

## When to Use

- Implementation plan exists (from `/saturated-write-plan` or user-provided)
- User says "saturated execute", "饱和式执行", "execute with agent team"
- After `/saturated-write-plan` prompts

## The 7-Phase Process

1. **Load & Review Plan** — Read plan, raise concerns if any. STOP if critical gaps.

2. **Setup** — Create 4 git worktrees + docs structure:
   ```bash
   git worktree add .worktrees/sat-alpha -b sat-impl-alpha
   git worktree add .worktrees/sat-beta  -b sat-impl-beta
   git worktree add .worktrees/sat-gamma -b sat-impl-gamma
   git worktree add .worktrees/sat-delta -b sat-impl-delta
   ```

3. **Dispatch 4 Coding Agents (PARALLEL)** — All background, all opus, all isolated worktrees:

   | Agent | Methodology | Style | Output |
   |-------|-------------|-------|--------|
   | Alpha | superpowers:executing-plans | Plan-faithful | `agent-alpha/implementation.md` |
   | Beta | superpowers:executing-plans | Creative interpretation | `agent-beta/implementation.md` |
   | Gamma | ECC:tdd | Strict TDD | `agent-gamma/implementation.md` |
   | Delta | ECC:tdd | Defensive coding | `agent-delta/implementation.md` |

   ```python
   Agent(description="Agent Alpha: superpowers executing-plans",
         prompt="...", isolation="worktree",
         run_in_background=True, model="opus")
   ```

4. **Health Check & Recovery** — Verify each: has commits, has tests, has docs, has self-assessment. Minimum 3 of 4. Dispatch replacements for failures.

5. **Senior Architect Review** — Score all agents (100-point rubric):

   | Criterion | Weight |
   |-----------|--------|
   | Correctness | 30% |
   | Code Quality | 25% |
   | Test Coverage | 20% |
   | Performance | 10% |
   | Security | 10% |
   | Simplicity | 5% |

   Save to `architect-review.md`.

6. **Merge Winner** — `git merge sat-impl-{winner}`. Run full test suite. Coverage >= 80%.

7. **Handoff** — Automatically proceed to verification:
   ```
   Winner: {name} ({score}/100). All tests pass. Coverage: {X}%.
   Proceeding to cross-verification...
   -> /saturated-verify
   ```

## Orchestrator Rules

1. The orchestrator NEVER writes production code — it spawns agents, waits, scores, merges.
2. All agents use opus model. No downgrades.
3. Don't be stingy with tokens. Each agent gets full 1M context.
4. All docs go to `claude_docs/saturation-run-{TIMESTAMP}/`.

## Full Instructions

Read `~/.claude/skills/saturated-coding/execute-plan.md` for complete agent prompts, worktree setup, health check protocol, architect review template, and merge strategy.
