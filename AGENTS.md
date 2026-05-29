# AGENTS.md

This file defines the always-on rules for agents in this project.

For teammate-facing Korean context, see [AGENTS.ko.md](./AGENTS.ko.md).
Detailed operating rules live under [docs/agent-rules/](./docs/agent-rules/). Load those files only when the current task requires them.

## Instruction Priority

Agents must follow instructions in this order:

1. User's explicit instructions.
2. This root `AGENTS.md`.
3. The nearest folder-level `AGENTS.md` file for local rules that do not weaken root rules.
4. On-demand rule files under `docs/agent-rules/`.
5. General agent defaults.

If instructions conflict, the higher-priority instruction wins. If the correct action is unclear, stop and ask the user before continuing.

## Always-On Safety Rules

These rules apply to every task, regardless of size:

1. Work only inside the current project workspace.
2. Do not read, edit, move, delete, or format files outside the workspace.
3. Do not modify unrelated files or unrelated behavior.
4. Prefer existing project patterns over new abstractions.
5. Run relevant tests, checks, or verification commands before marking work complete.
6. Security, correctness, and maintainability take priority over speed.
7. Never hardcode real secrets or API tokens from `.env`, `.env.local`, or other environment variable files into source code.
8. Never commit real environment files, credentials, local databases, generated secrets, or secret-like values.
9. Share environment structure only through `.env.example` with dummy values.
10. Keep `AGENTS.md` and `AGENTS.ko.md` directionally aligned; `AGENTS.md` is the operational source of truth.

## Workspace Boundary

Allowed inside the workspace:

- Read project files.
- Create, edit, move, or delete files required for the approved task.
- Run project-local commands for development, testing, formatting, and verification.
- Generate temporary, cache, or build artifacts inside the workspace.

Forbidden:

- Do not access unrelated projects, parent directories, user home files, global config files, shell profiles, IDE settings, or OS-level settings.
- Do not use `../` paths to access unrelated projects.
- Do not install or change global dependencies unless explicitly approved by the user.
- Do not run destructive commands outside the approved task scope.
- Do not read heavy unmanaged files such as `.git` internals, large logs, build artifacts, or data files of tens of MB or more unless the user explicitly requests it.
- Do not add `.env`, `.env.local`, or other real environment files to Git.

If a task appears to require access outside the workspace, stop and ask for explicit user approval.

## Task Tiers

Use the lightest workflow that preserves safety.

| Tier | Use For | Required Workflow |
| --- | --- | --- |
| Tier 0 | Questions, analysis, explanations, read-only code inspection | No Spec or Task document required. Answer or report findings. |
| Tier 1 | Small, low-risk edits such as copy, docs, style, focused single-file fixes | Brief scope note, implement, verify, self-review, report. |
| Tier 2 | Normal feature work or changes across several files | Lightweight Spec, Task/Subtask breakdown, implement one Subtask at a time, review, verify. |
| Tier 3 | Security-sensitive, data-sensitive, auth, permissions, migrations, files, external APIs, dependencies, or configuration | Full Spec, Task/Subtask breakdown, Review Agent, Security Review Agent when triggered, explicit verification. |
| Tier 4 | Parallel multi-agent or large cross-domain work | Contract-first workflow, domain-owned Subtasks, sync points, integration review, security review when triggered. |

When unsure, choose the higher tier.

## On-Demand Rule Loading

Load only the files needed for the current task:

- Tier and workflow details: [docs/agent-rules/workflow.md](./docs/agent-rules/workflow.md)
- Role definitions and multi-agent ownership: [docs/agent-rules/roles.md](./docs/agent-rules/roles.md)
- Context budget and rule-loading discipline: [docs/agent-rules/context-budget.md](./docs/agent-rules/context-budget.md)
- Subagent launch and integration protocol: [docs/agent-rules/subagent-execution.md](./docs/agent-rules/subagent-execution.md)
- Active app workspace rules: [docs/agent-rules/workspaces.md](./docs/agent-rules/workspaces.md)
- Review formats and expectations: [docs/agent-rules/review.md](./docs/agent-rules/review.md)
- Security checklist and security review output: [docs/agent-rules/security-review.md](./docs/agent-rules/security-review.md)
- Commit rules: [docs/agent-rules/commits.md](./docs/agent-rules/commits.md)
- Folder-level templates: [docs/agent-rules/templates.md](./docs/agent-rules/templates.md)

## Security Review Triggers

Load `docs/agent-rules/security-review.md` and run the security checklist when a task touches:

- authentication, sessions, cookies, tokens, passwords, or redirects
- authorization, roles, ownership, admin behavior, or resource access
- user input from body, query, params, headers, forms, files, or external APIs
- database schemas, migrations, queries, data storage, or sensitive data
- file upload, download, paths, generated files, or public file access
- external APIs, webhooks, network calls, dependencies, or configuration
- logging, analytics, monitoring, environment variables, or secrets

If a Blocker security issue is found, stop and escalate to the user.

## Commit Rule

Commits must follow Conventional Commits 1.0.0.

Before committing, load [docs/agent-rules/commits.md](./docs/agent-rules/commits.md).

## Progress and Deadlock

- Keep the user informed during long-running work.
- If work continues for 4 minutes, provide a short status update with the active role, active Task/Subtask, current action, and early findings.
- If there is no meaningful progress for 5 minutes, stop and provide a handover summary instead of silently retrying.
- If the same fix/re-review loop, test failure, or implementation deadlock repeats three consecutive times, stop and ask the user for guidance.

## Completion

Before marking work complete:

- Verify the task matches the user's request and the selected Tier workflow.
- Confirm unrelated behavior was not changed.
- Run relevant checks or explain why they are not applicable.
- Report changed files, verification results, assumptions, and residual risks.
