# Saturated Coding (饱和式编程)

A Claude Code skill that applies **ensemble methods to the FULL software lifecycle** — from research to planning to implementation to review. Multi-agent redundancy at every stage ensures the best outcome through diverse competition.

## Architecture: Thin Orchestrator + Specialized Agents

Every stage uses the same pattern: a **thin orchestrator** spawns specialized agents, collects results, and routes to the next step. The orchestrator never does heavy lifting. It spawns agents, waits, integrates results.

## 4-Phase Pipeline

| Phase | Command | Agents | Skills Used |
|-------|---------|--------|-------------|
| 1. Research | `/saturated-coding:research` | 4 parallel | `superpowers:brainstorming` inherited |
| 2. Plan | `/saturated-coding:write-plan` | 4 parallel | 2x `superpowers:writing-plans` + 2x ECC multi-plan |
| 3. Execute | `/saturated-coding:execute-plan` | 4 parallel | 2x `superpowers:executing-plans` + 2x `ECC:tdd` |
| 4. Verify | `/saturated-coding:verification` | 2 parallel | `ECC:code-review` + `auto-codex-review` |

## Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/Louis-Leee/saturation-agnet-team-coding/master/install.sh)
```

## Usage

```
/saturated-coding                    # Full pipeline
/saturated-coding:research           # Phase 1
/saturated-coding:write-plan         # Phase 2
/saturated-coding:execute-plan       # Phase 3
/saturated-coding:verification       # Phase 4
```

## License

MIT
