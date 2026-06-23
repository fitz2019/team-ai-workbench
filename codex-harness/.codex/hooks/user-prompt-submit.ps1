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
    param([string]$Context)

    if ([string]::IsNullOrWhiteSpace($Context)) {
        return
    }

    $result = [ordered]@{
        hookSpecificOutput = [ordered]@{
            hookEventName = "UserPromptSubmit"
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

if (Test-Path -LiteralPath (Join-Path $harnessRoot "ACTIVE")) {
    $messages.Add("Long-running harness mode is active. Keep PROGRESS.md current and preserve the default-fail evidence contract.")
}

if (Test-Path -LiteralPath (Join-Path $harnessRoot "AGENT_STOP")) {
    $messages.Add("AGENT_STOP exists. Explain that autonomous work is paused unless the user explicitly removes it.")
}

$steerPath = Join-Path $harnessRoot "STEER.md"
if (Test-Path -LiteralPath $steerPath) {
    $steer = (Get-Content -Raw -LiteralPath $steerPath).Trim()
    if (-not [string]::IsNullOrWhiteSpace($steer)) {
        $messages.Add("Operator steering:`n$steer")
    }
}

Write-AdditionalContext -Context ($messages -join "`n`n")
