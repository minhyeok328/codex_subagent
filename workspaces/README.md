# workspaces

이 폴더는 실제 사용자 Git 프로젝트를 넣는 위치입니다.
`secret_agents`는 운영 셸이고, `workspaces/<app-slug>` 아래 앱이 실제 구현 대상입니다.

## 기본 구조

```text
workspaces/
+-- my-app/
    +-- .git/                    # 앱 자체 Git repo일 수 있음
    +-- .agent/
        +-- profile.md           # 앱별 실행 프로필
        +-- contracts/           # 앱별 동결 contract
    +-- src/
    +-- tests/
```

작업을 시작할 때는 하나의 active workspace를 선언합니다.

```text
Active workspace: workspaces/<app-slug>
```

## 앱 추가 흐름

1. `workspaces/<app-slug>/` 아래에 앱 repo를 clone하거나 복사합니다.
2. `docs/templates/WORKSPACE_PROFILE.template.md`를 참고해 `.agent/profile.md`를 만듭니다.
3. 병렬 작업이나 공유 인터페이스 변경이 있으면 `.agent/contracts/` 아래에 task-specific contract를 둡니다.
4. Task나 Subagent Task Card에 active workspace, allowed write scope, forbidden paths, verification command를 적습니다.

## 경계 규칙

- 한 Task는 하나의 active workspace만 대상으로 합니다.
- 다른 `workspaces/*` 앱은 명시적 승인 없이 읽거나 수정하지 않습니다.
- 실제 `.env`, `.env.local`, credential, local database, generated secret은 읽거나 쓰지 않습니다.
- 구현 subagent는 `.git/**`을 수정하지 않고 Git 명령을 실행하지 않습니다.
- Git 작업은 Git Steward가 `docs/agent-rules/commits.md`와 `commit-workflow`를 사용해 처리합니다.

## Git 정책

이 폴더의 Git 추적 방식은 팀/프로젝트 정책에 따라 달라질 수 있습니다.

일반적인 선택지는 다음과 같습니다.

- 앱 repo는 `secret_agents` Git에 포함하지 않고 앱 자체 Git으로 관리
- 앱 repo를 submodule/subtree로 연결
- 예시용 더미 workspace만 track

정책이 확정되기 전에는 실제 앱 소스나 secrets를 `secret_agents` Git에 넣지 마세요.

## 참고 문서

- `docs/agent-rules/workspaces.md`
- `docs/templates/WORKSPACE_PROFILE.template.md`
- `docs/templates/SUBAGENT_TASK_CARD.template.md`
- `docs/onboarding/USER_GUIDE.ko.md`
