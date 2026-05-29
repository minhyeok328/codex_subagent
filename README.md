# codex_subagent

`codex_subagent`는 Codex와 subagent가 사용자 Git 프로젝트를 안전하게 다루도록 돕는 Codex orchestration subagent system입니다.

제품 앱 자체가 아니라, 실제 앱을 `workspaces/` 아래에 두고 Codex가 무엇을 읽고, 어디까지 수정하고, 어떤 기준으로 검증할지 정하는 운영 셸입니다. 1차 배포 기준으로는 가장 기본적인 뼈대만 담고 있으며, 이후 프로젝트별 profile, contract, template, agent rule, skill을 추가하면서 확장할 수 있도록 설계되어 있습니다.

처음 사용하는 경우에는 [사용 설명서](./docs/onboarding/USER_GUIDE.ko.md)를 먼저 읽어 주세요.

## 이 시스템이 하는 일

- 하나의 작업에서 사용할 active workspace를 명확히 선언합니다.
- Codex와 subagent가 수정할 수 있는 경계와 금지 경로를 분리합니다.
- Default, Formal Planning, Full Delivery workflow를 구분해 작업 크기에 맞는 절차를 고릅니다.
- subagent를 쓸 때 task card, handover, review, 검증 기준을 남기도록 돕습니다.
- 구현 작업과 Git 작업을 분리해 잘못된 workspace에 commit하는 실수를 줄입니다.

## 기본 구조

```text
codex_subagent/
+-- AGENTS.md                    # 항상 적용되는 운영 규칙
+-- docs/                        # agent 규칙, 템플릿, 온보딩 문서
+-- scripts/                     # 문서 검증 등 보조 스크립트
+-- workspaces/
    +-- my-app/                  # 실제 사용자 Git 프로젝트
```

작업을 시작할 때는 보통 다음처럼 하나의 active workspace를 선언합니다.

```text
Active workspace: workspaces/<app-slug>
```

## 1차 배포 범위

이번 버전은 완성된 제품 플랫폼이 아니라, Codex 기반 작업을 안전하게 운영하기 위한 최소 시스템입니다.

- root `AGENTS.md`로 항상 적용되는 안전 규칙을 둡니다.
- `docs/agent-rules/`에 workflow, workspace, subagent, review, security, commit 규칙을 분리합니다.
- `docs/templates/`에 workspace profile, subagent task card, handover, integration review 템플릿을 둡니다.
- `docs/onboarding/USER_GUIDE.ko.md`에 처음 사용하는 흐름을 정리합니다.
- `scripts/check-docs.ps1`로 문서 참조와 필수 필드를 검증합니다.

## 확장 방향

`codex_subagent`는 기본 운영 셸이므로 실제 프로젝트에 맞게 점진적으로 확장할 수 있습니다.

- 앱별 `workspaces/<app-slug>/.agent/profile.md` 추가
- 앱별 contract와 검증 명령 추가
- 반복되는 작업을 위한 task card 템플릿 추가
- review, security review, Git Steward 절차 강화
- 프로젝트에 맞는 Codex skill 또는 automation 추가

## 필수 참조

- workspace 배치 규칙은 [workspaces 안내](./workspaces/README.md)를 참고합니다.
- subagent 실행 도구인 `spawn_agent`는 기본 경로가 아니며, 사용자가 subagent, delegation, 또는 parallel agent work를 명시적으로 요청했을 때만 사용합니다.
- Git 작업은 [commit-workflow skill](./docs/skills/commit-workflow/SKILL.md)과 Git Steward 규칙을 따릅니다.
- 전역 skill 재설치가 필요하면 `scripts/install-commit-workflow.ps1`을 사용합니다.

운영 규칙의 원문은 [AGENTS.md](./AGENTS.md)이고, 실사용 절차는 [사용 설명서](./docs/onboarding/USER_GUIDE.ko.md)에 정리되어 있습니다.
