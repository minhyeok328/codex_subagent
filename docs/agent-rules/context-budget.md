# Context Budget Rules

Use this file when preparing agent, subagent, review, or handover context.
The goal is to keep prompts small while preserving the rules needed for safe work.

## Core Principle

Load the smallest rule set that lets the current role act safely.
Prefer short task-local summaries and file references over pasting full rule files into every agent prompt.

## Always-On Context

Every agent must follow:

- root `AGENTS.md`
- the user's explicit request
- the current Task, Subtask, or review assignment
- the declared workspace boundary for the task

Do not duplicate long sections from root rules in subagent prompts. Use concise reminders only when they prevent likely misuse.

## Role-Based Loading

Load detailed rules only when the role or task needs them:

| Situation | Load |
| --- | --- |
| Formal Planning, Full Delivery planning, Spec writing, or Task/Subtask creation | `docs/agent-rules/workflow.md` |
| Role assignment or multi-agent work | `docs/agent-rules/roles.md` |
| Subagent launch or integration | `docs/agent-rules/subagent-execution.md` |
| Active app or workspace-scoped implementation | `docs/agent-rules/workspaces.md` |
| Review-only work | `docs/agent-rules/review.md` |
| Security-triggered work | `docs/agent-rules/security-review.md` |
| Commit, branch, push, or PR work | `docs/agent-rules/commits.md` |
| Folder-level `AGENTS.md` creation | `docs/agent-rules/templates.md` |

If a rule file is not needed for the current role, reference it by path only or omit it.

## Subagent Context Capsule

Implementation subagents should usually receive a compact task card, not the full planning packet.
Use `docs/templates/SUBAGENT_TASK_CARD.template.md` as the default shape.
Use `docs/agent-rules/subagent-execution.md` for launch gates, stop conditions, and output integration.

Minimum fields:

- active workspace
- profile path
- role
- Subtask reference
- allowed write scope
- read-only context
- forbidden paths
- verification commands
- stop conditions

## Heavy Context Rules

- Summarize large Specs, contracts, or handovers into task-local headers before launching subagents.
- Include full contracts only for agents that must implement or review against those contract details.
- Include security checklists only when a security trigger applies.
- Include commit rules only for explicit Git work.
- Do not include unrelated app, repo, or workspace history.

## Implementation Agent Defaults

Implementation agents should receive these reminders unless the Task explicitly says otherwise:

- Do not run Git commands.
- Do not commit, branch, push, or modify Git metadata.
- Do not edit outside the assigned write scope.
- Treat governance docs as read-only unless the assignment explicitly says to edit them.
- Stop and report if the work requires a contract, profile, security, or Git policy change.

## Output Discipline

Subagent output should be concise and reviewable:

- changed files
- decisions made
- verification commands and results
- assumptions or `Needs Confirmation` items
- security-sensitive areas touched

Avoid restating all input context in the output.
