# Parallel Workflow (Contract-Driven)

This document defines how multiple domain agents can work in parallel **without** weakening root `AGENTS.md` rules.

## Definition

Parallel work is **not** "simultaneous ad-hoc coding".
Parallel work means:

- **Contract-first**: shared interfaces are documented and approved first.
- **Independent implementation**: each domain agent implements only within its scope.
- **Sync points**: integration is validated at scheduled checkpoints with explicit checklists.

## Preconditions (Hard Gates)

Parallel implementation may start only when:

- Workspace-scoped implementation declares:
  - one active `workspaces/<app-slug>` root
  - a workspace profile path or `Needs Confirmation`
  - allowed write scopes and forbidden paths for every implementation agent
- Relevant contract docs exist and are reviewed:
  - `docs/contracts/*`
- Subtasks are decomposed so that:
  - each Subtask maps to exactly one domain agent as primary owner
  - cross-domain changes are expressed as contract updates + separate owned subtasks
- A sync checklist is selected:
  - `docs/coordination/AGENT_SYNC_CHECKLIST.md`
- "Parallel Start Minimum" sections in relevant contract docs are filled and frozen for the active Task.

## Roles in Parallel Mode

- Integration Coordinator Agent:
  - owns contract updates, drift resolution, sync facilitation
- Domain Implementation Agents:
  - implement their own subtasks only
- Review Agent:
  - validates correctness, intent alignment, scope control
- Security Review Agent:
  - runs security checklist when triggered by scope (auth, tokens, inputs, files, deps, config)

## Workflow

### Phase 0: Contract Draft

- Confirm active workspace metadata when work targets an app under `workspaces/`.
- Update contract(s) first.
- Mark unknowns as **Needs Confirmation** (do not guess).

### Phase 1: Contract Review

- Review Agent approves contract change.
- Security Review Agent is required when:
  - auth/session/token/cookie changes
  - user input validation rules
  - file upload/download
  - dependency or infra config changes

### Phase 2: Subtask Decomposition

Task Agent decomposes work so each domain agent can proceed independently.
Each Subtask must include active workspace, owned write scope, forbidden paths, verification commands, and Git steward status when workspace-scoped.

### Phase 3: Independent Implementation

- Each domain agent implements one Subtask at a time.
- Each domain agent edits only inside the active workspace and assigned owned scope.
- Domain implementation agents do not run Git commands or modify Git metadata.
- If a Subtask requires changing a shared interface:
  - stop implementation
  - update contract first
  - re-decompose if needed

### Phase 4: Sync Point (Integration Review)

Integration Coordinator runs:

- Contract compliance check
- Integration review template
- Required verification commands (project-defined; otherwise Needs Confirmation)

### Phase 5: Handover

Follow root `AGENTS.md` handover rules for Task completion and next-task Subtasks sheet.

## Deadlock Escape Conditions

Stop and escalate to the user if:

- Fix & re-review loops repeat 3 times without convergence
- Verification step fails 3 consecutive times
- Scope becomes ambiguous or requires workspace boundary breach
- A real secret appears at risk of being read/created/committed
