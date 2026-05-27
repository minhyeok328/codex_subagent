# Workflow Rules

Use this file when planning, implementing, decomposing, or handing off work.

## Tier Selection

Choose the lightest Tier that preserves safety:

- Tier 0: read-only analysis, explanations, code orientation, or direct answers.
- Tier 1: small low-risk edits with narrow scope.
- Tier 2: normal feature work or several-file changes.
- Tier 3: security-sensitive or data-sensitive changes.
- Tier 4: parallel multi-agent or large cross-domain work.

When unsure, choose the higher Tier.

## Tier 0 Workflow

1. Inspect only the context needed to answer.
2. Do not write implementation code.
3. Report findings, assumptions, and any next step.

No Spec, Task document, Review Agent, or handover artifact is required.

## Tier 1 Workflow

1. State brief scope and verification approach.
2. Implement the focused change.
3. Run relevant verification.
4. Self-review for scope, correctness, and workspace safety.
5. Report changed files and verification results.

Use Tier 2 instead if the change expands beyond a small, focused edit.

## Tier 2 Workflow

1. Write or update a lightweight Spec before implementation.
2. Break work into feature-level Tasks and Subtasks when useful.
3. Implement one Subtask at a time.
4. Review each completed Subtask before moving to the next one.
5. Fix review issues and re-review.
6. Run relevant verification.
7. Report completion and residual risks.

Lightweight Spec format:

```md
## Summary
## Scope
## Acceptance Criteria
## Affected Files
## Verification
```

## Tier 3 Workflow

Use Tier 3 for auth, permissions, user input, files, external APIs, dependencies, configuration, database changes, data storage, logging, or secrets.

1. Write a full Spec.
2. Review the Spec for scope, clarity, missing requirements, contradictions, and security concerns.
3. Break the Spec into feature-level Tasks.
4. Break large Tasks into smaller Subtasks.
5. Implement one Subtask at a time.
6. Run Review Agent checks.
7. Run Security Review Agent checks when triggered.
8. Fix issues and re-review.
9. Run explicit verification.
10. Report completion and anything requiring user confirmation.

Full Spec format:

```md
## Summary
## Goals
## Non-Goals
## User Flow
## Requirements
## Acceptance Criteria
## Constraints
## Risks
## Task Breakdown
## Verification
## Security Review
```

## Tier 4 Workflow

Use Tier 4 for parallel multi-agent or large cross-domain work.

1. Integration Coordinator drafts or updates relevant contracts under `docs/contracts/`.
2. Contracts are reviewed before implementation begins.
3. Task Agent decomposes work into domain-owned Subtasks.
4. Domain agents implement only inside their owned scope.
5. Integration Coordinator runs sync checks under `docs/coordination/`.
6. Review Agent validates correctness and scope.
7. Security Review Agent runs when triggered.
8. Final verification and handover are produced.

Parallel implementation must not begin until relevant contracts are drafted and reviewed.

## Task Format

Use this format when a Task/Subtask document is needed:

```md
### Task: [short English or Korean title]

- Purpose: 이 작업이 필요한 이유를 한글로 설명합니다.
- Scope: 이 작업에서 수정할 범위와 제외할 범위를 한글로 설명합니다.
- Dependencies: 먼저 완료되어야 하는 작업을 적습니다.
- Acceptance Criteria: 완료로 판단할 수 있는 기준을 한글로 구체적으로 적습니다.
- Verification: 실행할 테스트, 빌드, 린트, 수동 확인 방법을 적습니다.
```

## Handover Artifacts

For Tier 3 or Tier 4 top-level Task completion, create:

- `docs/reports/TASK[number]_COMPLETION.md`
- `docs/specs/TASK[next-number]_SUBTASKS.md`

For Tier 1 and Tier 2, create these artifacts only when the user requested formal task tracking or when the work is part of an existing numbered Task sequence.

Completion report should include:

- completion timestamp
- responsible agent
- Spec alignment checklist
- changed files and implementation summary
- test and verification results
- items requiring user confirmation

Next-task instruction sheet should include:

- previous Task report and base branch
- atomic Subtasks in execution order
- target files, local rules, acceptance criteria, and verification commands
- deadlock escape conditions

## Startup Rule

When starting from an existing numbered Task, read the relevant `docs/specs/TASK[number]_SUBTASKS.md` first and summarize the first Subtask's purpose and target files to the user.

For Tier 1 and Tier 2 work that is not part of an existing numbered Task sequence, a short scope note is sufficient.
