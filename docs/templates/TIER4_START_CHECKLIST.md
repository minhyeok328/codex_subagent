# Tier 4 Parallel Start Checklist

Use this checklist before starting any Tier 4 parallel multi-agent work.
Parallel implementation may begin only after every required gate is answered and any blocking `Needs Confirmation` item is resolved.

## Metadata

- Task / Spec:
- Date/time:
- Integration Coordinator Agent:
- Requested outcome:
- Source request:
- Active workspace:
- Workspace profile:
- Related docs:
  - `AGENTS.md`
  - `docs/agent-rules/context-budget.md`
  - `docs/agent-rules/subagent-execution.md`
  - `docs/agent-rules/workspaces.md`
  - `docs/agent-rules/workflow.md`
  - `docs/agent-rules/roles.md`
  - `docs/coordination/PARALLEL_WORKFLOW.md`

## 1) Tier 4 Fit

- [ ] The work is large enough, cross-domain enough, or parallel enough to justify Tier 4.
- [ ] A lower Tier would create coordination, contract, security, or review risk.
- [ ] The expected work can be split into independently owned Subtasks.
- [ ] The user request and acceptance target are understood.

Decision:

- Tier selected: Tier 4
- Reason:
- Not Tier 0/1/2/3 because:

## 2) Workspace Activation Gate

Complete this gate when implementation targets an app under `workspaces/`.

- [ ] Active workspace is declared as `workspaces/<app-slug>`.
- [ ] Workspace profile exists or is marked `Needs Confirmation`.
- [ ] Only one active workspace is in scope for this task.
- [ ] Other `workspaces/*` apps are out of scope.
- [ ] Governance docs are read-only unless this task explicitly assigns policy/template changes.
- [ ] Implementation agents will not run Git commands or modify Git metadata.
- [ ] Git Steward will use `docs/agent-rules/commits.md` and `commit-workflow` when commit work is required.

Workspace status:

| Field | Value | Notes |
| --- | --- | --- |
| Active workspace |  |  |
| Workspace profile |  |  |
| Contract location |  |  |
| Allowed write roots |  |  |
| Forbidden paths |  |  |
| Git steward | Required before commit / Not required / Needs Confirmation |  |
| Git target | shell / active app / none / Needs Confirmation |  |

## 3) Context Budget Gate

- [ ] Subagents will receive compact task cards instead of full planning packets.
- [ ] Required rule files are selected by role.
- [ ] Subagent launch and integration rules are selected: `docs/agent-rules/subagent-execution.md`.
- [ ] Security checklist is loaded only if a security trigger applies.
- [ ] Commit rules are loaded only for explicit Git work.
- [ ] Large Specs or contracts are summarized unless full detail is required.

Context notes:

- Subagent card template:
- Full docs required:
- Summaries prepared:

## 4) Domain Impact Map

Mark every domain touched by the task.

- [ ] Backend application logic / APIs
- [ ] Database schema / migrations / queries
- [ ] Frontend UI / client state / API integration
- [ ] Infrastructure / CI / deployment / runtime config
- [ ] QA / tests / fixtures / verification automation
- [ ] Documentation / specs / reports only
- [ ] Security-sensitive behavior

Notes:

- Primary domains:
- Secondary domains:
- Out of scope:

## 5) Contract Gate

Parallel implementation must not begin until all relevant shared contracts are drafted, reviewed, and frozen for the active task.

- [ ] `docs/contracts/API_CONTRACT.md` reviewed or marked not applicable.
- [ ] `docs/contracts/DB_SCHEMA_CONTRACT.md` reviewed or marked not applicable.
- [ ] `docs/contracts/FRONTEND_BACKEND_CONTRACT.md` reviewed or marked not applicable.
- [ ] `docs/contracts/INFRA_DEPLOYMENT_CONTRACT.md` reviewed or marked not applicable.
- [ ] Every relevant contract has a filled "Parallel Start Minimum" section.
- [ ] Contract unknowns are marked `Needs Confirmation`.
- [ ] No domain agent is expected to guess shared interface behavior.
- [ ] Review Agent has approved the relevant contract set.

Contract status:

| Contract | Applies? | Status | Reviewer | Notes |
| --- | --- | --- | --- | --- |
| `API_CONTRACT.md` | Yes/No | Draft/Approved/Needs Confirmation |  |  |
| `DB_SCHEMA_CONTRACT.md` | Yes/No | Draft/Approved/Needs Confirmation |  |  |
| `FRONTEND_BACKEND_CONTRACT.md` | Yes/No | Draft/Approved/Needs Confirmation |  |  |
| `INFRA_DEPLOYMENT_CONTRACT.md` | Yes/No | Draft/Approved/Needs Confirmation |  |  |

## 6) Ownership Gate

Each Subtask must have exactly one primary implementation owner.

- [ ] Each Subtask has one primary domain owner.
- [ ] Owned files/folders are explicitly listed for each Subtask.
- [ ] Out-of-scope files/folders are explicitly listed for each Subtask.
- [ ] Cross-domain changes are represented as contract updates plus separate owned Subtasks.
- [ ] No Subtask requires two agents to edit the same file at the same time.
- [ ] Handover path is clear for dependent Subtasks.

Ownership map:

| Subtask | Primary Agent | Owned Files/Folders | Explicitly Out of Scope | Dependencies |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |

## 7) Security Trigger Gate

If any item is checked, load `docs/agent-rules/security-review.md` and assign Security Review Agent.

- [ ] Authentication, sessions, cookies, tokens, passwords, or redirects
- [ ] Authorization, roles, ownership, admin behavior, or resource access
- [ ] User input from body, query, params, headers, forms, files, or external APIs
- [ ] Database schemas, migrations, queries, data storage, or sensitive data
- [ ] File upload, download, paths, generated files, or public file access
- [ ] External APIs, webhooks, network calls, dependencies, or configuration
- [ ] Logging, analytics, monitoring, environment variables, or secrets
- [ ] No security trigger applies

Security decision:

- Security Review Agent required: Yes/No
- Reason:
- Security checklist location:

## 8) Verification Plan

Define verification before implementation starts.

- [ ] Lint command identified or marked not applicable.
- [ ] Unit test command identified or marked not applicable.
- [ ] Integration test command identified or marked not applicable.
- [ ] Build command identified or marked not applicable.
- [ ] Manual verification steps identified when automated checks are insufficient.
- [ ] Contract-critical verification is assigned to a responsible agent.

Verification commands:

| Check | Command | Owner | Required? | Notes |
| --- | --- | --- | --- | --- |
| Lint |  |  | Yes/No |  |
| Unit tests |  |  | Yes/No |  |
| Integration tests |  |  | Yes/No |  |
| Build |  |  | Yes/No |  |
| Manual checks |  |  | Yes/No |  |

## 9) Sync Plan

- [ ] Sync checklist selected: `docs/coordination/AGENT_SYNC_CHECKLIST.md`
- [ ] Integration review template selected: `docs/templates/INTEGRATION_REVIEW_TEMPLATE.md`
- [ ] Orchestrator integration step selected: `docs/agent-rules/subagent-execution.md` section 8.
- [ ] Sync points are defined before implementation starts.
- [ ] Drift handling rule is understood: update contracts first, then adjust Subtasks.
- [ ] Deadlock escape conditions are understood.

Sync points:

| Sync Point | Trigger | Participants | Required Evidence |
| --- | --- | --- | --- |
| Contract approval | Before implementation | Integration Coordinator, Review Agent, Security Review Agent if required | Approved contract notes |
| Subagent return check | After each subagent returns | Orchestrator, relevant reviewer if needed | Status, changed files, verification, scope check |
| Midpoint sync | After first domain Subtask completes | Relevant domain agents, Integration Coordinator | Handover + verification status |
| Integration review | Before final handover | Integration Coordinator, Review Agent, Security Review Agent if required | Integration review output |

## 10) Start Decision

Parallel implementation may start only if there are no blocking `Needs Confirmation` items.

- [ ] Tier 4 fit confirmed.
- [ ] Workspace activation confirmed or marked not applicable.
- [ ] Context budget gate confirmed.
- [ ] Relevant contracts approved.
- [ ] Ownership map complete.
- [ ] Security review requirement decided.
- [ ] Verification plan complete.
- [ ] Sync plan complete.
- [ ] No blocking `Needs Confirmation` items remain.

Decision:

- Start approved: Yes/No
- Approved by:
- Conditions:
- Blocking items:

## 11) Subagent Launch Notes

Use `docs/templates/SUBAGENT_TASK_CARD.template.md` for compact implementation launches and `docs/templates/SUBAGENT_PROMPTS.md` when full role prompts are required.
Use `docs/agent-rules/subagent-execution.md` for launch gates, stop conditions, required output, and orchestrator integration.

Launch order:

1. Integration Coordinator Agent confirms contracts and ownership.
2. Task Agent finalizes Subtasks if they are not already final.
3. Domain Implementation Agents begin only approved owned Subtasks.
4. Review Agent reviews each completed Subtask.
5. Security Review Agent reviews triggered security-sensitive work.
6. Integration Coordinator runs sync and final integration review.

Per-agent launch list:

| Agent | Prompt Template | Subtask | May Start? | Notes |
| --- | --- | --- | --- | --- |
| Integration Coordinator Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Task Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Backend Implementation Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Database Implementation Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Frontend Implementation Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Infrastructure Implementation Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| QA/Test Implementation Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Review Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
| Security Review Agent | `SUBAGENT_PROMPTS.md` |  | Yes/No |  |
