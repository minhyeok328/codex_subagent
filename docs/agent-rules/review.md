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

Review field names and category values must be written in English.
All explanatory content after the colon must be written in Korean.

Use this format for each finding:

```md
- Severity: Blocker | Major | Minor | Approved
- Area: [review area]
- Evidence: 문제가 확인된 파일, 위치, 동작을 한글로 구체적으로 설명합니다.
- Risk: 이 문제가 실제로 어떤 장애, 보안 문제, 유지보수 문제로 이어질 수 있는지 설명합니다.
- Required Fix: 승인 전에 필요한 수정 사항을 구체적으로 적습니다.
- Retest: 수정 후 어떻게 다시 검증해야 하는지 적습니다.
```

Severity values:

- Blocker: 반드시 수정해야 하며, 수정 전에는 Task를 완료할 수 없습니다.
- Major: 수정하는 것이 원칙이며, 미수정 시 명확한 이유가 필요합니다.
- Minor: 완료를 막지는 않지만 유지보수성, 명확성, 일관성을 위해 개선하는 것이 좋습니다.
- Approved: 차단 이슈가 없고 다음 Task로 넘어갈 수 있습니다.

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
