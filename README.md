# secret_agents

Tier 기반 멀티 에이전트 협업 규칙을 관리하는 문서 중심 저장소입니다.

## 에이전트 구성

- Core Agents
  - `Spec Agent`: 구현 전 요구사항/설계/검증 기준 정리
  - `Task Agent`: Spec을 Task/Subtask로 분해
  - `Implementation Agent`: 승인된 단위 구현
  - `Review Agent`: 정확성/범위/품질 검토
- Extended Agents
  - `Backend / Database / Frontend / Infrastructure / QA-Test Implementation Agent`
  - `Security Review Agent`
  - `Integration Coordinator Agent`

## 운영 방식 요약

- 루트 `AGENTS.md`: 항상 적용되는 안전 규칙 + Tier(0~4) 라우팅
- `docs/agent-rules/`: 역할/워크플로우/리뷰/보안/커밋/템플릿 상세 규칙
- `docs/contracts/`: 병렬 작업 전 선확정하는 공유 계약 문서
- `docs/coordination/`: sync point 체크리스트 및 리스크 관리
- `docs/reports/`, `docs/specs/`: Task 완료 보고 및 다음 Task 지시서

## 처음 기여하는 사람 3-step

1. `AGENTS.md`를 먼저 읽고, 현재 작업이 Tier 0~4 중 어디인지 정합니다.
2. Tier에 맞는 규칙 파일을 `docs/agent-rules/`에서 필요한 것만 읽고 작업 범위를 고정합니다.
3. 변경 후 검증 결과를 남기고, 필요하면 `docs/reports/`와 `docs/specs/`에 handover 문서를 추가합니다.
