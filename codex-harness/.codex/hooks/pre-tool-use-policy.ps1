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

function Deny-ToolUse {
    param([string]$Reason)

    $result = [ordered]@{
        hookSpecificOutput = [ordered]@{
            hookEventName = "PreToolUse"
            permissionDecision = "deny"
            permissionDecisionReason = $Reason
        }
    }
    $result | ConvertTo-Json -Depth 6 -Compress
}

function Add-Context {
    param([string]$Context)

    $result = [ordered]@{
        hookSpecificOutput = [ordered]@{
            hookEventName = "PreToolUse"
            additionalContext = $Context
        }
    }
    $result | ConvertTo-Json -Depth 6 -Compress
}

$payload = Read-HookPayload
$root = Get-RepoRoot -Payload $payload
$harnessRoot = Join-Path $root ".ai-harness"

if (Test-Path -LiteralPath (Join-Path $harnessRoot "AGENT_STOP")) {
    Deny-ToolUse -Reason "Blocked by Team AI Workbench harness: .ai-harness/AGENT_STOP exists."
    exit 0
}

$commandText = ""
if ($payload -and $payload.tool_input -and $payload.tool_input.command) {
    $commandText = [string]$payload.tool_input.command
}

if ($commandText -match "test-results\.json" -and $commandText -match '"passes"\s*:\s*true' -and $commandText -notmatch '"evidence"') {
    Deny-ToolUse -Reason "Do not mark .ai-harness/test-results.json passes=true without evidence. Add evidence first, then rerun."
    exit 0
}

if (Test-Path -LiteralPath (Join-Path $harnessRoot "ACTIVE")) {
    Add-Context -Context "Harness active: keep .ai-harness/PROGRESS.md and test-results.json consistent with real evidence."
}
