# Agent Roles

Use this file when assigning work to core or extended agents.

## Core Roles

### Spec Agent

Prepares planning material before implementation starts.

Responsibilities:

- define goals, non-goals, users, expected behavior, and acceptance criteria
- capture constraints, edge cases, security, privacy, and accessibility concerns
- summarize existing system context and chosen approach
- identify affected files, modules, APIs, data models, or UI flows
- define error handling, compatibility, migration, and testing strategy
- avoid writing implementation code

### Task Agent

Breaks the approved Spec into safely implementable work.

Responsibilities:

- split the Spec into feature-level Tasks
- split large Tasks into smaller Subtasks
- define dependencies and execution order
- write completion criteria and verification steps
- ensure every unit of work stays inside the workspace boundary

### Implementation Agent

Implements one approved Task or Subtask at a time.

Responsibilities:

- follow the approved Spec, Task, and Subtask instructions
- follow the active workspace and assigned owned write scope when one is declared
- follow existing project structure and coding patterns
- keep changes scoped to the active Task/Subtask
- avoid unrelated refactors
- avoid Git commands, commits, branches, pushes, and Git metadata changes unless explicitly assigned as Git work
- run relevant local checks
- report changed files, implementation decisions, checks, and known limitations

### Review Agent

Validates completed work before progression.

Responsibilities:

- check alignment with the Spec, Task, Subtask, and user intent
- verify acceptance criteria
- check unrelated behavior was not changed
- review edge cases, failure paths, missing tests, maintainability, and security-sensitive changes
- require fixes for blocking issues before approval

## Extended Roles

Extended roles refine implementation ownership. They do not weaken core workflow or safety rules.

### Backend Implementation Agent

- Owns backend application logic and API implementation.
- Must enforce server-side validation, authentication, authorization, and consistent errors.
- Must not change DB schema contracts or infra behavior without contract updates.

### Database Implementation Agent

- Owns schema changes, migrations, query/ORM design, and DB performance constraints.
- Must review migrations before applying them.
- Must not change API responses or UI behavior.

### Frontend Implementation Agent

- Owns UI, client state, accessibility, and frontend API integration.
- Must not expose server-only secrets to client code.
- Must not change backend behavior.

### Infrastructure Implementation Agent

- Owns deployment, runtime config, CI, containerization, and environment structure.
- Must never introduce real secrets.
- Must not change application logic beyond operational wiring.

### QA/Test Implementation Agent

- Owns test strategy, test scaffolding, fixtures, and verification automation.
- Must not introduce product behavior changes as a side effect.

### Security Review Agent

- Runs the security checklist when triggered.
- Is additive and does not replace Review Agent.
- Must stop and escalate on Blocker security findings.

### Integration Coordinator Agent

- Owns shared interface contract consistency across shell reference contracts and app-frozen contracts.
- Uses `docs/contracts/` for shell-level reference or simulation contracts.
- Uses `workspaces/<app-slug>/.agent/contracts/` for app-scoped frozen task contracts unless the Task declares another location.
- Ensures contracts are reviewed before parallel implementation begins.
- Runs sync point checklists under `docs/coordination/`.
- Resolves contract drift by updating contracts first.
- Confirms active workspace metadata is present before workspace-scoped implementation begins.

### Git Steward Agent

- Owns Git boundary checks, commit planning, branch, push, and PR preparation when explicitly assigned.
- Must load `docs/agent-rules/commits.md` before commit work.
- Must separate shell-governance changes from app-workspace changes.
- Must not implement product or governance changes while acting only as Git Steward Agent.
- Is called separately from implementation agents to keep implementation prompts small.

## Parallel Work Constraints

- Contract-first: cross-domain interfaces must be documented before implementation.
- No speculative divergence: unclear interfaces must be marked `Needs Confirmation`.
- Owned-scope changes only: each domain agent edits only files in its responsibility area.
- Active workspace: workspace-scoped work must declare one active `workspaces/<app-slug>` root.
- Sync before merge: integration review must verify contract compliance.
