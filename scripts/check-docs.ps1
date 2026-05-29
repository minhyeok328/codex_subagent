Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

$failed = $false

function Pass($message) {
    Write-Host "[ok] $message"
}

function Fail($message) {
    Write-Host "[fail] $message" -ForegroundColor Red
    $script:failed = $true
}

function Test-RequiredFile($path) {
    if (Test-Path -LiteralPath $path -PathType Leaf) {
        return
    }
    Fail "missing required file: $path"
}

function Test-Contains($path, $needle) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Fail "cannot check missing file: $path"
        return
    }

    $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $path
    if ($content.Contains($needle)) {
        return
    }
    Fail "$path missing required text: $needle"
}

function Get-TrackedMarkdownFiles {
    $status = git ls-files "*.md"
    if ($LASTEXITCODE -ne 0) {
        Fail "git ls-files failed"
        return @()
    }
    return @($status)
}

function Test-TrailingWhitespace($files) {
    foreach ($file in $files) {
        if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
            continue
        }

        $lineNumber = 0
        foreach ($line in Get-Content -Encoding UTF8 -LiteralPath $file) {
            $lineNumber += 1
            if ($line -match "[ \t]+$") {
                Fail "trailing whitespace: ${file}:${lineNumber}"
            }
        }
    }
}

$requiredFiles = @(
    "AGENTS.md",
    "AGENTS.ko.md",
    "README.md",
    "docs/onboarding/USER_GUIDE.ko.md",
    "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md",
    "docs/agent-rules/workflow.md",
    "docs/agent-rules/roles.md",
    "docs/agent-rules/context-budget.md",
    "docs/agent-rules/subagent-execution.md",
    "docs/agent-rules/workspaces.md",
    "docs/agent-rules/commits.md",
    "docs/skills/commit-workflow/SKILL.md",
    "docs/templates/SUBAGENT_TASK_CARD.template.md",
    "docs/templates/WORKSPACE_PROFILE.template.md",
    "docs/templates/FULL_DELIVERY_START_CHECKLIST.md",
    "docs/coordination/PARALLEL_WORKFLOW.md",
    "docs/coordination/AGENT_SYNC_CHECKLIST.md",
    "docs/contracts/API_CONTRACT.md",
    "docs/contracts/DB_SCHEMA_CONTRACT.md",
    "docs/contracts/FRONTEND_BACKEND_CONTRACT.md",
    "docs/contracts/INFRA_DEPLOYMENT_CONTRACT.md",
    "scripts/install-commit-workflow.ps1",
    "workspaces/README.md"
)

foreach ($file in $requiredFiles) {
    Test-RequiredFile $file
}
if (-not $failed) {
    Pass "required files"
}

$requiredTextChecks = @(
    @{ Path = "README.md"; Text = "docs/onboarding/USER_GUIDE.ko.md" },
    @{ Path = "README.md"; Text = "workspaces/README.md" },
    @{ Path = "README.md"; Text = "spawn_agent" },
    @{ Path = "README.md"; Text = "docs/skills/commit-workflow/SKILL.md" },
    @{ Path = "README.md"; Text = "install-commit-workflow.ps1" },
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/context-budget.md" },
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/workspaces.md" },
    @{ Path = "AGENTS.md"; Text = "commit-workflow" },
    @{ Path = "AGENTS.ko.md"; Text = "context-budget.md" },
    @{ Path = "AGENTS.ko.md"; Text = "subagent-execution.md" },
    @{ Path = "AGENTS.ko.md"; Text = "workspaces.md" },
    @{ Path = "AGENTS.ko.md"; Text = "commit-workflow" },
    @{ Path = "docs/onboarding/USER_GUIDE.ko.md"; Text = "subagent-execution.md" },
    @{ Path = "docs/onboarding/USER_GUIDE.ko.md"; Text = "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md" },
    @{ Path = "docs/onboarding/USER_GUIDE.ko.md"; Text = "Git target: shell | active app | none | Needs Confirmation" },
    @{ Path = "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md"; Text = "spawn_agent" },
    @{ Path = "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md"; Text = "Subagent Task Card" },
    @{ Path = "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md"; Text = "Git Steward Handoff" },
    @{ Path = "docs/agent-rules/context-budget.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "workspaces/<app-slug>" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "workspaces/<app-slug>/.agent/profile.md" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "shell-level reference or simulation contracts" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "app-specific frozen contracts" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Subagents do not choose their own workspace" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Subagents are opt-in execution resources" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Delegation Policy" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Cross-Agent Communication" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Cross-agent information must flow through the orchestrator" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "spawn_agent" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Status: Completed | Blocked | Needs Confirmation" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Integration After Return" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "commit-workflow" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "docs/skills/commit-workflow/SKILL.md" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Git target" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Pre-Stage Classification" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Git Steward Stop Conditions" },
    @{ Path = "docs/templates/WORKSPACE_PROFILE.template.md"; Text = "## Git Pointer" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Active workspace:" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "## Allowed Write Scope" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "## Forbidden Paths" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Status: Completed | Blocked | Needs Confirmation" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Git steward required" },
    @{ Path = "docs/templates/FULL_DELIVERY_START_CHECKLIST.md"; Text = "Workspace Activation Gate" },
    @{ Path = "docs/templates/FULL_DELIVERY_START_CHECKLIST.md"; Text = "Context Budget Gate" },
    @{ Path = "docs/templates/FULL_DELIVERY_START_CHECKLIST.md"; Text = "subagent-execution.md" },
    @{ Path = "docs/skills/commit-workflow/SKILL.md"; Text = "name: commit-workflow" },
    @{ Path = "docs/skills/commit-workflow/SKILL.md"; Text = "type(scope): summary" },
    @{ Path = "scripts/install-commit-workflow.ps1"; Text = "docs/skills/commit-workflow/SKILL.md" },
    @{ Path = "docs/coordination/PARALLEL_WORKFLOW.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "docs/coordination/PARALLEL_WORKFLOW.md"; Text = "shell-level reference or simulation contracts" },
    @{ Path = "docs/coordination/PARALLEL_WORKFLOW.md"; Text = "workspaces/<app-slug>/.agent/contracts" },
    @{ Path = "docs/coordination/AGENT_SYNC_CHECKLIST.md"; Text = "Status: Completed" },
    @{ Path = "docs/coordination/AGENT_SYNC_CHECKLIST.md"; Text = "Cross-Agent Sync" },
    @{ Path = "docs/coordination/AGENT_SYNC_CHECKLIST.md"; Text = "No private worker-to-worker assumptions remain" },
    @{ Path = "docs/templates/CROSS_AGENT_HANDOVER_TEMPLATE.md"; Text = "Routed via Orchestrator / Integration Coordinator" },
    @{ Path = "docs/onboarding/examples/LOGIN_SUBAGENT_FLOW.ko.md"; Text = "CROSS_AGENT_COMMUNICATION" },
    @{ Path = "docs/contracts/API_CONTRACT.md"; Text = "Scope note: this file is a shell-level reference or simulation contract." },
    @{ Path = "docs/contracts/DB_SCHEMA_CONTRACT.md"; Text = "Scope note: this file is a shell-level reference or simulation contract." },
    @{ Path = "docs/contracts/FRONTEND_BACKEND_CONTRACT.md"; Text = "Scope note: this file is a shell-level reference or simulation contract." },
    @{ Path = "docs/contracts/INFRA_DEPLOYMENT_CONTRACT.md"; Text = "Scope note: this file is a shell-level reference or simulation contract." },
    @{ Path = "workspaces/README.md"; Text = "Active workspace: workspaces/<app-slug>" },
    @{ Path = "workspaces/README.md"; Text = ".agent/profile.md" },
    @{ Path = "workspaces/README.md"; Text = "commit-workflow" }
)

foreach ($check in $requiredTextChecks) {
    Test-Contains $check.Path $check.Text
}
if (-not $failed) {
    Pass "required references and fields"
}

$markdownFiles = @(
    (Get-TrackedMarkdownFiles) +
    ($requiredFiles | Where-Object { $_ -like "*.md" })
) | Sort-Object -Unique
Test-TrailingWhitespace $markdownFiles
if (-not $failed) {
    Pass "no trailing whitespace in tracked markdown"
}

if ($failed) {
    Write-Host "Docs check failed." -ForegroundColor Red
    exit 1
}

Write-Host "Docs check passed."
