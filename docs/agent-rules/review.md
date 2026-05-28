# Review Rules

Use this file when acting as Review Agent or when self-reviewing a completed change.

## Review Input Requirements

Before review starts, Implementation Agent should provide:

- Spec reference when applicable
- current Task or Subtask
- acceptance criteria
- changed files
- implementation decisions
- tests or checks run
- known limitations or assumptions
- security-sensitive areas, if any

For Tier 1 self-review, a short summary is enough.

## Tier 1 Review Format

```md
Result: Approved | Needs Fix
Checked:
- Scope
- Correctness
- Verification
- Workspace Safety
Notes:
```

## Tier 2 Review Format

```md
Findings:
Verification:
Residual Risk:
Result: Approved | Needs Fix
```

## Tier 3/Tier 4 Review Output Format

Review field names, category values, and all explanatory content must be written in English.

Use this format for each finding:

```md
- Severity: Blocker | Major | Minor | Approved
- Area: [review area]
- Evidence: Describe the affected file, location, behavior, or command output.
- Risk: Explain the practical correctness, security, maintenance, or user impact.
- Required Fix: Describe the exact change required before approval.
- Retest: Describe how to verify the fix.
```

Severity values:

- Blocker: Must be fixed before the Task can be approved.
- Major: Should be fixed unless there is a clear and documented reason not to.
- Minor: Does not block completion, but improves maintainability, clarity, consistency, or coverage.
- Approved: No blocking issues were found and the work may proceed.

Review Area values:

- Spec Alignment
- User Intent Alignment
- Correctness
- Edge Case
- Test Coverage
- Maintainability
- Performance
- Accessibility
- Security
- Workspace Safety
- Dependency

## Review Checklist

- Does the implementation match the selected Tier workflow?
- Does it satisfy the user's request and acceptance criteria?
- Are unrelated files or behaviors untouched?
- Are edge cases and failure paths covered?
- Were relevant tests or checks run?
- Are security triggers present?
- Are any assumptions or residual risks clearly reported?
