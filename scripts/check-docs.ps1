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
    "docs/onboarding/USER_GUIDE.ko.md",
    "docs/agent-rules/workflow.md",
    "docs/agent-rules/roles.md",
    "docs/agent-rules/context-budget.md",
    "docs/agent-rules/subagent-execution.md",
    "docs/agent-rules/workspaces.md",
    "docs/agent-rules/commits.md",
    "docs/templates/SUBAGENT_TASK_CARD.template.md",
    "docs/templates/WORKSPACE_PROFILE.template.md",
    "docs/templates/TIER4_START_CHECKLIST.md",
    "docs/coordination/PARALLEL_WORKFLOW.md",
    "docs/coordination/AGENT_SYNC_CHECKLIST.md"
)

foreach ($file in $requiredFiles) {
    Test-RequiredFile $file
}
if (-not $failed) {
    Pass "required files"
}

$requiredTextChecks = @(
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/context-budget.md" },
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "AGENTS.md"; Text = "docs/agent-rules/workspaces.md" },
    @{ Path = "AGENTS.md"; Text = "commit-workflow" },
    @{ Path = "AGENTS.ko.md"; Text = "context-budget.md" },
    @{ Path = "AGENTS.ko.md"; Text = "subagent-execution.md" },
    @{ Path = "AGENTS.ko.md"; Text = "workspaces.md" },
    @{ Path = "AGENTS.ko.md"; Text = "commit-workflow" },
    @{ Path = "docs/onboarding/USER_GUIDE.ko.md"; Text = "subagent-execution.md" },
    @{ Path = "docs/onboarding/USER_GUIDE.ko.md"; Text = "Git target: shell | active app | none | Needs Confirmation" },
    @{ Path = "docs/agent-rules/context-budget.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "workspaces/<app-slug>" },
    @{ Path = "docs/agent-rules/workspaces.md"; Text = "workspaces/<app-slug>/.agent/profile.md" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Subagents do not choose their own workspace" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Status: Completed | Blocked | Needs Confirmation" },
    @{ Path = "docs/agent-rules/subagent-execution.md"; Text = "Integration After Return" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "commit-workflow" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Git target" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Pre-Stage Classification" },
    @{ Path = "docs/agent-rules/commits.md"; Text = "Git Steward Stop Conditions" },
    @{ Path = "docs/templates/WORKSPACE_PROFILE.template.md"; Text = "## Git Pointer" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Active workspace:" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "## Allowed Write Scope" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "## Forbidden Paths" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Status: Completed | Blocked | Needs Confirmation" },
    @{ Path = "docs/templates/SUBAGENT_TASK_CARD.template.md"; Text = "Git steward required" },
    @{ Path = "docs/templates/TIER4_START_CHECKLIST.md"; Text = "Workspace Activation Gate" },
    @{ Path = "docs/templates/TIER4_START_CHECKLIST.md"; Text = "Context Budget Gate" },
    @{ Path = "docs/templates/TIER4_START_CHECKLIST.md"; Text = "subagent-execution.md" },
    @{ Path = "docs/coordination/PARALLEL_WORKFLOW.md"; Text = "docs/agent-rules/subagent-execution.md" },
    @{ Path = "docs/coordination/AGENT_SYNC_CHECKLIST.md"; Text = "Status: Completed" }
)

foreach ($check in $requiredTextChecks) {
    Test-Contains $check.Path $check.Text
}
if (-not $failed) {
    Pass "required references and fields"
}

$markdownFiles = Get-TrackedMarkdownFiles
Test-TrailingWhitespace $markdownFiles
if (-not $failed) {
    Pass "no trailing whitespace in tracked markdown"
}

if ($failed) {
    Write-Host "Docs check failed." -ForegroundColor Red
    exit 1
}

Write-Host "Docs check passed."
