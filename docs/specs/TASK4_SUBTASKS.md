# TASK4 Subtasks: Optional Coordination Docs Cleanup

## Context and Dependencies

- Previous report: `docs/reports/TASK3_COMPLETION.md`
- Base branch: current working branch
- Dependency: TASK3 introduced concise root rules and on-demand rule files under `docs/agent-rules/`.

TASK4 is optional. It should run only if the user wants the existing coordination, contract, and template documents to be further aligned with the new Tier model.

## Subtask 1: Audit Existing Coordination Docs

- Purpose: 기존 `docs/coordination/`, `docs/contracts/`, `docs/templates/` 문서가 새 Tier 구조와 중복되거나 충돌하는 부분이 있는지 확인합니다.
- Scope: 문서 읽기와 감사 결과 정리만 포함합니다. 문서 수정은 제외합니다.
- Dependencies: `docs/reports/TASK3_COMPLETION.md`
- Acceptance Criteria: 중복, 충돌, 유지, 삭제 또는 병합 후보가 파일별로 정리됩니다.
- Verification: `git diff --stat`로 수정이 없음을 확인합니다.

## Subtask 2: Consolidate Duplicate Guidance

- Purpose: 감사 결과에 따라 중복된 멀티 에이전트, 계약, 리뷰 지침을 새 `docs/agent-rules/` 구조와 충돌하지 않게 정리합니다.
- Scope: 문서 내용의 중복 제거, 링크 업데이트, `Needs Confirmation` 유지 여부 확인을 포함합니다.
- Dependencies: Subtask 1
- Acceptance Criteria: 기존 문서가 루트 `AGENTS.md`와 `docs/agent-rules/`를 보완하며, 같은 규칙을 장황하게 반복하지 않습니다.
- Verification: `Select-String`으로 주요 문서 링크와 `Needs Confirmation` 표기를 확인합니다.

## Subtask 3: Final Review and Verification

- Purpose: 문서 개편 후 전체 규칙 구조가 이해 가능하고 안전 규칙을 약화하지 않았는지 확인합니다.
- Scope: 문서 리뷰, secret pattern 검색, Git 상태 확인을 포함합니다.
- Dependencies: Subtask 2
- Acceptance Criteria: Review 결과가 Approved이며, 보안 민감 정보가 추가되지 않았고, 변경 범위가 문서에 한정됩니다.
- Verification: `git status --short`, `.gitignore` 확인, secret pattern 검색을 실행합니다.

## Deadlock Escape Conditions

- 같은 문서 정리 방향에서 세 번 연속 충돌이 발생하면 중단하고 사용자에게 확인을 요청합니다.
- 기존 문서가 실제 미구현 프로젝트 구조를 강하게 가정하고 있으면 `Needs Confirmation`으로 남기고 사용자 확인을 요청합니다.
