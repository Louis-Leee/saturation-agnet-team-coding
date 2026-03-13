# Merge Strategy for Saturated Team Coding

Detailed guidance on how the Senior Architect selects and merges the winning implementation.

---

## Decision Matrix

### Scenario 1: Clear Winner (>10 point lead)

```
Alpha: 89/100
Beta:  75/100
Gamma: 78/100
Gap:   11 points (Alpha vs Gamma)
```

**Action:** Merge Alpha's branch directly.

```bash
git checkout -b sat-integration main
git merge sat-impl-alpha --no-ff -m "feat: merge Alpha implementation (89/100)"
```

**Why this works:** Large score gap means clear quality difference. No need for hybrid.

---

### Scenario 2: Close Race (<10 point gap between top 2)

```
Alpha: 87/100
Beta:  84/100
Gamma: 72/100
Gap:   3 points (Alpha vs Beta)
```

**Action:** Apply tiebreaker criteria:

| Tiebreaker | Priority | Rationale |
|------------|----------|-----------|
| 1. Test coverage | Highest | Better tested = more maintainable |
| 2. Simplicity score | Higher | Simpler = fewer bugs long-term |
| 3. Code quality score | Higher | Cleaner = easier to extend |
| 4. Security score | Higher | Security flaws are expensive |

Pick the one that wins on most tiebreaker criteria. If truly tied, pick the **simpler** one.

---

### Scenario 3: All Below 60 (All Weak)

```
Alpha: 58/100
Beta:  52/100
Gamma: 55/100
```

**Action:** REJECT ALL. Do not merge any.

**Root cause analysis:**
1. Requirements unclear? → Rewrite requirements.md with more specifics
2. Task too complex? → Break into smaller sub-tasks
3. Wrong approach? → Provide architectural guidance in requirements
4. Missing context? → Add more code context and examples

**Re-run** with improved requirements after root cause is addressed.

---

### Scenario 4: Hybrid Merge (Rare, Use Sparingly)

```
Alpha: 85/100 — Best error handling, good tests
Beta:  83/100 — Best performance, clean algorithms
Gamma: 70/100 — Best documentation but weaker code
```

**Hybrid is ONLY justified when:**
1. Implementations solve genuinely different sub-problems
2. The merge boundary is clean (separate files or clearly separable functions)
3. No code from the two agents overlaps in the same file/function
4. The combined result will be fully re-tested

**Example of valid hybrid:**
- Alpha implemented the API validation layer (files: `validators/*.py`)
- Beta implemented the core algorithm (files: `algorithms/*.py`)
- These are cleanly separable

**Example of INVALID hybrid:**
- Alpha's error handling is better in `main.py`
- Beta's algorithm is better in `main.py`
- These overlap in the same file — DO NOT HYBRID

**Hybrid merge steps:**
```bash
# Start from winner
git checkout -b sat-integration sat-impl-alpha

# Cherry-pick specific commits from runner-up
git cherry-pick <specific-commit-hash-from-beta>

# Resolve any conflicts carefully
# Re-run ALL tests
pytest --cov
```

---

## Post-Merge Verification Checklist

After ANY merge (standard or hybrid):

- [ ] ALL original tests from winning agent pass
- [ ] ALL existing project tests pass
- [ ] No merge conflicts remain
- [ ] Code coverage >= 80% on new code
- [ ] No new linting/type errors introduced
- [ ] Git history is clean (no merge artifacts)

```bash
# Verification commands
git diff --stat main..sat-integration  # See what changed
pytest --cov --cov-report=term-missing  # Run tests with coverage
# or: npm test -- --coverage
# or: go test ./... -cover
```

---

## Anti-Patterns

| Anti-Pattern | Why It's Bad | Do This Instead |
|-------------|-------------|-----------------|
| Cherry-picking functions from 3 agents | Untested Frankenstein code | Merge one winner, fully re-test |
| Merging without running tests | False confidence | ALWAYS verify post-merge |
| Preferring "clever" over "simple" | Clever breaks, simple lasts | Pick the simpler implementation |
| Ignoring security scores | Security debt compounds | Never merge code with security issues |
| Architect overriding rubric | Subjectivity defeats purpose | Trust the scoring rubric |
| Keeping "backup" branches | Branch pollution | Delete non-winning branches immediately |

---

## Branch Cleanup

After successful merge and verification:

```bash
# Remove worktrees
git worktree remove .worktrees/sat-alpha 2>/dev/null
git worktree remove .worktrees/sat-beta 2>/dev/null
git worktree remove .worktrees/sat-gamma 2>/dev/null

# Delete implementation branches
git branch -D sat-impl-alpha sat-impl-beta sat-impl-gamma

# Optionally: merge integration to main
git checkout main
git merge sat-integration --no-ff
git branch -D sat-integration
```
