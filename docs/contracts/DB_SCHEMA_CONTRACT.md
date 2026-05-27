# DB Schema Contract

This document defines the **database schema and migration rules** as a shared contract.

## Status

- Owner: Integration Coordinator Agent + Database Implementation Agent
- Review: Review Agent (+ Security Review Agent when relevant)
- Change policy: Schema contract changes must be documented **before** migrations are authored.

## Scope

- In scope:
  - Entities, columns, types, constraints, indexes
  - Migration rules and naming conventions
  - Backward compatibility + rollout strategy
  - Data retention and PII classification guidance
- Out of scope:
  - Query implementation details in application code
  - Any real credential material (forbidden)

## Database Baseline

- Engine: PostgreSQL
- Version: 15+
- Migration tool:
  - If backend stack is Django, use Django migrations.
  - If stack differs, define tool explicitly before first migration.

## Cross-Agent Rules

- Backend Implementation Agent must not assume schema shape not documented here.
- Frontend Implementation Agent must not assume DB-derived fields unless exposed in API contract.
- Infra Implementation Agent must not change DB provisioning behavior without updating `INFRA_DEPLOYMENT_CONTRACT.md`.

## Entity Catalog (Template)

For each table/entity, fill in:

- Name:
- Purpose:
- Fields:
  - `id`: type, generation strategy
  - ...
- Constraints:
  - uniqueness
  - foreign keys
  - check constraints
- Indexes:
- Sensitive fields:
  - Needs Confirmation (PII, tokens, secrets must not be stored in plaintext)
- Notes:

## Migration Policy

- Migration author: Database Implementation Agent
- Review required: Review Agent
- Security review required when:
  - auth tables, tokens, permissions, PII fields are involved
- Rollback / down migration policy:
  - Forward-only migration by default.
  - Down migration is optional, but rollback strategy must be documented in migration notes.

## Parallel Start Minimum (Frozen For Task 3)

- Every table/entity must have:
  - `id` (UUID string boundary-safe identifier)
  - `created_at` (ISO8601-compatible timestamp source)
  - `updated_at` (ISO8601-compatible timestamp source)
- Constraints:
  - foreign keys must be explicit
  - uniqueness rules must be documented in this contract before migration
- Naming:
  - tables: `snake_case` plural
  - columns: `snake_case`
- Sensitive fields:
  - tokens/passwords/secrets must never be stored in plaintext
