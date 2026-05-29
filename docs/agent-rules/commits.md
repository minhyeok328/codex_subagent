# Commit Rules

Use this file before creating commits.
Use the `commit-workflow` skill for staging, splitting, writing commit messages, rewriting commits, or creating commits.

Agents must follow the official Conventional Commits 1.0.0 specification:

https://www.conventionalcommits.org/en/v1.0.0/

## Structure

```md
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Rules

- Each commit should map to one completed Subtask whenever possible.
- The commit message must start with a type.
- Use `feat` for a new feature.
- Use `fix` for a bug fix.
- Other allowed types include `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, and `build`.
- Scope is required in parentheses, such as `feat(auth):`.
- Description must follow the colon and space.
- Description must be concise, start with lowercase, and not end with a period.
- Add a body when the change needs context, implementation notes, or verification details.
- Add footers using git trailer-style formatting.
- Include issue references when the Task/Subtask maps to an issue, such as `Refs: #123`, `Closes: #123`, or `Fixes: #123`.
- Mark breaking changes with `!` after the type/scope or with `BREAKING CHANGE:` in the footer.
- Commit headers must be scoped English conventional headers: `type(scope): summary`.
- Do not create unscoped headers such as `type: summary`.
- Do not create lump commits when changes can be split by logical scope.

## Git Steward Agent

Use Git Steward Agent for staging, committing, commit splitting, commit rewriting, branch work, push work, or PR preparation.

Implementation agents must not run Git commands, commit, branch, push, or modify Git metadata.
Git Steward work is separate from implementation work.

Before staging or committing, Git Steward must confirm:

- Git target: `shell` | `active app` | `none` | `Needs Confirmation`
- active workspace, when app-scoped
- Git root
- current branch
- dirty files
- which changed files belong to the user's request
- which changed files appear unrelated
- whether changed files belong to shell governance or app workspace
- whether generated files, real env files, credentials, local databases, generated secrets, or secret-like values are present
- Conventional Commit type and scope

No staging or commit may happen until Git target is declared as `shell`, `active app`, `none`, or `Needs Confirmation`.

## Commit Workflow Skill

When creating commits, rewriting or splitting commits, staging changes, or writing commit messages, use the `commit-workflow` skill.

Required behavior:

- Run `git status --short` before staging.
- Enumerate changed and untracked files.
- Inspect every changed file that may be committed before staging.
- Inspect untracked directories before staging them.
- Identify unrelated changes and leave them unstaged unless the user explicitly asks to include them.
- Split commits by logical scope.
- Stage only files or hunks that belong to the current scope.
- Re-check `git diff --cached --stat` and cached diff before each commit.
- Write scoped English conventional commit messages.
- Show the new commit hash and header after committing.
- Run `git status --short` after committing.

## Git Targets

Shell Git is for governance and operating-shell changes, including:

- `AGENTS.md`
- `AGENTS.ko.md`
- `docs/**`
- shell templates, onboarding, agent rules, coordination docs, and simulations

Active app Git is for one app workspace, including:

- `workspaces/<app-slug>/**`
- `workspaces/<app-slug>/.agent/profile.md`
- `workspaces/<app-slug>/.agent/contracts/**`
- app source, tests, config, and app-local docs

Do not mix shell Git and active app Git changes in one commit unless the user explicitly approves it.
Do not mix changes from multiple app workspaces in one commit.

For app-scoped work, Git Steward must read the workspace profile Git Pointer before staging:

```text
Git mode:
Git root:
Git steward:
```

## Pre-Stage Classification

Before staging, classify changed files:

| File group | Target | Default action |
| --- | --- | --- |
| `AGENTS.md`, `AGENTS.ko.md`, `docs/**` | shell | Shell commit |
| `workspaces/<active-app>/**` | active app | App commit |
| other `workspaces/*` | none | Block unless explicitly assigned |
| `.env`, `.env.local`, credentials, local databases, generated secrets | none | Block |
| generated caches or build artifacts | none | Confirm before staging |
| unrelated existing changes | none | Leave unstaged |

Do not stage with broad commands such as `git add .` unless the file classification has already shown that every staged path belongs to the same intended commit scope.

## Git Steward Stop Conditions

Stop and ask for confirmation if:

- Git target is unclear
- changes span shell and active app Git targets
- changes span multiple app workspaces
- changed files include real env files, credentials, local databases, generated secrets, or secret-like values
- current branch is unexpected for the requested commit
- requested staging would include unrelated files
- app workspace has no Git repo but app Git is requested
- submodule, subtree, or nested repo ownership is unclear

## Examples

```md
feat(auth): add session refresh flow

Add refresh-token handling when a session expires.
Verification: ran auth API tests and manually checked the expired-session flow.

Refs: #42
```

```md
fix(api): handle missing project id
docs(agents): document folder-level inheritance
refactor(tasks): split handover template generation
test(auth): add expired token coverage
feat(api)!: change project response format

BREAKING CHANGE: project responses now wrap data in a result object
```

## Environment Safety Before Staging

Before staging or committing:

- Check that `.env`, `.env.local`, and real environment files are ignored.
- Do not stage real secrets or local credential files.
- Use `.env.example` with dummy values for shared structure.
