# TASK5 Simulation: Email Login With Parallel Subagents

This document simulates a Tier 4 parallel workflow without changing application code.
It demonstrates how to use contracts, Subtasks, subagent prompts, sync checks, reviews, and handovers for a cross-domain feature.

Simulation status:

- Type: Documentation-only simulation
- Feature: Email/password login MVP
- Tier: Tier 4
- Date: 2026-05-28
- Coordinator: Integration Coordinator Agent
- Security Review Agent required: Yes

## 1) User Request

Add a basic email/password login flow.

Expected behavior:

- Users can submit email and password from a login page.
- Backend validates credentials.
- Successful login returns a short-lived access token and user summary.
- Failed login returns a safe user-visible error.
- Frontend stores auth state according to the approved contract.
- Tests cover API behavior and frontend error states.

## 2) Tier 4 Start Checklist Snapshot

Source template: `docs/templates/TIER4_START_CHECKLIST.md`

### Tier 4 Fit

- [x] The work touches backend, frontend, database, tests, and security behavior.
- [x] A lower Tier would create contract and security-review risk.
- [x] Work can be split into independently owned Subtasks.
- [x] User request and acceptance target are understood for simulation purposes.

Decision:

- Tier selected: Tier 4
- Reason: auth feature touches cross-domain contracts, user input, token handling, and verification.
- Not Tier 0/1/2/3 because: parallel implementation and security review are central to the workflow.

### Domain Impact Map

- [x] Backend application logic / APIs
- [x] Database schema / migrations / queries
- [x] Frontend UI / client state / API integration
- [ ] Infrastructure / CI / deployment / runtime config
- [x] QA / tests / fixtures / verification automation
- [x] Security-sensitive behavior

Primary domains:

- Backend
- Database
- Frontend
- QA/Test
- Security Review

Out of scope:

- OAuth/social login
- Password reset
- Refresh token rotation
- Production deployment configuration
- Real secrets or real environment files

## 3) Simulated Contract Freeze

These are simulated task-specific contract sections. They demonstrate what would be added to `docs/contracts/*` before real implementation starts.

### API Contract: Parallel Start Minimum For TASK5 Simulation

- Base path: `/api/v1`
- Endpoint: `POST /api/v1/auth/login`
- Auth: Public
- Content-Type: `application/json`
- Request body:
  - `email`: string, required, normalized lowercase before lookup
  - `password`: string, required, minimum 8 characters
- Success response:

```json
{
  "data": {
    "accessToken": "dummy.jwt.access.token",
    "expiresAt": "2026-05-28T09:30:00Z",
    "user": {
      "id": "usr_123",
      "email": "user@example.com",
      "displayName": "Example User"
    }
  }
}
```

- Error response standard:

```json
{
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Email or password is incorrect."
  }
}
```

- Error codes:
  - `400 BAD_REQUEST`: malformed JSON
  - `401 INVALID_CREDENTIALS`: email/password mismatch
  - `422 VALIDATION_FAILED`: missing or invalid fields
  - `429 RATE_LIMITED`: too many attempts
  - `500 INTERNAL_ERROR`: generic server failure
- Rate limit:
  - Needs Confirmation: exact threshold and storage mechanism

### DB Schema Contract: Parallel Start Minimum For TASK5 Simulation

- Entity: `users`
- Fields:
  - `id`: UUID string boundary-safe identifier
  - `email`: unique, lowercase, indexed
  - `password_hash`: string, never plaintext
  - `display_name`: string, nullable
  - `created_at`: timestamp
  - `updated_at`: timestamp
- Constraints:
  - unique index on `email`
  - `password_hash` required
- Sensitive fields:
  - `password_hash` is sensitive and must never be returned by API or logged.
- Migration strategy:
  - Forward-only migration for initial auth table.
  - Needs Confirmation: existing user table may already exist in a real app.

### Frontend-Backend Contract: Parallel Start Minimum For TASK5 Simulation

- Page: `/login`
- Calls endpoint:
  - `POST /api/v1/auth/login`
- Required frontend request fields:
  - `email`
  - `password`
- Required frontend response fields:
  - `accessToken`
  - `expiresAt`
  - `user.id`
  - `user.email`
  - `user.displayName`
- UX behavior:
  - loading state while request is in flight
  - inline validation before submit for missing fields
  - `401 INVALID_CREDENTIALS`: show generic credential error, keep user on login page
  - `422 VALIDATION_FAILED`: show field-level validation when details are provided
  - `429 RATE_LIMITED`: show retry-later message
- Accessibility:
  - email and password inputs must have labels
  - errors must be announced to screen readers
  - submit button must preserve keyboard access

### Infra Contract: Parallel Start Minimum For TASK5 Simulation

- No new deployment shape required.
- No real environment values allowed.
- Needs Confirmation:
  - JWT signing key env var name, for example `AUTH_JWT_SECRET`, must be represented only in `.env.example` with a dummy value if implementation proceeds.

## 4) Contract Review Output

Reviewer: Review Agent

- Severity: Approved
- Area: Spec Alignment
- Evidence: Simulated API, DB, frontend-backend, and infra minimums define the shared login behavior before implementation.
- Risk: Remaining `Needs Confirmation` items must be resolved before real code is written.
- Required Fix: None for simulation. For implementation, resolve rate limit storage, existing user table status, and JWT env var naming.
- Retest: Re-run Tier 4 start checklist after resolving `Needs Confirmation`.

Security reviewer: Security Review Agent

- Security triggers:
  - authentication
  - passwords
  - tokens
  - user input
  - database sensitive fields
  - environment variables
- Decision: Approved for simulation, Not Approved for implementation until `Needs Confirmation` items are resolved.
- Required fixes before implementation:
  - define password hashing mechanism
  - define token signing and expiry policy
  - define rate limit threshold and storage
  - define secret env var name in `.env.example` only

## 5) Subtask Decomposition

Source template: `docs/templates/SUBAGENT_PROMPTS.md`

### Subtask 1: Auth Schema

- Primary Agent: Database Implementation Agent
- Purpose: Provide user credential storage for login.
- Owned files/folders:
  - `backend/**/models*`
  - `backend/**/migrations/**`
  - DB tests related to user schema
- Explicitly out of scope:
  - API handlers
  - frontend UI
  - token signing implementation
- Dependencies:
  - DB contract approval
  - Security Review Agent approval of sensitive field handling
- Acceptance Criteria:
  - `users.email` is unique and indexed.
  - `password_hash` is required and never plaintext.
  - migration notes document rollback strategy.
- Verification:
  - Needs Confirmation: actual backend framework and migration command

### Subtask 2: Login API

- Primary Agent: Backend Implementation Agent
- Purpose: Authenticate submitted credentials and return contract-compliant response.
- Owned files/folders:
  - `backend/**/routes*`
  - `backend/**/views*`
  - `backend/**/serializers*`
  - backend auth service files
  - backend API tests
- Explicitly out of scope:
  - DB schema changes
  - frontend UI changes
  - CI/deployment changes
- Dependencies:
  - Subtask 1 contract alignment
  - API contract approval
  - Security Review Agent approval of auth/token policy
- Acceptance Criteria:
  - `POST /api/v1/auth/login` matches API contract.
  - invalid credentials return `401 INVALID_CREDENTIALS`.
  - validation failures return `422 VALIDATION_FAILED`.
  - password hash comparison uses approved secure mechanism.
  - no password, token secret, stack trace, or internal path is logged.
- Verification:
  - Needs Confirmation: backend test command

### Subtask 3: Login Page

- Primary Agent: Frontend Implementation Agent
- Purpose: Provide login form and integrate with login API.
- Owned files/folders:
  - `frontend/**/login*`
  - `frontend/**/auth*`
  - frontend tests for login UI
- Explicitly out of scope:
  - backend auth behavior
  - DB schema
  - token signing
- Dependencies:
  - Frontend-backend contract approval
  - API contract approval
- Acceptance Criteria:
  - login form captures email and password.
  - submit calls `POST /api/v1/auth/login`.
  - loading, error, and success states match contract.
  - `401`, `422`, and `429` are handled distinctly.
  - form labels and error announcements are accessible.
- Verification:
  - Needs Confirmation: frontend test/build command

### Subtask 4: Contract-Critical Tests

- Primary Agent: QA/Test Implementation Agent
- Purpose: Add coverage for cross-domain login contract behavior.
- Owned files/folders:
  - `tests/**`
  - `backend/**/tests/**`
  - `frontend/**/__tests__/**`
  - verification docs
- Explicitly out of scope:
  - product behavior changes
  - contract changes unless routed through Integration Coordinator
- Dependencies:
  - Subtasks 1-3 implementation outputs
- Acceptance Criteria:
  - login success response shape is asserted.
  - `401`, `422`, and `429` behaviors are covered where possible.
  - frontend error-state rendering is covered.
  - no assertions depend on real secrets.
- Verification:
  - Needs Confirmation: project test command set

## 6) Simulated Subagent Launch Plan

| Agent | Prompt Template | Subtask | May Start? | Notes |
| --- | --- | --- | --- | --- |
| Integration Coordinator Agent | `SUBAGENT_PROMPTS.md` | Contract freeze and sync | Yes | Simulation contracts drafted above |
| Task Agent | `SUBAGENT_PROMPTS.md` | Subtask split | Yes | Subtasks listed in section 5 |
| Database Implementation Agent | `SUBAGENT_PROMPTS.md` | Subtask 1 | No | Blocked until real backend stack is known |
| Backend Implementation Agent | `SUBAGENT_PROMPTS.md` | Subtask 2 | No | Blocked on auth/token policy confirmation |
| Frontend Implementation Agent | `SUBAGENT_PROMPTS.md` | Subtask 3 | No | Blocked until real frontend structure is known |
| QA/Test Implementation Agent | `SUBAGENT_PROMPTS.md` | Subtask 4 | No | Blocked until real test commands are known |
| Review Agent | `SUBAGENT_PROMPTS.md` | Contract and subtask review | Yes | Simulation review completed |
| Security Review Agent | `SUBAGENT_PROMPTS.md` | Auth security review | Yes | Simulation security review completed |

## 7) Midpoint Sync Simulation

Source checklist: `docs/coordination/AGENT_SYNC_CHECKLIST.md`

### Contract Status

- [x] API contract simulated and reviewed.
- [x] DB schema contract simulated and reviewed.
- [x] Frontend-backend contract simulated and reviewed.
- [x] Infra contract simulated and marked mostly not applicable.
- [x] Unknowns are marked `Needs Confirmation`.

### Ownership & Scope

- [x] Backend work is confined to login API and auth service files.
- [x] DB work is confined to user schema and migration files.
- [x] Frontend work is confined to login UI and auth state files.
- [x] QA work is confined to tests and verification docs.
- [x] No agent is assigned overlapping primary ownership.

### Security Gates

- [x] Security Review Agent is required.
- [x] Real secrets are forbidden.
- [x] `.env.example` may receive dummy env var names only if implementation proceeds.

### Integration Readiness

- [x] API response shape matches frontend expectations.
- [x] DB sensitive field constraints support backend requirements.
- [x] Error handling is generic and does not leak internals.
- [ ] Rate limit behavior remains `Needs Confirmation`.
- [ ] Token signing and expiry policy remains `Needs Confirmation`.

Decision:

- Integration status: Not ready for implementation.
- Reason: simulation succeeded, but real implementation needs stack, command, and security-policy confirmations.

## 8) Cross-Agent Handover Simulation

Source template: `docs/templates/CROSS_AGENT_HANDOVER_TEMPLATE.md`

### Context

- Current Task / Subtask: TASK5 Simulation / Subtask 2 Login API
- Date/time: 2026-05-28
- From Agent: Integration Coordinator Agent
- To Agent: Backend Implementation Agent
- Contract references:
  - simulated API contract in this document
  - simulated DB contract in this document
  - simulated frontend-backend contract in this document

### What Changed

- Changed files:
  - Documentation-only simulation file
- Contract changes:
  - No real contract files were changed.
  - Simulated contract sections were drafted for review practice.

### What You Need To Know

- Intended behavior:
  - backend exposes `POST /api/v1/auth/login`
  - success returns token, expiry, and safe user summary
  - failures return standard error envelope
- Edge cases:
  - invalid credentials
  - malformed request
  - validation failure
  - rate limit
- `Needs Confirmation` items:
  - backend framework
  - password hashing mechanism
  - token signing mechanism
  - rate limit threshold and storage
  - test command
- Non-obvious constraints:
  - never return or log `password_hash`
  - never commit real secrets
  - update contracts before changing response shape

### Verification Status

- Commands run:
  - documentation readback only
- Not run:
  - code tests, because this is a documentation-only simulation

### Next Steps

- [ ] Re-read relevant contracts.
- [ ] Confirm scope ownership.
- [ ] Resolve `Needs Confirmation` items before implementation.
- [ ] Implement only within owned backend files.
- [ ] Report verification results to Review Agent.

## 9) Integration Review Simulation

Source template: `docs/templates/INTEGRATION_REVIEW_TEMPLATE.md`

### Metadata

- Date/time: 2026-05-28
- Integration Coordinator Agent: Main Codex simulation
- Included Subtasks:
  - Subtask 1 Auth Schema
  - Subtask 2 Login API
  - Subtask 3 Login Page
  - Subtask 4 Contract-Critical Tests
- Contract versions touched:
  - No real contract files changed
  - simulated contract freeze sections included above

### Contract Compliance

- API contract compliance:
  - Pass for simulation
- DB schema contract compliance:
  - Pass for simulation
- Frontend-backend contract compliance:
  - Pass for simulation
- Infra/deployment contract compliance:
  - Needs Confirmation for JWT env var name if implementation proceeds

### Findings

- Severity: Major
- Area: Security
- Evidence: Token signing, password hashing, and rate limiting are still marked `Needs Confirmation`.
- Risk: Implementing without these decisions could create insecure auth behavior or incompatible contracts.
- Required Fix: Resolve security-policy details before real implementation starts.
- Retest: Re-run Tier 4 start checklist and Security Review Agent output.

- Severity: Minor
- Area: Test Coverage
- Evidence: Verification commands are unknown because no real app stack exists in this repository.
- Risk: Subagents cannot independently verify work until commands are defined.
- Required Fix: Add project-specific lint, build, and test commands when the real app structure exists.
- Retest: Update verification plan and run listed commands.

### Decision

- Approved for documentation workflow simulation.
- Not approved for real implementation until blockers and `Needs Confirmation` items are resolved.

## 10) Completion Report Simulation

Responsible agent: Main Codex acting as Integration Coordinator, Task Agent, Review Agent, and Security Review Agent for simulation only.

Spec alignment checklist:

- [x] Tier 4 start gate was simulated.
- [x] Contract-first workflow was simulated.
- [x] Domain-owned Subtasks were created.
- [x] Security review trigger was identified.
- [x] Sync and handover artifacts were simulated.
- [x] Implementation was intentionally not started.

Changed files in this simulation:

- `docs/simulations/TASK5_LOGIN_PARALLEL_SIMULATION.md`

Verification results:

- Documentation-only readback should be performed after file creation.
- No application tests are applicable.

Residual risks:

- This is a workflow simulation, not a product implementation plan.
- Real implementation still needs actual repository stack, file ownership, verification commands, and security policy decisions.

