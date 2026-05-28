# TASK4 Subtasks: Optional Coordination Docs Cleanup

## Context and Dependencies

- Previous report: `docs/reports/TASK3_COMPLETION.md`
- Base branch: current working branch
- Dependency: TASK3 introduced concise root rules and on-demand rule files under `docs/agent-rules/`.

TASK4 is optional. Run it only if the user wants the existing coordination, contract, and template documents to be further aligned with the new Tier model.

## Subtask 1: Audit Existing Coordination Docs

- Purpose: Identify duplicate or conflicting guidance between the new Tier model and existing documents under `docs/coordination/`, `docs/contracts/`, and `docs/templates/`.
- Scope: Read documents and summarize audit findings only. Do not edit documents in this Subtask.
- Dependencies: `docs/reports/TASK3_COMPLETION.md`
- Acceptance Criteria: Each file is classified as keep, update, merge, or remove candidate, with a short reason.
- Verification: Run `git diff --stat` and confirm no files were modified.

## Subtask 2: Consolidate Duplicate Guidance

- Purpose: Remove or reduce duplicate multi-agent, contract, and review guidance so the docs complement `AGENTS.md` and `docs/agent-rules/`.
- Scope: Update documentation text, refresh links, and preserve `Needs Confirmation` markers where uncertainty remains.
- Dependencies: Subtask 1
- Acceptance Criteria: Existing docs no longer repeat the same operating rules at length and do not conflict with the root `AGENTS.md` or `docs/agent-rules/`.
- Verification: Use `Select-String` to check key document links and `Needs Confirmation` markers.

## Subtask 3: Final Review and Verification

- Purpose: Confirm the full documentation structure is understandable and does not weaken safety rules.
- Scope: Review documentation, search for secret-like patterns, and check Git status.
- Dependencies: Subtask 2
- Acceptance Criteria: Review result is Approved, no sensitive information was added, and changes remain documentation-only.
- Verification: Run `git status --short`, confirm `.gitignore` environment protection, and search for secret-like patterns.

## Deadlock Escape Conditions

- Stop and ask the user for guidance if the same documentation cleanup direction conflicts three consecutive times.
- If existing docs strongly assume a project structure that does not exist yet, keep `Needs Confirmation` and ask for user confirmation.
