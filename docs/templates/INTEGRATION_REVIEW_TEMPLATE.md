# Integration Review Template

Use at sync points to confirm parallel work converged correctly.

## Metadata

- Date/time:
- Integration Coordinator Agent:
- Included Subtasks:
- Contract versions touched:
  - `docs/contracts/...`

## Contract Compliance

- API contract compliance:
  - Pass/Fail/Needs Confirmation
- DB schema contract compliance:
  - Pass/Fail/Needs Confirmation
- Frontend-backend contract compliance:
  - Pass/Fail/Needs Confirmation
- Infra/deployment contract compliance:
  - Pass/Fail/Needs Confirmation

## Cross-Domain Checks

- Backend ↔ DB:
  - Migration compatibility: Needs Confirmation
  - Rollout strategy documented: Needs Confirmation
- Frontend ↔ Backend:
  - Error handling consistent (401/403/422/etc.): Needs Confirmation
  - Data shape mapping stable: Needs Confirmation
- Infra:
  - Env var names match `.env.example` (dummy only): Needs Confirmation
  - CI checks defined: Needs Confirmation

## Security Review Trigger Check

- Does scope touch any of: auth, tokens, user input, file handling, dependencies, configs?
  - If yes: attach Security Review Agent output.

## Verification Summary

- Commands executed:
- Results:
- Gaps / Not applicable:

## Findings (Structured)

Use the same structured review format when relevant (field names in English).

- Severity:
- Area:
- Evidence:
- Risk:
- Required Fix:
- Retest:

## Decision

- Approved / Not Approved / Needs Confirmation
