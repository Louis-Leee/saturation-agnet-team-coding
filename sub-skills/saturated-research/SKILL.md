---
name: saturated-research
description: "Saturated research (Phase 1 of saturated-coding): inherits superpowers:brainstorming, dispatches 4 parallel research agents to investigate stack, solutions, architecture, and risks. Orchestrator summarizes. Trigger: 'saturated research', '饱和式研究', 'brainstorm with agents'."
user-invocable: true
---

# Saturated Research (Phase 1 of /saturated-coding)

> Full instructions at: `~/.claude/skills/saturated-coding/research.md`
> After this phase, proceed to: `/saturated-write-plan`

## Overview

**Inherits from `superpowers:brainstorming` and amplifies it with 4 parallel research agents.** Instead of one brainstorming pass, dispatch 4 independent researchers — each investigating a different dimension of the problem — then synthesize their findings into a comprehensive research document.

The orchestrator (YOU) follows the `superpowers:brainstorming` checklist first (explore context, ask clarifying questions one at a time, understand intent), then spawns 4 parallel research agents for deep investigation.

## When to Use

- Starting a new feature or project
- User says "saturated coding", "brainstorm", "研究一下"
- Need comprehensive understanding before planning
- Complex problem needing multi-angle investigation

## The Process

1. **Brainstorming Foundation** — Follow `superpowers:brainstorming`: explore context, ask clarifying questions (one at a time), understand full picture. **HARD GATE:** Do NOT dispatch agents until you understand what the user wants.

2. **Dispatch 4 Research Agents (PARALLEL)** — All in background, all opus model:

   | Agent | Focus | Output |
   |-------|-------|--------|
   | R1: Stack Investigator | Libraries, frameworks, APIs, compatibility | `research-agent-1-stack.md` |
   | R2: Solution Explorer | Existing implementations, prior art, GitHub search | `research-agent-2-solutions.md` |
   | R3: Architecture Analyst | Codebase fit, module design, data flow, interfaces | `research-agent-3-architecture.md` |
   | R4: Risk Assessor | Security, performance, edge cases, failure modes | `research-agent-4-risks.md` |

   Each agent gets: `{REQUIREMENTS}` + `{CODEBASE_CONTEXT}` + their focus area instructions.

   ```python
   # Dispatch pattern (all 4 in parallel):
   Agent(description="Research: stack investigation",
         prompt="You are R1: Stack Investigator...",
         run_in_background=True, model="opus")
   # ... repeat for R2, R3, R4
   ```

3. **Health Check** — Verify each agent returned substantive report (>300 words, on-topic). Minimum 3 of 4 to proceed. Dispatch replacements for failures (max 1 retry per slot).

4. **Orchestrator Synthesis** — Read ALL reports, write unified document:

   ```
   claude_docs/saturation-run-{TIMESTAMP}/research-context.md
   ```

   Format: Executive Summary, Stack Recommendations, Solution Approaches (comparison table), Architecture Design, Risk Matrix (likelihood x impact), Recommended Approach, Open Questions.

5. **Present to User** — Show synthesis, ask: Does this match your vision? Ready to plan?

6. **Handoff** — When approved:
   ```
   Research complete. Ready to create implementation plans with 4 parallel planners?
   -> /saturated-write-plan
   ```

## Orchestrator Rules

1. The orchestrator NEVER does research itself — it spawns agents, waits, integrates.
2. All agents use opus model. No downgrades.
3. Don't be stingy with tokens. Let agents think deeply.
4. All docs go to `claude_docs/saturation-run-{TIMESTAMP}/`.

## Full Instructions

Read `~/.claude/skills/saturated-coding/research.md` for complete agent prompts, health check details, and synthesis template.
