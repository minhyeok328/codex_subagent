# Subagent Task Card

Use this compact card when launching an implementation subagent.
Do not paste full rule files unless the agent must act on them directly.
Follow `docs/agent-rules/subagent-execution.md` for launch gates, stop conditions, required output, and orchestrator integration.

## Activation

- Active workspace:
- Workspace profile:
- Task / Subtask:
- Role:
- Tier:

## Required Read Context

- `AGENTS.md`
- `docs/agent-rules/context-budget.md`
- `docs/agent-rules/subagent-execution.md`
- `docs/agent-rules/workspaces.md`
- Workspace profile:
- Spec/Subtask:
- Contracts:

## Allowed Write Scope

-

## Read-Only Context

-

## Forbidden Paths

- `docs/**` unless explicitly assigned
- `workspaces/*` outside the active workspace
- `.git/**`
- real `.env`, `.env.local`, credentials, local databases, generated secrets
-

## Mission

-

## Acceptance Criteria

-

## Verification

Run from the active workspace unless stated otherwise.

-

## Stop Conditions

Stop and report if:

- the active workspace is ambiguous
- the change requires files outside allowed write scope
- the change requires contract updates not assigned to this subtask
- the change triggers security review but no Security Review Agent is assigned
- the change requires Git commands or Git metadata changes
- verification commands are missing or unsafe to infer

## Output Required

- Status: Completed | Blocked | Needs Confirmation
- Changed files:
- Summary:
- Verification:
- Contract impact:
- Security impact:
- Assumptions:
- Follow-up required:
