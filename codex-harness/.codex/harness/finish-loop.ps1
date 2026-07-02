[CmdletBinding(PositionalBinding = $false)]
param(
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

function Get-FailingCriteria {
    param($Results)
    $failures = New-Object System.Collections.Generic.List[string]
    foreach ($prop in $Results.PSObject.Properties) {
        $value = $prop.Value
        if (-not $value -or $value.passes -ne $true) {
            $failures.Add($prop.Name)
            continue
        }
        if (-not $value.evidence -or $value.evidence.Count -eq 0) {
            $failures.Add("$($prop.Name) has no evidence")
        }
    }
    return $failures
}

$root = Get-RepoRoot
$harnessRoot = Join-Path $root ".ai-harness"
$statePath = Join-Path $harnessRoot "LOOP_STATE.json"
$resultsPath = Join-Path $harnessRoot "test-results.json"
$state = Read-JsonFile -Path $statePath
$results = Read-JsonFile -Path $resultsPath

if (-not $state) {
    throw "LOOP_STATE.json not found."
}
if (-not $results) {
    throw "test-results.json not found."
}

$failures = Get-FailingCriteria -Results $results
if ($failures.Count -gt 0 -and -not $Force) {
    throw "Cannot finish loop because failing or unevidenced criteria remain: $($failures -join ', '). Use -Force only for an intentional manual override."
}

if ($state.last_result -ne "PASS" -and -not $Force) {
    throw "Cannot finish loop because last evaluator result is not PASS. Record a PASS evaluator result first or use -Force for a manual override."
}

$state.status = "done"
$state.updated_at = (Get-Date).ToString("o")
$state.notes = if ($Force) { "Loop finished with manual override." } else { "Loop finished after passing criteria with evidence." }
Write-JsonFile -Object $state -Path $statePath

foreach ($control in @("ACTIVE", "CONTINUE_ON_STOP", "AGENT_STOP")) {
    $path = Join-Path $harnessRoot $control
    if (Test-Path -LiteralPath $path) {
        Remove-Item -LiteralPath $path -Force
    }
}

Write-Host "Loop finished."
Write-Host "Status: done"
Write-Host "ACTIVE, CONTINUE_ON_STOP, and AGENT_STOP removed if present."
