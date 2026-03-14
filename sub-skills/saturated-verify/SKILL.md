---
name: saturated-verify
description: "Saturated verification (Phase 4 of saturated-coding): 2 parallel cross-verification agents (ECC code-review + auto-codex-review). Orchestrator presents results and routes next action. Trigger: 'saturated verify', '饱和式验证', 'cross-verify'."
user-invocable: true
---

# Saturated Verification (Phase 4 of /saturated-coding)

> Full instructions at: `~/.claude/skills/saturated-coding/verification.md`
> Previous phase: `/saturated-execute-plan`

## Overview

**2 parallel verification agents independently review the merged code using different methodologies.** One uses `everything-claude-code:code-review` for comprehensive manual-style review. The other uses `auto-codex-review` for automated review with fix loops. The orchestrator presents both results and routes fixes.

The orchestrator NEVER fixes code itself. It spawns reviewers, waits, integrates results, presents to user, routes fixes.

## When to Use

- After `/saturated-execute-plan` completes
- Code exists and needs quality assurance
- User says "saturated verify", "饱和式验证", "cross-verify"
- Before shipping / git push

## The Process

1. **Collect Review Context** — Get diff, changed files list, plan summary, test results.

2. **Dispatch 2 Review Agents (PARALLEL)** — Both background, both opus:

   | Agent | Methodology | Focus | Output |
   |-------|-------------|-------|--------|
   | V1 | ECC code-review | Security, quality, best practices | `code-review.md` |
   | V2 | auto-codex-review | Structured review loop, P0/P1/P2 issues | `codex-review.md` |

3. **Health Check** — Both agents must complete with verdict (PASS/FAIL).

4. **Orchestrator Integration** — Cross-reference issues from both reviewers:
   - Issues found by BOTH (high confidence)
   - Issues found by V1 only
   - Issues found by V2 only
   - Disputed issues (disagreements)

5. **Decision Matrix**:

   | V1 | V2 | Action |
   |----|-----|--------|
   | PASS | PASS | Ship! |
   | PASS | FAIL | Fix V2's P0/P1, re-run V2 |
   | FAIL | PASS | Fix V1's CRITICAL/HIGH, re-run V1 |
   | FAIL | FAIL | Fix ALL, re-run both (max 3 cycles) |

6. **Document + Ship** — Write `final-report.md` with full pipeline summary. Present to user with options: push, merge to main, or create PR.

## Orchestrator Rules

1. The orchestrator NEVER fixes code — it spawns agents to fix, then re-runs reviewers.
2. All agents use opus model. No downgrades.
3. Don't be stingy with tokens.
4. All docs go to `claude_docs/saturation-run-{TIMESTAMP}/`.
5. CRITICAL security issues = immediate fix, do NOT ship.

## Full Instructions

Read `~/.claude/skills/saturated-coding/verification.md` for complete agent prompts, review formats, cross-reference template, and final report template.
