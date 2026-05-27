# Commit Rules

Use this file before creating commits.

Agents must follow the official Conventional Commits 1.0.0 specification:

https://www.conventionalcommits.org/en/v1.0.0/

## Structure

```md
<type>(<optional scope>): <description>

[optional body]

[optional footer(s)]
```

## Rules

- Each commit should map to one completed Subtask whenever possible.
- The commit message must start with a type.
- Use `feat` for a new feature.
- Use `fix` for a bug fix.
- Other allowed types include `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, and `build`.
- Scope may be added in parentheses, such as `feat(auth):`.
- Description must follow the colon and space.
- Description must be concise, start with lowercase, and not end with a period.
- Add a body when the change needs context, implementation notes, or verification details.
- Add footers using git trailer-style formatting.
- Include issue references when the Task/Subtask maps to an issue, such as `Refs: #123`, `Closes: #123`, or `Fixes: #123`.
- Mark breaking changes with `!` after the type/scope or with `BREAKING CHANGE:` in the footer.

## Examples

```md
feat(auth): add session refresh flow

세션 만료 시 refresh token으로 로그인 상태를 갱신하는 흐름을 추가합니다.
검증: auth API test와 세션 만료 수동 시나리오를 확인했습니다.

Refs: #42
```

```md
fix(api): handle missing project id
docs(agents): document folder-level inheritance
refactor(tasks): split handover template generation
test(auth): add expired token coverage
feat(api)!: change project response format

BREAKING CHANGE: project responses now wrap data in a result object
```

## Environment Safety Before Staging

Before staging or committing:

- Check that `.env`, `.env.local`, and real environment files are ignored.
- Do not stage real secrets or local credential files.
- Use `.env.example` with dummy values for shared structure.
