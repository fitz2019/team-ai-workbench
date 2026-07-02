$ErrorActionPreference = "Stop"

function Read-HookPayload {
    $raw = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return $null
    }
    try {
        return $raw | ConvertFrom-Json
    } catch {
        return $null
    }
}

function Get-RepoRoot {
    param($Payload)

    $cwd = (Get-Location).Path
    if ($Payload -and $Payload.cwd) {
        $cwd = $Payload.cwd
    }

    try {
        $root = (& git -C $cwd rev-parse --show-toplevel 2>$null)
        if (-not [string]::IsNullOrWhiteSpace($root)) {
            return $root.Trim()
        }
    } catch {
    }

    return $cwd
}

function Write-StopJson {
    param($Object)
    $Object | ConvertTo-Json -Depth 8 -Compress
}

function Get-FailingCriteria {
    param([string]$Path)

    $failures = New-Object System.Collections.Generic.List[string]
    if (-not (Test-Path -LiteralPath $Path)) {
        $failures.Add("test-results.json is missing")
        return $failures
    }

    try {
        $json = Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
    } catch {
        $failures.Add("test-results.json is not valid JSON")
        return $failures
    }

    foreach ($prop in $json.PSObject.Properties) {
        $name = $prop.Name
        $value = $prop.Value
        if (-not $value -or $value.passes -ne $true) {
            $failures.Add($name)
            continue
        }
        if (-not $value.evidence -or $value.evidence.Count -eq 0) {
            $failures.Add("$name has no evidence")
        }
    }

    return $failures
}

function Get-LoopState {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return $null
    }

    try {
        return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
    } catch {
        return $null
    }
}

$payload = Read-HookPayload
$root = Get-RepoRoot -Payload $payload
$harnessRoot = Join-Path $root ".ai-harness"

if (-not (Test-Path -LiteralPath $harnessRoot)) {
    Write-StopJson ([ordered]@{ continue = $true })
    exit 0
}

if (Test-Path -LiteralPath (Join-Path $harnessRoot "AGENT_STOP")) {
    Write-StopJson ([ordered]@{
        continue = $false
        stopReason = "AGENT_STOP exists"
        systemMessage = "Team AI Workbench harness paused autonomous continuation because .ai-harness/AGENT_STOP exists."
    })
    exit 0
}

if (-not (Test-Path -LiteralPath (Join-Path $harnessRoot "ACTIVE"))) {
    Write-StopJson ([ordered]@{ continue = $true })
    exit 0
}

$loopState = Get-LoopState -Path (Join-Path $harnessRoot "LOOP_STATE.json")
if ($loopState -and $loopState.status -eq "paused") {
    Write-StopJson ([ordered]@{
        continue = $false
        stopReason = "Loop state is paused"
        systemMessage = "Team AI Workbench loop is paused by .ai-harness/LOOP_STATE.json. Review NEXT_FINDINGS.md and remove AGENT_STOP only when ready to continue."
    })
    exit 0
}

$testResultsPath = Join-Path $harnessRoot "test-results.json"
$failures = Get-FailingCriteria -Path $testResultsPath

if ($failures.Count -eq 0) {
    Write-StopJson ([ordered]@{
        continue = $true
        systemMessage = "Harness active: all criteria in .ai-harness/test-results.json currently pass with evidence."
    })
    exit 0
}

$message = "Harness active: failing or unevidenced criteria remain: $($failures -join ', '). Update PROGRESS.md, gather evidence, and keep test-results.json default-fail until verified."

if ($loopState -and [int]$loopState.round -ge [int]$loopState.max_rounds) {
    Write-StopJson ([ordered]@{
        continue = $false
        stopReason = "Loop max_rounds reached"
        systemMessage = "$message Loop round limit reached ($($loopState.round)/$($loopState.max_rounds)); operator review required."
    })
    exit 0
}

if ($payload -and $payload.stop_hook_active) {
    Write-StopJson ([ordered]@{
        continue = $false
        stopReason = "Harness stop gate already continued this turn"
        systemMessage = $message
    })
    exit 0
}

if (Test-Path -LiteralPath (Join-Path $harnessRoot "CONTINUE_ON_STOP")) {
    Write-StopJson ([ordered]@{
        decision = "block"
        reason = $message
        systemMessage = $message
    })
    exit 0
}

Write-StopJson ([ordered]@{
    continue = $true
    systemMessage = $message
})
