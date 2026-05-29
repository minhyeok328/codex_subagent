# AGENTS.md 한국어 설명

이 문서는 루트 [AGENTS.md](./AGENTS.md)를 빠르게 이해하기 위한 팀원용 한국어 설명입니다.
에이전트가 반드시 따라야 하는 운영 기준 원문은 항상 [AGENTS.md](./AGENTS.md)입니다.

## 운영 방향

이 저장소는 모든 작업에 같은 무게의 절차를 강제하지 않습니다.
일반 작업은 가볍게 처리하고, 계획 산출물만 요청한 경우에는 Formal Planning을 사용하며, 사용자가 처음 기획부터 Spec 작성과 개발까지 맡긴 경우에만 Full Delivery를 사용합니다.

핵심 원칙은 다음과 같습니다.

- 현재 프로젝트 workspace 안에서만 작업합니다.
- 관련 없는 파일이나 동작을 바꾸지 않습니다.
- 기존 패턴을 우선하고, 불필요한 추상화를 만들지 않습니다.
- 실제 secret, API token, credential, `.env` 값을 소스나 Git에 넣지 않습니다.
- 필요한 검증을 실행하고, 실행하지 못한 경우 이유를 보고합니다.
- 보안, correctness, maintainability를 속도보다 우선합니다.

## Workflow 모드

기본값은 가벼운 Default Workflow입니다.
일반 작업에는 번호가 붙은 workflow 분류를 사용하지 않습니다.

### Default Workflow

질문, 분석, 읽기 전용 조사, 작은 수정, 집중된 bugfix, 일상적인 구현 slice에는 이 방식을 사용합니다.

- 바로 답변하거나 필요한 범위만 조사하고 구현합니다.
- 관련 없는 파일과 동작을 바꾸지 않습니다.
- 필요한 검증을 실행하고, 범위와 correctness를 self-review합니다.
- 사용자가 Formal Planning, Full Delivery, formal tracking을 명시적으로 요청했거나 기존 formal workflow의 일부가 아니라면 Spec, Task/Subtask, Review Agent, handover 문서를 만들지 않습니다.

### Formal Planning Workflow

사용자가 Spec, 설계, 구현 계획, Task/Subtask 분해, handoff 같은 계획 산출물만 요청하고 구현까지 맡기지는 않은 경우에 사용합니다.

- 계획 산출물을 정확하게 만드는 데 필요한 만큼만 질문합니다.
- 요청된 계획 문서를 작성하거나 갱신합니다.
- 사용자가 구현 전환을 명시적으로 승인하기 전에는 product 변경을 구현하지 않습니다.
- 검증은 문서 일관성, 링크, 계획 산출물에 필요한 확인으로 제한합니다.

### Full Delivery Workflow

사용자가 처음 기획부터 Spec 작성, Task/Subtask 분해, 개발, 리뷰, 검증까지 맡긴다고 명시한 경우에만 사용합니다.
또는 end-to-end delivery나 병렬 multi-agent delivery를 요청한 경우에 사용합니다.

Spec, 구현 계획, handoff, 제한된 subagent/delegation 요청만으로는 Full Delivery Workflow로 전환하지 않습니다.

Full Delivery Workflow에는 다음이 포함될 수 있습니다.

- 초기 기획과 요구사항 정리
- Spec 작성 또는 갱신
- Task/Subtask 분해
- 여러 domain이나 agent가 관여할 때 contract-first 조율
- Subtask 단위 구현
- 필요한 경우 Review Agent와 Security Review Agent 확인
- 명시적 검증과 handover

안전을 위해 Formal Planning이나 Full Delivery가 필요해 보이지만 사용자가 요청하지 않았다면, 전환하기 전에 이유를 설명하고 확인을 받습니다.

## On-Demand 규칙

상세 규칙은 [docs/agent-rules/](./docs/agent-rules/) 아래에 나뉘어 있습니다.
에이전트는 현재 작업에 필요한 파일만 읽습니다.

- [workflow.md](./docs/agent-rules/workflow.md): Formal Planning, Full Delivery workflow, Spec/Task/Handover 형식
- [roles.md](./docs/agent-rules/roles.md): Spec, Task, Implementation, Review 및 확장 역할
- [context-budget.md](./docs/agent-rules/context-budget.md): subagent에 필요한 최소 규칙과 작업 카드만 전달하는 규칙
- [subagent-execution.md](./docs/agent-rules/subagent-execution.md): subagent 호출, 중단, 출력, 통합 절차
- [workspaces.md](./docs/agent-rules/workspaces.md): active workspace, profile, allowed scope, forbidden path 규칙
- [review.md](./docs/agent-rules/review.md): 리뷰 입력 조건과 출력 형식
- [security-review.md](./docs/agent-rules/security-review.md): 보안 트리거, 체크리스트, 보안 리뷰 형식
- [commits.md](./docs/agent-rules/commits.md): Conventional Commits와 staging 안전 규칙
- [templates.md](./docs/agent-rules/templates.md): 폴더별 `AGENTS.md` 템플릿

## Workspace / Context Budget

`secret_agents`를 상위 운영 셸로 두고 앱을 `workspaces/<app-slug>` 아래에서 작업할 때는 active workspace를 먼저 선언합니다.

기본 흐름:

```text
Active workspace: workspaces/<app-slug>
Workspace profile: workspaces/<app-slug>/.agent/profile.md
```

구현 subagent는 active workspace와 assigned write scope 안에서만 작업합니다.
다른 `workspaces/*` 앱, `.git/**`, 실제 `.env` 파일, credentials, generated secrets는 건드리지 않습니다.

subagent에는 전체 문서를 모두 붙여 넣지 않고, 가능한 한 [SUBAGENT_TASK_CARD.template.md](./docs/templates/SUBAGENT_TASK_CARD.template.md)를 사용합니다.
subagent를 호출하거나 결과를 통합할 때는 [subagent-execution.md](./docs/agent-rules/subagent-execution.md)를 따릅니다.
앱별 실행 컨텍스트는 [WORKSPACE_PROFILE.template.md](./docs/templates/WORKSPACE_PROFILE.template.md)를 기준으로 작성합니다.

구현 subagent는 기본적으로 Git 명령을 실행하지 않습니다.
commit, branch, push, PR 작업은 별도 Git 역할에서 `commits.md`를 읽고 처리합니다.
commit을 만들거나 staging, commit 분리, commit message 작성을 할 때는 `commit-workflow` skill을 사용합니다.

## 병렬 작업

Full Delivery 병렬 작업은 수동으로 동시에 코딩하는 흐름이 아니라 contract-first 기반의 독립 구현입니다.

기본 흐름은 다음과 같습니다.

1. Integration Coordinator Agent가 shared contract를 작성하거나 갱신합니다.
2. Review Agent와 필요한 경우 Security Review Agent가 contract를 검토합니다.
3. Task Agent가 작업을 domain-owned Subtask로 나눕니다.
4. Backend, Database, Frontend, Infrastructure, QA/Test Implementation Agent가 각자 소유한 범위만 구현합니다.
5. Integration Coordinator Agent가 sync checklist와 integration review를 수행합니다.
6. 완료 보고서와 다음 handover 문서를 남깁니다.

병렬 작업을 시작하기 전에는 [FULL_DELIVERY_START_CHECKLIST.md](./docs/templates/FULL_DELIVERY_START_CHECKLIST.md)를 사용합니다.
subagent 실행에는 [SUBAGENT_TASK_CARD.template.md](./docs/templates/SUBAGENT_TASK_CARD.template.md) 또는 [SUBAGENT_PROMPTS.md](./docs/templates/SUBAGENT_PROMPTS.md)를 사용합니다.

## 보안 리뷰가 필요한 경우

다음 영역을 건드리면 [security-review.md](./docs/agent-rules/security-review.md)를 읽고 Security Review Agent 체크를 수행합니다.

- 인증, 세션, 쿠키, 토큰, 비밀번호, redirect
- 권한, 역할, 소유권, 관리자 동작, resource access
- body, query, params, headers, forms, files, external APIs에서 오는 사용자 입력
- DB schema, migration, query, data storage, sensitive data
- file upload/download, path, generated file, public file access
- external API, webhook, network call, dependency, configuration
- logging, analytics, monitoring, environment variable, secrets

Blocker 보안 이슈가 발견되면 즉시 멈추고 사용자에게 보고해야 합니다.

## 완료 기준

작업을 완료로 보고하기 전에 다음을 확인합니다.

- 요청한 작업과 선택한 workflow 모드가 맞는지 확인합니다.
- 관련 없는 동작이나 파일을 바꾸지 않았는지 확인합니다.
- 필요한 검증을 실행하거나, 실행하지 못한 이유를 설명합니다.
- 변경 파일, 검증 결과, 가정, 남은 위험을 보고합니다.
