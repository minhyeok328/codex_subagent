# Workspace Profile

## Identity

- App name: Superpowers Smoke
- App slug: superpowers-smoke
- Active root: `workspaces/superpowers-smoke`
- Profile owner: secret_agents smoke test
- Last reviewed: 2026-05-29

## Stack Snapshot

- Primary language: Markdown
- Framework: none
- Package manager: none
- Runtime version: not applicable
- Important lockfiles: none

## Commands

Run commands from the active root unless a command states otherwise.

| Purpose | Command | Required? | Notes |
| --- | --- | --- | --- |
| Manual smoke | `Get-Content notes/login-copy.md` | Yes | Confirms the note renders as text |

## Environment

- Env example path: not applicable
- Dummy keys required: none
- Real env files agents must not read:
  - `.env`
  - `.env.local`

## Implementation Boundaries

Allowed implementation roots:

- `workspaces/superpowers-smoke/notes/**`

Forbidden paths:

- `.git/**`
- `docs/**`
- `workspaces/*` outside `workspaces/superpowers-smoke`
- `.env`
- `.env.local`

Generated or heavy paths to avoid:

- none

## Contracts

- Contract directory: `workspaces/superpowers-smoke/.agent/contracts/`
- Active contract naming pattern: not applicable for this smoke test
- Shared interface contracts required before parallel work: none

## Verification Notes

- Minimal smoke verification: read `notes/login-copy.md`
- Full verification: not applicable
- Known flaky or long-running checks: none

## Git Pointer

This profile only records Git context. Load Git rules separately before commit, branch, push, or PR work.

- Git mode: shell-owned
- Git root: `C:\MinHyeok\secret_agents`
- Git steward: not required

## Agent Notes

- This workspace exists only to test Superpowers subagent delegation.
- The worker may edit only `notes/login-copy.md`.
