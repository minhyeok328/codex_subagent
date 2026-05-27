# AGENTS.md 한국어 설명

이 문서는 팀원이 루트 [AGENTS.md](./AGENTS.md)의 의도를 빠르게 이해하기 위한 설명입니다.
실제 에이전트가 따라야 하는 운영 규칙의 원본은 `AGENTS.md`입니다.

## 핵심 방향

기존 규칙은 모든 작업에 무거운 Spec, Task, Review, Handover 절차를 적용했습니다.
개편 후에는 안전 규칙은 항상 유지하되, 작업 위험도에 따라 절차의 무게를 조절합니다.

원칙은 다음과 같습니다.

- 안전 규칙은 항상 지킨다.
- 절차의 무게는 위험도에 맞춘다.
- 긴 지침은 필요할 때만 읽는다.
- 정말 중요한 경계에서만 멈춘다.

## 항상 지키는 규칙

- 현재 프로젝트 workspace 안에서만 작업합니다.
- workspace 밖 파일을 읽거나 수정하지 않습니다.
- 관련 없는 파일이나 동작을 바꾸지 않습니다.
- 실제 secret, API token, `.env` 값을 소스코드나 Git에 넣지 않습니다.
- 필요한 검증을 실행하고, 실행하지 못했다면 이유를 보고합니다.
- 보안, 정확성, 유지보수성을 속도보다 우선합니다.

## 작업 Tier

| Tier | 용도 | 방식 |
| --- | --- | --- |
| Tier 0 | 질문, 분석, 설명, 읽기 전용 조사 | Spec/Task 없이 답변 |
| Tier 1 | 작은 문서/스타일/단일 파일 수정 | 간단한 범위 확인, 구현, 검증, 자체 리뷰 |
| Tier 2 | 일반 기능 또는 여러 파일 변경 | 간단 Spec, Task/Subtask, 구현, 리뷰, 검증 |
| Tier 3 | 인증, 권한, DB, 파일, 외부 API, 설정, 보안 민감 작업 | 정식 Spec, Review, Security Review, 명시적 검증 |
| Tier 4 | 병렬 멀티 에이전트 또는 대규모 교차 도메인 작업 | 계약 문서 우선, 역할별 Subtask, sync point, 통합 리뷰 |

판단이 애매하면 더 높은 Tier를 선택합니다.

## 분리된 세부 규칙

긴 규칙은 `docs/agent-rules/` 아래에 나누어 두었습니다.
에이전트는 필요한 상황에서만 해당 파일을 읽습니다.

- `workflow.md`: Tier별 작업 흐름, Spec/Task/Handover 기준
- `roles.md`: Spec, Task, Implementation, Review 및 확장 역할
- `review.md`: 리뷰 입력 조건과 출력 포맷
- `security-review.md`: 보안 체크리스트와 보안 리뷰 포맷
- `commits.md`: Conventional Commits 규칙
- `templates.md`: 폴더별 `AGENTS.md` 템플릿

## 보안 리뷰가 필요한 경우

다음 영역을 건드리면 `security-review.md`를 읽고 보안 체크를 수행합니다.

- 인증, 세션, 쿠키, 토큰, 비밀번호
- 권한, 역할, 소유권, 관리자 기능
- 사용자 입력, 파일 업로드/다운로드, 경로 처리
- DB schema, migration, query, 저장 데이터
- 외부 API, webhook, 네트워크 호출, dependency, 설정
- 로그, 분석, 환경변수, secret

Blocker 수준의 보안 문제가 있으면 즉시 멈추고 사용자에게 보고해야 합니다.

## 요약

이번 구조의 목적은 규칙을 약하게 만드는 것이 아닙니다.
작은 작업은 가볍게 처리하고, 위험한 작업은 더 엄격하게 처리해서 토큰 비용과 승인 피로도를 줄이면서도 안전성을 유지하는 것입니다.
