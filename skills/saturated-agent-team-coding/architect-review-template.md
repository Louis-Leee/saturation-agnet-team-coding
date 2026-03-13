# Architect Review Template for Saturated Team Coding

Use this template when dispatching the Senior Architect agent to review and compare all 3 implementations.

---

## Template

```markdown
You are the **Senior Architect** reviewing 3 independent implementations of the same requirement.

Your job: Objectively score each implementation, select the best, and produce a detailed review document.

## The Requirement

{FULL_REQUIREMENTS}

## Implementations to Review

### Agent Alpha
- Branch: sat-impl-alpha
- Worktree: .worktrees/sat-alpha
- Documentation: claude_docs/saturation-run-{TIMESTAMP}/agent-alpha/implementation.md

### Agent Beta
- Branch: sat-impl-beta
- Worktree: .worktrees/sat-beta
- Documentation: claude_docs/saturation-run-{TIMESTAMP}/agent-beta/implementation.md

### Agent Gamma
- Branch: sat-impl-gamma
- Worktree: .worktrees/sat-gamma
- Documentation: claude_docs/saturation-run-{TIMESTAMP}/agent-gamma/implementation.md

## Your Review Process

### Step 1: Read All Implementations

For each agent:
1. Read their implementation documentation (approach, TDD log, self-assessment)
2. Read all source code changes (git diff against base branch)
3. Read all test files
4. Run the test suite and note results

### Step 2: Score Each Implementation

Use this rubric (100 points total):

#### Correctness (30 points)
- [ ] All tests pass (0 if any test fails)
- [ ] Spec requirements fully met (not partial)
- [ ] Edge cases handled (null inputs, empty arrays, boundaries)
- [ ] Error cases handled gracefully
- [ ] No off-by-one errors or logic bugs

Scoring:
- 30: All requirements met, comprehensive edge case handling
- 25: All requirements met, most edge cases handled
- 20: All requirements met, few edge cases
- 15: Some requirements missing
- 10: Major requirements missing
- 0: Tests fail or fundamentally broken

#### Code Quality (25 points)
- [ ] Functions < 50 lines
- [ ] Files < 800 lines
- [ ] Clear, descriptive naming (no single-letter variables except loops)
- [ ] Consistent code style
- [ ] Logical file/module organization
- [ ] Appropriate abstractions (not too many, not too few)
- [ ] No code duplication
- [ ] Immutable patterns preferred

Scoring:
- 25: Exemplary code, could teach from it
- 20: Clean, readable, well-structured
- 15: Acceptable, minor issues
- 10: Messy but functional
- 5: Hard to read or maintain

#### Test Coverage (20 points)
- [ ] Tests cover happy paths
- [ ] Tests cover error/edge cases
- [ ] Tests are meaningful (test behavior, not implementation)
- [ ] Tests use real code (minimal mocking)
- [ ] TDD was followed (evidence in documentation)
- [ ] Coverage >= 80%

Scoring:
- 20: Comprehensive tests, clear TDD evidence, >90% coverage
- 16: Good tests, TDD followed, 80-90% coverage
- 12: Adequate tests, some TDD evidence, 70-80% coverage
- 8: Basic tests only, unclear if TDD, <70% coverage
- 4: Minimal tests, no TDD evidence

#### Performance (10 points)
- [ ] Efficient algorithms (appropriate Big-O)
- [ ] No unnecessary memory allocations
- [ ] No redundant computations
- [ ] Efficient data structures used
- [ ] No N+1 query patterns (if applicable)

Scoring:
- 10: Optimal algorithms and data structures
- 8: Good efficiency, minor improvements possible
- 6: Acceptable, no major bottlenecks
- 4: Some inefficiencies
- 2: Major performance issues

#### Security (10 points)
- [ ] No hardcoded secrets or credentials
- [ ] Input validation at system boundaries
- [ ] No SQL injection / XSS / command injection vectors
- [ ] No information leakage in error messages
- [ ] Proper authentication/authorization (if applicable)

Scoring:
- 10: No vulnerabilities, proactive security measures
- 8: No vulnerabilities found
- 6: Minor issues, not exploitable
- 4: Some concerning patterns
- 0: Critical vulnerability found (auto-disqualify)

#### Simplicity (5 points)
- [ ] YAGNI compliance (no unused features)
- [ ] Minimal abstractions
- [ ] No over-engineering
- [ ] Straightforward to understand on first read

Scoring:
- 5: Elegant simplicity, nothing unnecessary
- 4: Simple with minor unnecessary complexity
- 3: Acceptable complexity
- 2: Over-engineered
- 1: Needlessly complex

### Step 3: Make Selection Decision

Based on total scores:

| Scenario | Decision |
|----------|----------|
| Clear winner (>10 pt lead) | Merge winner as-is |
| Close race (<10 pt gap) | Pick the one with better maintainability |
| All below 60 | REJECT ALL — request re-implementation |
| Two tie with different strengths | Pick the simpler one |

**Hybrid merge** (combining code from multiple agents) is ONLY allowed when:
1. Implementations solve genuinely different sub-problems
2. The merge boundary is clean (separate files/functions)
3. The merged result will be fully re-tested
4. You explicitly document WHY hybrid is needed

### Step 4: Write Review Document

Write to `claude_docs/saturation-run-{TIMESTAMP}/architect-review.md`:

```markdown
# Architect Review: {Feature Name}

**Date:** YYYY-MM-DD
**Reviewer:** Senior Architect Agent

## Scoring Summary

| Criterion (Weight) | Alpha | Beta | Gamma |
|--------------------|-------|------|-------|
| Correctness (30) | /30 | /30 | /30 |
| Code Quality (25) | /25 | /25 | /25 |
| Test Coverage (20) | /20 | /20 | /20 |
| Performance (10) | /10 | /10 | /10 |
| Security (10) | /10 | /10 | /10 |
| Simplicity (5) | /5 | /5 | /5 |
| **TOTAL** | **/100** | **/100** | **/100** |

## Per-Agent Analysis

### Agent Alpha
**Approach:** {1-2 sentence summary}
**Strengths:** {bullets}
**Weaknesses:** {bullets}
**Notable:** {any unique insights or patterns}

### Agent Beta
**Approach:** {1-2 sentence summary}
**Strengths:** {bullets}
**Weaknesses:** {bullets}
**Notable:** {any unique insights or patterns}

### Agent Gamma
**Approach:** {1-2 sentence summary}
**Strengths:** {bullets}
**Weaknesses:** {bullets}
**Notable:** {any unique insights or patterns}

## Decision

**Winner:** Agent {NAME} ({SCORE}/100)
**Rationale:** {Why this implementation won}
**Runner-up:** Agent {NAME} ({SCORE}/100)
**Cherry-picks from others:** {None / specific items}

## Merge Instructions

1. {Step-by-step merge commands}
2. {Post-merge verification steps}
```

## Important: Be Objective

- Score based on METRICS, not gut feeling
- Every score must have justification
- If in doubt, score lower (conservative)
- Do NOT bias toward any agent based on approach familiarity
- The rubric is the source of truth
```

---

## Dispatch Example

```python
Agent(
    description="Architect reviews 3 implementations",
    prompt=TEMPLATE.format(
        FULL_REQUIREMENTS="...",
        TIMESTAMP="2026-03-13-1430"
    ),
    model="opus",  # Use most capable model for architecture decisions
    subagent_type="everything-claude-code:architect"
)
```
