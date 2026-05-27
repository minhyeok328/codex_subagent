# Agent Sync Checklist

Use this checklist at every planned sync point when parallel work is active.

## 1) Contract Status

- [ ] `docs/contracts/API_CONTRACT.md` updated and approved (if API touched)
- [ ] `docs/contracts/DB_SCHEMA_CONTRACT.md` updated and approved (if schema/migrations touched)
- [ ] `docs/contracts/FRONTEND_BACKEND_CONTRACT.md` updated and approved (if UI↔API touched)
- [ ] `docs/contracts/INFRA_DEPLOYMENT_CONTRACT.md` updated and approved (if CI/deploy/env wiring touched)
- [ ] Relevant contracts include a filled **Parallel Start Minimum** section
- [ ] Any remaining unknowns are marked **Needs Confirmation** (no guessing codified as rules)

## 2) Ownership & Scope

- [ ] Backend changes are confined to backend-owned files
- [ ] DB changes are confined to migration/schema-owned files
- [ ] Frontend changes are confined to frontend-owned files
- [ ] Infra changes are confined to infra/CI-owned files
- [ ] QA/Test changes are confined to tests/verification scaffolding
- [ ] No agent changed unrelated behavior or files

## 3) Security Gates

- [ ] No secrets were introduced (no tokens/passwords/keys)
- [ ] `.env`, `.env.local`, and real `.env.*` are not tracked
- [ ] Security Review Agent ran checklist when triggered by scope

## 4) Integration Readiness

- [ ] API response shapes match frontend expectations
- [ ] DB migrations (if any) are compatible with deploy strategy
- [ ] Infra env var names match `.env.example` structure (dummy only)
- [ ] Error handling is consistent and does not leak internals

## 5) Verification

Project-specific commands:

- [ ] Lint command executed
- [ ] Unit tests command executed
- [ ] Integration tests for contract-critical paths executed
- [ ] Build command executed

If a command is not configured yet, record "Not applicable yet" with reason and owner.

## 6) Drift Handling

- [ ] If any drift exists, contract is updated first
- [ ] Subtasks are re-split if drift indicates coupling was underestimated
