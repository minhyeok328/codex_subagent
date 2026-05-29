param(
    [string]$CodexHome = (Join-Path $env:USERPROFILE ".codex")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$source = Join-Path $repoRoot "docs/skills/commit-workflow/SKILL.md"
$targetDir = Join-Path $CodexHome "skills/commit-workflow"
$target = Join-Path $targetDir "SKILL.md"

if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "Missing source skill: $source"
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
Copy-Item -LiteralPath $source -Destination $target -Force

Write-Host "Installed commit-workflow skill:"
Write-Host $target
