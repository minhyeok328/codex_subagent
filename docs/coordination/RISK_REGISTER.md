# Risk Register (Parallel Agent Operation)

This register tracks workflow and architecture risks introduced by parallel work, and how we mitigate them.

## How to Use

- Add new risks as they are discovered.
- For unknowns, use **Needs Confirmation**.
- Do not record secrets or production credentials.

## Risks

### R-001: Contract drift between agents

- Description: Parallel agents implement based on different assumptions about interfaces.
- Impact: Integration failures, rework, inconsistent UX, broken deployments.
- Mitigation:
  - Contract-first gating (`docs/contracts/*`)
  - Sync point checklist (`docs/coordination/AGENT_SYNC_CHECKLIST.md`)
  - Integration review template
- Owner: Integration Coordinator Agent
- Status: Active

### R-002: Hidden coupling across Backend/DB/Frontend

- Description: A Subtask appears domain-scoped but requires cross-domain changes.
- Impact: Frequent interrupts, repeated reviews, slow progress.
- Mitigation:
  - Re-split Subtasks when coupling is discovered
  - Move shared parts into explicit contract updates first
- Owner: Task Agent
- Status: Active

### R-003: Security regressions during fast parallel iteration

- Description: Auth/input/file/dependency changes slip through without full security review.
- Impact: Vulnerabilities, secret exposure, compliance risk.
- Mitigation:
  - Security Review Agent gate for security-sensitive scopes
  - Never commit real `.env` files; enforce `.gitignore`
- Owner: Security Review Agent
- Status: Active

### R-004: Workspace boundary violations (accidental)

- Description: Tools/scripts or commands access outside the repo.
- Impact: Data leakage, unintended modifications, irreproducibility.
- Mitigation:
  - Hard stop and escalate to user
  - Keep commands project-local
- Owner: All agents
- Status: Active

### R-005: OS-specific absolute paths in docs/specs

- Description: Specs include absolute paths that don't match teammates' OS.
- Impact: Confusion, broken instructions.
- Mitigation:
  - Prefer relative paths and repo-root references
  - Mark as Needs Confirmation if absolute path is unavoidable
- Owner: Spec Agent / Task Agent
- Status: Active
