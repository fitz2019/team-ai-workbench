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

function Write-AdditionalContext {
    param([string]$EventName, [string]$Context)

    if ([string]::IsNullOrWhiteSpace($Context)) {
        return
    }

    $result = [ordered]@{
        hookSpecificOutput = [ordered]@{
            hookEventName = $EventName
            additionalContext = $Context
        }
    }
    $result | ConvertTo-Json -Depth 6 -Compress
}

$payload = Read-HookPayload
$root = Get-RepoRoot -Payload $payload
$harnessRoot = Join-Path $root ".ai-harness"

if (-not (Test-Path -LiteralPath $harnessRoot)) {
    exit 0
}

$messages = New-Object System.Collections.Generic.List[string]
$messages.Add("Team AI Workbench Codex harness is installed. Route through AGENTS.md, .agents/index.md, and .agents/harness-runtime.md.")

if (Test-Path -LiteralPath (Join-Path $harnessRoot "ACTIVE")) {
    $messages.Add("Long-running mode is active. Read .ai-harness/BUILD_PLAN.md, PROGRESS.md, STEER.md, EVALUATOR_RUBRIC.md, and test-results.json before acting.")
}

if (Test-Path -LiteralPath (Join-Path $harnessRoot "AGENT_STOP")) {
    $messages.Add("AGENT_STOP exists. Do not continue autonomous work until the operator removes it.")
}

$steerPath = Join-Path $harnessRoot "STEER.md"
if (Test-Path -LiteralPath $steerPath) {
    $steer = (Get-Content -Raw -LiteralPath $steerPath).Trim()
    if (-not [string]::IsNullOrWhiteSpace($steer)) {
        $messages.Add("Current operator steering from .ai-harness/STEER.md:`n$steer")
    }
}

Write-AdditionalContext -EventName "SessionStart" -Context ($messages -join "`n`n")
