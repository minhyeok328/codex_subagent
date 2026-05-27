# TASK3: Implementation Agents Restructure (Parallel, Contract-Driven)

## Summary

This Task restructures the single "Implementation Agent" role into multiple **domain-scoped Implementation Agents** that can work in parallel **only after shared contracts are documented**.

The root `AGENTS.md` safety model remains unchanged:

- Spec → Task → Subtask decomposition happens before implementation.
- Work stays inside the workspace boundary.
- One Subtask is implemented at a time per agent.
- Each Subtask is reviewed and verified before progressing.
- Deadlock escalation after three consecutive fix/review loops is preserved.

## Goals

- Enable parallel progress by splitting implementation responsibilities into domain-scoped roles:
  - Backend Implementation Agent
  - Database Implementation Agent
  - Frontend Implementation Agent
  - Infrastructure Implementation Agent
  - QA/Test Implementation Agent
  - Security Review Agent
  - Integration Coordinator Agent
- Define **contract-first** workflow that prevents speculative divergence across agents.
- Introduce shared documentation artifacts that act as **single sources of truth** for cross-domain interfaces.

## Non-Goals

- Not introducing new application code, APIs, schemas, or infrastructure in this Task.
- Not weakening root security rules, workspace boundary rules, or review/handover rules.
- Not defining product requirements beyond the agent workflow and documentation structure.

## Key Principles (Must Not Weaken Root Rules)

- Parallel work is defined as **"contract-based independent implementation + scheduled sync points"**, not "simultaneous ad-hoc coding".
- Each Implementation Agent may only modify files within its owned scope (as defined by folder-level rules and/or Subtask scope).
- Cross-agent work **requires contract updates first** (docs/contracts), then independent implementations, then integration review.
- Any uncertainty must be documented as **"Needs Confirmation"** rather than codified as a hard rule.
- Never read, generate, or commit real secrets (tokens, passwords, keys). Use `.env.example` with dummy values only.
- If a Subtask needs access outside the workspace, stop immediately and escalate to the user.

## New Role Definitions (Additive)

This Task defines additional roles. It does **not** remove the existing four core roles; it refines how "Implementation" work is executed.

### Backend Implementation Agent

- Owns backend application logic and API implementation.
- Must not change DB schema contracts or infra deployment behavior without contract changes + Integration sync.

### Database Implementation Agent

- Owns schema changes, migrations, query/ORM-layer design rules, and DB performance constraints.
- Must not change API responses or UI behavior.

### Frontend Implementation Agent

- Owns UI, client state, and frontend integration with backend APIs as defined by contracts.
- Must not change backend behavior.

### Infrastructure Implementation Agent

- Owns deployment, runtime config, CI, containerization, and environment structure (never real secrets).
- Must not change application logic beyond wiring and operational concerns.

### QA/Test Implementation Agent

- Owns test strategy, test scaffolding, fixtures (non-secret), and verification automation.
- Must not introduce product behavior changes as a side effect.

### Security Review Agent

- Specialized reviewer that runs the existing security checklist when triggered by scope (auth, tokens, user input, file handling, dependencies, configs, etc.).
- Does not replace the Review Agent; it is an **additional gate** when relevant.

### Integration Coordinator Agent

- Owns cross-agent contracts and the sync workflow.
- Ensures that all parallel changes converge on:
  - documented contracts
  - integration review
  - agreed verification commands

## Required Contract Artifacts

Contracts are the only allowed source of truth for cross-domain interfaces:

- `docs/contracts/API_CONTRACT.md`
- `docs/contracts/DB_SCHEMA_CONTRACT.md`
- `docs/contracts/FRONTEND_BACKEND_CONTRACT.md`
- `docs/contracts/INFRA_DEPLOYMENT_CONTRACT.md`

Parallel implementation must not begin until the relevant contract(s) are drafted and approved.

## Parallel Workflow (High-Level)

1. Integration Coordinator drafts/updates contract(s).
2. Contracts are reviewed (Review Agent + Security Review Agent when relevant).
3. Task Agent decomposes work into Subtasks that each map to a single domain agent.
4. Domain agents implement Subtasks independently (each stays within its scope).
5. Sync point: Integration Coordinator runs integration review checklist and resolves contract drift.
6. Final review and handover artifacts are produced per root rules.

## Acceptance Criteria

- Documentation structure exists under:
  - `docs/contracts/`
  - `docs/coordination/`
  - `docs/templates/`
- Root `AGENTS.md` is updated to describe the new roles and contract-driven parallel workflow **without weakening** existing rules.
- `AGENTS.ko.md` is updated in the same change to remain synchronized.
- Each new role has a clear ownership boundary and escalation rules.
- All new docs include "Needs Confirmation" markers for unknowns instead of making assumptions.

## Risks / Needs Confirmation

- Needs Confirmation: Actual codebase structure (e.g. whether `backend/`, `frontend/`, `infra/` exist) is not established yet; ownership rules must be aligned to the real folder layout when it exists.
- Needs Confirmation: Repository default workspace path references in previous docs show a non-Windows path; future Specs should avoid hardcoding OS-specific absolute paths.

## Verification

- Ensure no new secret-like strings are introduced outside `.env.example`.
- Ensure contracts are docs-only and contain no credentials.
- Grep for placeholder markers:
  - `Needs Confirmation`
- Ensure `AGENTS.md` and `AGENTS.ko.md` remain synchronized after edits.
