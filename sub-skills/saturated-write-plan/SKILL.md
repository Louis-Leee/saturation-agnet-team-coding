---
name: saturated-write-plan
description: "Saturated planning (Phase 2 of saturated-coding): dispatch 4 parallel planning agents (2x superpowers:writing-plans + 2x ECC multi-plan), checker verifies each, orchestrator merges best. Trigger: 'saturated plan', '饱和式 plan', 'multi-agent plan'."
user-invocable: true
---

# Saturated Planning (Phase 2 of /saturated-coding)

> Full instructions at: `~/.claude/skills/saturated-coding/write-plan.md`
> Previous phase: `/saturated-research` | Next phase: `/saturated-execute-plan`

## Overview

**4 agents write plans in parallel using 2 different planning methodologies, then the orchestrator reviews, scores, and merges into one superior plan.**

- **Agents A & B** use `superpowers:writing-plans` methodology (bite-sized TDD tasks, exact file paths, exact commands)
- **Agents C & D** use `everything-claude-code:multi-plan` methodology (multi-perspective analysis, context retrieval, cross-validation)

## When to Use

- Requirements/spec exist but no implementation plan yet
- Complex feature needing thorough planning
- User says "saturated plan", "饱和式 plan", "write-plan"
- After `/saturated-research` completes

## The Process

1. **Context Preparation** — Read research output or user requirements. Explore codebase. Write `planning-context.md`.

2. **Dispatch 4 Planning Agents (PARALLEL, MANDATORY)** — All background, all opus:

   | Agent | Methodology | Differentiator | Output |
   |-------|-------------|----------------|--------|
   | A | superpowers:writing-plans | TDD-first granularity | `plan-agent-a.md` |
   | B | superpowers:writing-plans | Architecture-first | `plan-agent-b.md` |
   | C | ECC multi-plan | Risk-driven | `plan-agent-c.md` |
   | D | ECC multi-plan | Performance-first | `plan-agent-d.md` |

   Each agent gets: `{REQUIREMENTS}` + `{PLANNING_CONTEXT}` + methodology + differentiator.

3. **Checker Verification Loop** — For each plan:
   - Plan exists and >800 words
   - All requirements covered
   - Concrete file paths (not placeholders)
   - Complete code (not "add X here")
   - Self-assessment present
   - If FAIL: resume agent with feedback (max 2 retries)
   - Minimum: 3 of 4 plans verified PASS

4. **Orchestrator Scoring & Merge** — Score each plan:

   | Criterion | Weight |
   |-----------|--------|
   | Completeness | 20% |
   | Task Decomposition | 20% |
   | TDD Integration | 20% |
   | Architecture Quality | 15% |
   | Risk Awareness | 15% |
   | Performance | 10% |

   Save comparison to `plan-comparison.md`. Merge best elements into `final-plan.md`.

5. **Plan Review Agent** — Dispatch reviewer to verify merged plan is complete, consistent, and ready for 4 parallel coders. Fix issues (max 3 iterations).

6. **Handoff** — Present scores and merged plan to user:
   ```
   Plan complete. Sources: Agent A ({score}), B ({score}), C ({score}), D ({score})
   Ready to execute with 4 parallel coding agents?
   -> /saturated-execute-plan
   ```

## Orchestrator Rules

1. The orchestrator NEVER writes plans — it spawns agents, waits, scores, merges.
2. All agents use opus model. No downgrades.
3. Don't be stingy with tokens. Let agents think deeply.
4. All docs go to `claude_docs/saturation-run-{TIMESTAMP}/`.

## Full Instructions

Read `~/.claude/skills/saturated-coding/write-plan.md` for complete agent prompts, checker details, scoring rubric, and merge strategy.
