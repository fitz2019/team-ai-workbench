param(
    [Parameter(Mandatory = $true)]
    [string]$TargetProjectPath,
    [string[]]$Roles = @(),
    [string]$Template,
    [switch]$IncludeSkills,
    [switch]$IncludeAdvanced,
    [string]$ScratchPath
)

$ErrorActionPreference = "Stop"

$sourceRoot = Split-Path -Parent $PSScriptRoot
$initScript = Join-Path $PSScriptRoot "init-project.ps1"

if (-not (Test-Path -LiteralPath $TargetProjectPath)) {
    throw "Target project path does not exist: $TargetProjectPath"
}

$targetRoot = (Resolve-Path -LiteralPath $TargetProjectPath).Path

if (-not $ScratchPath) {
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $safeName = Split-Path $targetRoot -Leaf
    $ScratchPath = Join-Path $env:TEMP "team-ai-workbench-upgrade-$safeName-$stamp"
}

if (Test-Path -LiteralPath $ScratchPath) {
    Remove-Item -LiteralPath $ScratchPath -Recurse -Force
}
New-Item -ItemType Directory -Path $ScratchPath -Force | Out-Null

function Invoke-InitScript {
    if ($Template) {
        & $initScript -TargetProjectPath $ScratchPath -Template $Template -IncludeSkills:$IncludeSkills -IncludeAdvanced:$IncludeAdvanced
        return
    }

    if (-not $Roles -or $Roles.Count -eq 0) {
        $Roles = @("backend")
    }

    & $initScript -TargetProjectPath $ScratchPath -Roles $Roles -IncludeSkills:$IncludeSkills -IncludeAdvanced:$IncludeAdvanced
}

function Get-ManagedFileMap {
    param(
        [string]$RootPath
    )

    $map = @{}
    $surfaces = @("AGENTS.md", ".agents", ".codex", "skills", "advanced")

    foreach ($surface in $surfaces) {
        $surfacePath = Join-Path $RootPath $surface
        if (-not (Test-Path -LiteralPath $surfacePath)) {
            continue
        }

        $item = Get-Item -LiteralPath $surfacePath
        if (-not $item.PSIsContainer) {
            $relative = $surface
            $map[$relative] = (Resolve-Path -LiteralPath $surfacePath).Path
            continue
        }

        Get-ChildItem -LiteralPath $surfacePath -Recurse -File | ForEach-Object {
            $full = $_.FullName
            $relative = $full.Substring($RootPath.Length).TrimStart('\').Replace('\', '/')
            $map[$relative] = $full
        }
    }

    return $map
}

function Get-HashOrEmpty {
    param(
        [string]$Path
    )

    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) {
        return ""
    }

    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash
}

Invoke-InitScript

$scratchRoot = (Resolve-Path -LiteralPath $ScratchPath).Path
$expectedMap = Get-ManagedFileMap -RootPath $scratchRoot
$targetMap = Get-ManagedFileMap -RootPath $targetRoot

$allKeys = @($expectedMap.Keys + $targetMap.Keys | Sort-Object -Unique)

$upstreamOnly = @()
$targetOnly = @()
$changed = @()
$same = @()
$projectLocal = @()

foreach ($key in $allKeys) {
    $expected = $expectedMap[$key]
    $actual = $targetMap[$key]

    if ($expected -and -not $actual) {
        $upstreamOnly += $key
        continue
    }

    if ($actual -and -not $expected) {
        if ($key -eq ".agents/project-specific.md") {
            $projectLocal += $key
        }
        else {
            $targetOnly += $key
        }
        continue
    }

    $expectedHash = Get-HashOrEmpty -Path $expected
    $actualHash = Get-HashOrEmpty -Path $actual

    if ($expectedHash -eq $actualHash) {
        $same += $key
        continue
    }

    if ($key -eq ".agents/project-specific.md") {
        $projectLocal += $key
    }
    else {
        $changed += $key
    }
}

Write-Host ""
Write-Host "Upgrade Diff Report"
Write-Host "==================="
Write-Host "Target : $targetRoot"
Write-Host "Scratch: $scratchRoot"
if ($Template) {
    Write-Host "Template: $Template"
}
elseif ($Roles) {
    Write-Host "Roles   : $($Roles -join ', ')"
}
Write-Host "Skills  : $($IncludeSkills.IsPresent)"
Write-Host "Advanced: $($IncludeAdvanced.IsPresent)"
Write-Host ""
Write-Host "Summary"
Write-Host "- Upstream-only files : $($upstreamOnly.Count)"
Write-Host "- Changed files       : $($changed.Count)"
Write-Host "- Project-local files : $($projectLocal.Count)"
Write-Host "- Target-only files   : $($targetOnly.Count)"
Write-Host "- Unchanged files     : $($same.Count)"

if ($upstreamOnly.Count -gt 0) {
    Write-Host ""
    Write-Host "Upstream-only files to consider adding:"
    $upstreamOnly | ForEach-Object { Write-Host "- $_" }
}

if ($changed.Count -gt 0) {
    Write-Host ""
    Write-Host "Changed files to review manually:"
    $changed | ForEach-Object { Write-Host "- $_" }
}

if ($projectLocal.Count -gt 0) {
    Write-Host ""
    Write-Host "Project-local files to preserve:"
    $projectLocal | ForEach-Object { Write-Host "- $_" }
}

if ($targetOnly.Count -gt 0) {
    Write-Host ""
    Write-Host "Target-only managed-surface files:"
    $targetOnly | ForEach-Object { Write-Host "- $_" }
}

Write-Host ""
Write-Host "Next"
Write-Host "1. Inspect the scratch output if needed: $scratchRoot"
Write-Host "2. Merge upstream-only files selectively"
Write-Host "3. Diff changed files before replacing anything"
Write-Host "4. Preserve project-local truth, especially .agents/project-specific.md"
