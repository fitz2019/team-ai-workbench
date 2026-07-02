[CmdletBinding(PositionalBinding = $false)]
param(
    [switch]$RemoveControlFiles
)

$ErrorActionPreference = "Stop"

function Get-RepoRoot {
    $cwd = (Get-Location).Path
    try {
        $root = (& git -C $cwd rev-parse --show-toplevel 2>$null)
        if (-not [string]::IsNullOrWhiteSpace($root)) {
            return $root.Trim()
        }
    } catch {
    }
    return $cwd
}

function Read-JsonFile {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        return $null
    }
    return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
}

$root = Get-RepoRoot
$harnessRoot = Join-Path $root ".ai-harness"
$state = Read-JsonFile -Path (Join-Path $harnessRoot "LOOP_STATE.json")
$runId = if ($state -and -not [string]::IsNullOrWhiteSpace([string]$state.run_id)) {
    [string]$state.run_id
} else {
    Get-Date -Format "yyyyMMdd-HHmmss"
}

$archiveRoot = Join-Path (Join-Path (Join-Path $harnessRoot "runs") $runId) "archive"
New-Item -ItemType Directory -Path $archiveRoot -Force | Out-Null

$snapshotFiles = @(
    "BUILD_PLAN.md",
    "PROGRESS.md",
    "STEER.md",
    "EVALUATOR_RUBRIC.md",
    "NEXT_FINDINGS.md",
    "test-results.json",
    "LOOP_STATE.json"
)

foreach ($file in $snapshotFiles) {
    $source = Join-Path $harnessRoot $file
    if (Test-Path -LiteralPath $source) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $archiveRoot $file) -Force
    }
}

if ($RemoveControlFiles) {
    foreach ($control in @("ACTIVE", "CONTINUE_ON_STOP", "AGENT_STOP")) {
        $path = Join-Path $harnessRoot $control
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Force
        }
    }
}

Write-Host "Loop snapshot archived."
Write-Host "Archive: $archiveRoot"
if ($RemoveControlFiles) {
    Write-Host "Control files removed."
}
