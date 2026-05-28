# secret_agents

`secret_agents`는 에이전트가 안전하게 협업하고, 필요한 경우 병렬 subagent 작업까지 진행할 수 있도록 규칙과 템플릿을 모아둔 문서 중심 저장소입니다.

운영 기준의 원문은 [AGENTS.md](./AGENTS.md)입니다. 한국어 설명은 [AGENTS.ko.md](./AGENTS.ko.md)를 참고하세요.

## 핵심 개념

- **Tier 기반 작업 흐름**: 작업 위험도와 규모에 따라 Tier 0부터 Tier 4까지 다른 절차를 적용합니다.
- **Contract-first 병렬 작업**: 병렬 구현은 shared contract를 먼저 확정한 뒤 시작합니다.
- **Domain-owned Subtasks**: Backend, Database, Frontend, Infrastructure, QA/Test 등 각 subagent는 자기 소유 범위만 수정합니다.
- **Review / Security Review Gate**: 일반 리뷰와 보안 리뷰를 분리해 correctness와 security를 함께 검증합니다.
- **Workspace Boundary**: 모든 작업은 현재 프로젝트 workspace 안에서만 진행합니다.

## 문서 구조

| 경로 | 목적 |
| --- | --- |
| [AGENTS.md](./AGENTS.md) | 항상 적용되는 루트 운영 규칙 |
| [AGENTS.ko.md](./AGENTS.ko.md) | 팀원용 한국어 설명 |
| [docs/agent-rules/](./docs/agent-rules/) | Tier workflow, role, review, security, commit, template 세부 규칙 |
| [docs/contracts/](./docs/contracts/) | API, DB, frontend-backend, infra shared contract |
| [docs/coordination/](./docs/coordination/) | 병렬 작업 sync checklist와 coordination 규칙 |
| [docs/templates/](./docs/templates/) | subagent prompt, Tier 4 시작 checklist, handover/review 템플릿 |
| [docs/specs/](./docs/specs/) | Task/Subtask 계획 문서 |
| [docs/reports/](./docs/reports/) | 완료 보고서와 handover 문서 |
| [docs/simulations/](./docs/simulations/) | 실제 구현 없이 workflow를 검증하는 시뮬레이션 |

## 처음 쓰는 법

1. [AGENTS.md](./AGENTS.md)를 읽고 현재 작업의 Tier를 정합니다.
2. 필요한 on-demand rule만 [docs/agent-rules/](./docs/agent-rules/)에서 읽습니다.
3. Tier 0/1은 가볍게 진행하고, Tier 2 이상은 Spec과 Task/Subtask를 남깁니다.
4. Tier 4 병렬 작업은 [TIER4_START_CHECKLIST.md](./docs/templates/TIER4_START_CHECKLIST.md)를 먼저 채웁니다.
5. 병렬 구현 전에는 관련 [docs/contracts/](./docs/contracts/) 문서의 `Parallel Start Minimum`을 확정합니다.
6. subagent를 실행할 때는 [SUBAGENT_PROMPTS.md](./docs/templates/SUBAGENT_PROMPTS.md)에서 역할별 프롬프트를 사용합니다.
7. sync point에서는 [AGENT_SYNC_CHECKLIST.md](./docs/coordination/AGENT_SYNC_CHECKLIST.md)와 [INTEGRATION_REVIEW_TEMPLATE.md](./docs/templates/INTEGRATION_REVIEW_TEMPLATE.md)를 사용합니다.
8. 완료 시 변경 파일, 검증 결과, 남은 위험을 보고합니다.

## 병렬 subagent 작업 흐름

Tier 4 병렬 작업은 다음 순서로 진행합니다.

1. **Integration Coordinator Agent**가 shared contract를 작성하거나 갱신합니다.
2. **Review Agent**와 필요한 경우 **Security Review Agent**가 contract를 검토합니다.
3. **Task Agent**가 domain-owned Subtask로 분해합니다.
4. 각 **Implementation Agent**가 자기 Subtask만 구현합니다.
5. **Integration Coordinator Agent**가 sync checklist를 실행합니다.
6. **Review Agent**가 통합 결과를 검토합니다.
7. 완료 보고서와 다음 handover 문서를 남깁니다.

실제 예시는 [TASK5_LOGIN_PARALLEL_SIMULATION.md](./docs/simulations/TASK5_LOGIN_PARALLEL_SIMULATION.md)를 보면 됩니다. 이 문서는 email/password login 기능을 가정해 Spec, contract, Subtask, handover, review 흐름을 시뮬레이션합니다.

## 주요 템플릿

- [SUBAGENT_PROMPTS.md](./docs/templates/SUBAGENT_PROMPTS.md): 역할별 subagent 실행 프롬프트
- [TIER4_START_CHECKLIST.md](./docs/templates/TIER4_START_CHECKLIST.md): 병렬 작업 시작 전 gate checklist
- [IMPLEMENTATION_AGENT_TEMPLATE.md](./docs/templates/IMPLEMENTATION_AGENT_TEMPLATE.md): domain implementation agent용 Subtask 템플릿
- [CROSS_AGENT_HANDOVER_TEMPLATE.md](./docs/templates/CROSS_AGENT_HANDOVER_TEMPLATE.md): agent 간 handover 템플릿
- [INTEGRATION_REVIEW_TEMPLATE.md](./docs/templates/INTEGRATION_REVIEW_TEMPLATE.md): sync point 통합 리뷰 템플릿

## 안전 규칙 요약

- workspace 밖 파일을 읽거나 수정하지 않습니다.
- 관련 없는 파일이나 동작을 바꾸지 않습니다.
- 실제 `.env`, `.env.local`, credential, token, secret 값을 Git에 넣지 않습니다.
- 환경 구조는 `.env.example`에 dummy 값으로만 공유합니다.
- 보안, DB, auth, file, external API, dependency, config 작업은 Security Review Agent가 필요할 수 있습니다.
- 병렬 작업 중 shared interface가 바뀌면 구현을 멈추고 contract부터 갱신합니다.

