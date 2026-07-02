[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Mandatory = $true)]
    [string]$Objective,
    [string]$CurrentItem = "W1",
    [string]$ItemTitle = "Define the first bounded item",
    [string[]]$AcceptanceCriteria = @(),
    [string]$AcceptanceCriteriaText = "",
    [int]$MaxRounds = 6,
    [int]$MaxSameFailureCount = 3,
    [switch]$Force
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

function Write-JsonFile {
    param($Object, [string]$Path)
    $Object | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $Path -Encoding UTF8
}

$root = Get-RepoRoot
$harnessRoot = Join-Path $root ".ai-harness"
if (-not (Test-Path -LiteralPath $harnessRoot)) {
    throw ".ai-harness directory not found: $harnessRoot"
}

$activePath = Join-Path $harnessRoot "ACTIVE"
if ((Test-Path -LiteralPath $activePath) -and -not $Force) {
    throw "Loop is already active. Use -Force only when intentionally reinitializing the current loop."
}

$runId = Get-Date -Format "yyyyMMdd-HHmmss"
$runRoot = Join-Path (Join-Path $harnessRoot "runs") $runId
New-Item -ItemType Directory -Path (Join-Path $runRoot "evidence") -Force | Out-Null

if (-not [string]::IsNullOrWhiteSpace($AcceptanceCriteriaText)) {
    $AcceptanceCriteria = @(
        $AcceptanceCriteriaText -split "(`r`n|`n|;)" |
            ForEach-Object { $_.Trim() } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) -and $_ -ne ";" }
    )
}

if ($AcceptanceCriteria.Count -eq 0) {
    $AcceptanceCriteria = @("Replace this criterion with a concrete, verifiable acceptance condition before execution.")
}

$criteriaLines = New-Object System.Collections.Generic.List[string]
$testResults = [ordered]@{}
$i = 1
foreach ($criterion in $AcceptanceCriteria) {
    $id = "A$i"
    $criteriaLines.Add("| $id | $criterion | Evidence path or command output summary | pending |")
    $testResults[$id] = [ordered]@{
        passes = $false
        evidence = @()
        notes = $criterion
    }
    $i++
}

$buildPlanLines = @(
    "# Build Plan",
    "",
    "## Objective",
    "",
    $Objective,
    "",
    "## Non-goals",
    "",
    "- Add explicit out-of-scope items before implementation.",
    "",
    "## Constraints",
    "",
    "- Follow ``AGENTS.md``, ``.agents/index.md``, and the selected role modules.",
    "- Preserve existing repository behavior unless the current objective explicitly changes it.",
    "- Keep changes scoped and verifiable.",
    "- Do not let the same AI role both implement and approve final completion.",
    "",
    "## Work Items",
    "",
    "| ID | Item | Acceptance Criteria | Evidence | Status |",
    "| --- | --- | --- | --- | --- |",
    "| $CurrentItem | $ItemTitle | See acceptance table below | Evidence path or command output summary | pending |",
    "",
    "## Acceptance Criteria",
    "",
    "| ID | Criterion | Evidence | Status |",
    "| --- | --- | --- | --- |",
    ($criteriaLines -join "`r`n"),
    "",
    "## Evaluation Plan",
    "",
    "- Use ``harness_evaluator`` for a fresh-context check before marking work complete.",
    "- Missing evidence means ``NEEDS_WORK``.",
    "- Record evaluator output with ``.codex/harness/record-evaluation.ps1``."
)
$buildPlan = $buildPlanLines -join "`r`n"

Set-Content -LiteralPath (Join-Path $harnessRoot "BUILD_PLAN.md") -Value $buildPlan -Encoding UTF8

$progressLines = @(
    "# Progress",
    "",
    "## Current State",
    "",
    "- Loop active.",
    "- Run ID: $runId",
    "- Current item: $CurrentItem",
    "- Status: running",
    "",
    "## Completed",
    "",
    "- None yet.",
    "",
    "## In Progress",
    "",
    "- ${CurrentItem}: $ItemTitle",
    "",
    "## Next Step",
    "",
    "- Execute one bounded item, gather evidence, update ``test-results.json``, then run a fresh-context evaluator.",
    "",
    "## Evidence",
    "",
    "- None yet.",
    "",
    "## Notes For Next Session",
    "",
    "- Read ``AGENTS.md``, ``.agents/index.md``, ``.agents/harness-runtime.md``, ``.ai-harness/LOOP_STATE.json``, and this file before continuing."
)
$progress = $progressLines -join "`r`n"

Set-Content -LiteralPath (Join-Path $harnessRoot "PROGRESS.md") -Value $progress -Encoding UTF8
Set-Content -LiteralPath (Join-Path $harnessRoot "NEXT_FINDINGS.md") -Value "# Next Findings`r`n`r`nNo evaluator findings recorded yet.`r`n" -Encoding UTF8
Write-JsonFile -Object $testResults -Path (Join-Path $harnessRoot "test-results.json")

$now = (Get-Date).ToString("o")
$state = [ordered]@{
    status = "running"
    current_item = $CurrentItem
    round = 0
    max_rounds = $MaxRounds
    same_failure_key = ""
    same_failure_count = 0
    max_same_failure_count = $MaxSameFailureCount
    last_result = ""
    run_id = $runId
    started_at = $now
    updated_at = $now
    notes = "Loop started. Evaluator remains read-only; record evaluator output through record-evaluation.ps1."
}
Write-JsonFile -Object $state -Path (Join-Path $harnessRoot "LOOP_STATE.json")

New-Item -ItemType File -Path $activePath -Force | Out-Null

Write-Host "Loop started."
Write-Host "Run ID: $runId"
Write-Host "State: .ai-harness\\LOOP_STATE.json"
Write-Host "Plan : .ai-harness\\BUILD_PLAN.md"
