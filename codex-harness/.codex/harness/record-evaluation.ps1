[CmdletBinding(PositionalBinding = $false)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("PASS", "NEEDS_WORK")]
    [string]$Result,
    [string]$Findings = "",
    [string]$CurrentItem,
    [string]$FailureKey = "",
    [string[]]$Evidence = @()
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

function Write-JsonFile {
    param($Object, [string]$Path)
    $Object | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $Path -Encoding UTF8
}

$root = Get-RepoRoot
$harnessRoot = Join-Path $root ".ai-harness"
$statePath = Join-Path $harnessRoot "LOOP_STATE.json"
$state = Read-JsonFile -Path $statePath
if (-not $state) {
    throw "LOOP_STATE.json not found. Start the loop with .codex/harness/start-loop.ps1 first."
}

if (-not $CurrentItem) {
    $CurrentItem = [string]$state.current_item
}

$round = [int]$state.round + 1
$runId = [string]$state.run_id
if ([string]::IsNullOrWhiteSpace($runId)) {
    $runId = Get-Date -Format "yyyyMMdd-HHmmss"
    $state.run_id = $runId
}

$runRoot = Join-Path (Join-Path $harnessRoot "runs") $runId
New-Item -ItemType Directory -Path $runRoot -Force | Out-Null

if ([string]::IsNullOrWhiteSpace($Findings)) {
    $Findings = if ($Result -eq "PASS") { "Evaluator reported PASS." } else { "Evaluator reported NEEDS_WORK without detailed findings." }
}

if ([string]::IsNullOrWhiteSpace($FailureKey) -and $Result -eq "NEEDS_WORK") {
    $FailureKey = ($Findings -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -First 1)
    if ([string]::IsNullOrWhiteSpace($FailureKey)) {
        $FailureKey = "unspecified"
    }
}

if ($Result -eq "PASS") {
    $state.status = "passed"
    $state.same_failure_key = ""
    $state.same_failure_count = 0
} else {
    if ([string]$state.same_failure_key -eq $FailureKey) {
        $state.same_failure_count = [int]$state.same_failure_count + 1
    } else {
        $state.same_failure_key = $FailureKey
        $state.same_failure_count = 1
    }
    $state.status = "needs_work"
}

$state.round = $round
$state.current_item = $CurrentItem
$state.last_result = $Result
$state.updated_at = (Get-Date).ToString("o")

$pauseReasons = New-Object System.Collections.Generic.List[string]
if ($Result -eq "NEEDS_WORK" -and $round -ge [int]$state.max_rounds) {
    $pauseReasons.Add("max_rounds reached")
}
if ($Result -eq "NEEDS_WORK" -and [int]$state.same_failure_count -ge [int]$state.max_same_failure_count) {
    $pauseReasons.Add("max_same_failure_count reached")
}

if ($pauseReasons.Count -gt 0) {
    $state.status = "paused"
    $state.notes = "Loop paused: $($pauseReasons -join ', '). Operator review required."
    New-Item -ItemType File -Path (Join-Path $harnessRoot "AGENT_STOP") -Force | Out-Null
} else {
    $state.notes = "Last evaluator result recorded by record-evaluation.ps1."
}

Write-JsonFile -Object $state -Path $statePath

$evidenceText = if ($Evidence.Count -gt 0) {
    ($Evidence | ForEach-Object { "- $_" }) -join "`r`n"
} else {
    "- No extra evidence paths recorded by this command."
}

$nextFindings = @"
# Next Findings

## Round $round

- Result: $Result
- Current item: $CurrentItem
- Failure key: $FailureKey
- Same failure count: $($state.same_failure_count)
- Status after recording: $($state.status)

## Findings

$Findings

## Evidence References

$evidenceText
"@

Set-Content -LiteralPath (Join-Path $harnessRoot "NEXT_FINDINGS.md") -Value $nextFindings -Encoding UTF8

$evalFile = Join-Path $runRoot ("evaluator-{0:D3}.md" -f $round)
Set-Content -LiteralPath $evalFile -Value $nextFindings -Encoding UTF8

Write-Host "Evaluation recorded."
Write-Host "Result: $Result"
Write-Host "Round : $round / $($state.max_rounds)"
Write-Host "Status: $($state.status)"
if ($pauseReasons.Count -gt 0) {
    Write-Host "Paused: $($pauseReasons -join ', ')"
}
