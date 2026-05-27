# Security Review Rules

Use this file when a task touches security-sensitive areas.

## Triggers

Run security review when work touches:

- authentication, sessions, cookies, tokens, passwords, or redirects
- authorization, roles, ownership, admin behavior, or resource access
- user input from body, query, params, headers, forms, files, or external APIs
- SQL, ORM, NoSQL, LDAP, shell commands, dynamic imports, or dynamic code execution
- raw HTML, markdown rendering, iframes, scripts, URLs, or rich text
- CSRF, CORS, session expiration, refresh, or rotation
- personal data, payment data, internal IDs, logs, analytics, or client-side storage
- file upload, download, file paths, generated files, public files, symlinks, or path traversal risk
- external APIs, webhooks, network calls, retries, timeouts, dependencies, or configuration
- environment variables, secrets, `.env` files, or generated credentials

## Checklist

### Secrets / Credentials

- No hardcoded API keys, tokens, passwords, private keys, or credentials.
- No real secrets in `.env`, config files, logs, fixtures, test data, or documentation.
- `.env`, `.env.local`, and real environment files are ignored by Git.
- Server-only secrets are not exposed to client-side code.
- Example values are clearly dummy values.

### Authentication

- Login, session, or token validation is present where required.
- Expired, forged, missing, or malformed tokens are handled safely.
- Authentication errors do not reveal internal information.
- Passwords, tokens, or session values are not logged.

### Authorization / Access Control

- Authentication is not confused with resource authorization.
- Ownership, membership, and role checks are enforced server-side.
- Admin-only behavior is not available to normal users.
- Object ID changes cannot access another user's data.

### Input Validation

- User input is validated by type, length, format, enum, and range.
- Empty values, very long values, malformed JSON, and special characters are handled safely.
- Client-side validation is not trusted as the only validation.

### Injection

- Queries are not built through unsafe string concatenation.
- Shell commands do not include user-controlled input.
- Dynamic code execution is not used with untrusted input.
- Regex, templates, or scripts are not generated from untrusted input without safeguards.

### XSS / Client-Side Safety

- User input is not rendered as raw HTML.
- `dangerouslySetInnerHTML` or equivalents are avoided or sanitized.
- Markdown, rich text, iframe, script, and URL rendering are sanitized.
- User-controlled error messages or previews are escaped.

### Session / Cookie / CSRF / CORS

- Cookies use appropriate `HttpOnly`, `Secure`, and `SameSite` protections.
- State-changing requests have CSRF protection where needed.
- CORS is not overly broad.
- Session expiration, refresh, and rotation are not weakened.

### Sensitive Data Exposure

- Responses do not return unnecessary personal data, tokens, internal IDs, or private metadata.
- Logs, errors, analytics, and monitoring do not expose sensitive values.
- Sensitive values are not stored in `localStorage` or `sessionStorage` without clear reason.
- Stack traces, database details, internal paths, and service metadata are not exposed to users.

### File Handling

- File size, type, extension, and MIME validation exist where needed.
- File paths are not built from user-controlled input.
- Path traversal through `../`, absolute paths, symlinks, or encoded paths is blocked.
- Executable or user-uploaded files are not public without protection.
- Downloads enforce authorization.

### External API / Network

- User-controlled URLs do not create SSRF risk.
- Webhook signatures are verified where applicable.
- External calls use timeout, retry limit, and failure handling.
- External errors do not expose internal state or secrets.

### Dependencies / Configuration

- New dependencies are justified and scoped.
- Configuration changes do not weaken security defaults.
- Environment variable usage is documented with dummy examples only.

## Security Review Output Format

Field names and severity/category values must be written in English.
All explanatory content after the colon must be written in Korean.

```md
- Severity: Blocker | Major | Minor | Approved
- Category: Secrets | Auth | Authorization | Input Validation | Injection | XSS | Session | Data Exposure | File Handling | External API | Dependency | Configuration
- Evidence: 문제가 확인된 파일, 위치, 동작을 한글로 구체적으로 설명합니다.
- Risk: 실제 보안 또는 개인정보 위험을 설명합니다.
- Required Fix: 승인 전에 필요한 수정 사항을 적습니다.
- Retest: 수정 후 다시 확인할 방법을 적습니다.
```

If a Blocker security issue is found, stop and escalate immediately.
