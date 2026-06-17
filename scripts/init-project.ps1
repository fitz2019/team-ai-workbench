param(
    [Parameter(Mandatory = $true)]
    [string]$TargetProjectPath,
    [string[]]$Roles = @(),
    [string]$Template,
    [switch]$IncludeSkills,
    [switch]$IncludeAdvanced,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$sourceRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path -LiteralPath $TargetProjectPath)) {
    New-Item -ItemType Directory -Path $TargetProjectPath -Force | Out-Null
}
$targetRoot = (Resolve-Path -LiteralPath $TargetProjectPath).Path

$templateCatalog = @{
    "go-service" = @{
        Roles = @("backend", "qa")
        IncludeSkills = $true
        Overlay = "templates\go-service\project-specific-overlay.md"
    }
    "web-frontend" = @{
        Roles = @("frontend", "qa", "product")
        IncludeSkills = $true
        Overlay = "templates\web-frontend\project-specific-overlay.md"
    }
    "product-docs" = @{
        Roles = @("product")
        IncludeSkills = $true
        Overlay = "templates\product-docs\project-specific-overlay.md"
    }
    "qa-project" = @{
        Roles = @("qa")
        IncludeSkills = $true
        Overlay = "templates\qa-project\project-specific-overlay.md"
    }
    "feature-delivery" = @{
        Roles = @("product", "qa")
        IncludeSkills = $true
        Overlay = "templates\feature-delivery\project-specific-overlay.md"
    }
    "ops-service" = @{
        Roles = @("devops", "backend")
        IncludeSkills = $true
        Overlay = "templates\ops-service\project-specific-overlay.md"
    }
}

if ($Template) {
    if (-not $templateCatalog.ContainsKey($Template)) {
        throw "Unknown template: $Template"
    }
    $templateDef = $templateCatalog[$Template]
    if (-not $Roles -or $Roles.Count -eq 0) {
        $Roles = @($templateDef.Roles)
    }
    if (-not $IncludeSkills.IsPresent -and $templateDef.IncludeSkills) {
        $IncludeSkills = $true
    }
}

if (-not $Roles -or $Roles.Count -eq 0) {
    $Roles = @("backend")
}

$resolvedRoles = @()
foreach ($role in $Roles) {
    foreach ($part in ($role -split ",")) {
        $trimmed = $part.Trim()
        if ($trimmed) {
            $resolvedRoles += $trimmed
        }
    }
}
$resolvedRoles = $resolvedRoles | Select-Object -Unique

function Append-TextFile {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }

    $content = Get-Content -Raw -LiteralPath $Source
    if ([string]::IsNullOrWhiteSpace($content)) {
        return
    }

    Add-Content -LiteralPath $Destination -Value "`r`n$content"
    Write-Host "merged: $Destination <= $Source"
}

function Copy-PathSafe {
    param(
        [string]$Source,
        [string]$Destination
    )

    if ((Test-Path -LiteralPath $Destination) -and -not $Force) {
        Write-Host "skip existing: $Destination"
        return
    }

    $parent = Split-Path -Parent $Destination
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
    Write-Host "copied: $Destination"
}

Copy-PathSafe -Source (Join-Path $sourceRoot "core\AGENTS.md") -Destination (Join-Path $targetRoot "AGENTS.md")
Copy-PathSafe -Source (Join-Path $sourceRoot "core\.agents") -Destination (Join-Path $targetRoot ".agents")
Copy-PathSafe -Source (Join-Path $sourceRoot "core\.codex") -Destination (Join-Path $targetRoot ".codex")

if ($IncludeSkills) {
    $coreSkills = Join-Path $sourceRoot "core\skills"
    if (Test-Path -LiteralPath $coreSkills) {
        Copy-PathSafe -Source $coreSkills -Destination (Join-Path $targetRoot "skills")
    }
}

if ($IncludeAdvanced) {
    Copy-PathSafe -Source (Join-Path $sourceRoot "advanced") -Destination (Join-Path $targetRoot "advanced")
}

foreach ($role in $resolvedRoles) {
    $roleRoot = Join-Path $sourceRoot "roles\$role"
    if (-not (Test-Path -LiteralPath $roleRoot)) {
        throw "Unknown role: $role"
    }

    $roleAgents = Join-Path $roleRoot ".agents"
    $roleCodexAgents = Join-Path $roleRoot ".codex\agents"
    $roleCodexFragment = Join-Path $roleRoot ".codex\config.fragment.toml"
    $roleSkills = Join-Path $roleRoot "skills"

    if (Test-Path -LiteralPath $roleAgents) {
        Copy-Item -Path (Join-Path $roleAgents "*") -Destination (Join-Path $targetRoot ".agents") -Recurse -Force
        Write-Host "merged role .agents: $role"
    }

    if (Test-Path -LiteralPath $roleCodexAgents) {
        $targetCodexAgents = Join-Path $targetRoot ".codex\agents"
        if (-not (Test-Path -LiteralPath $targetCodexAgents)) {
            New-Item -ItemType Directory -Path $targetCodexAgents -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $roleCodexAgents "*") -Destination $targetCodexAgents -Recurse -Force
        Write-Host "merged role .codex agents: $role"
    }

    if (Test-Path -LiteralPath $roleCodexFragment) {
        Append-TextFile -Source $roleCodexFragment -Destination (Join-Path $targetRoot ".codex\config.toml")
    }

    if ($IncludeSkills -and (Test-Path -LiteralPath $roleSkills)) {
        $targetSkills = Join-Path $targetRoot "skills"
        if (-not (Test-Path -LiteralPath $targetSkills)) {
            New-Item -ItemType Directory -Path $targetSkills -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $roleSkills "*") -Destination $targetSkills -Recurse -Force
        Write-Host "merged role skills: $role"
    }
}

$examplePath = Join-Path $targetRoot ".agents\project-specific.md.example"
$projectSpecificPath = Join-Path $targetRoot ".agents\project-specific.md"

if ((Test-Path -LiteralPath $examplePath) -and (-not (Test-Path -LiteralPath $projectSpecificPath) -or $Force)) {
    Copy-Item -LiteralPath $examplePath -Destination $projectSpecificPath -Force
    Write-Host "created: $projectSpecificPath"
}

if ($Template) {
    $overlayPath = Join-Path $sourceRoot $templateCatalog[$Template].Overlay
    if (Test-Path -LiteralPath $overlayPath) {
        Append-TextFile -Source $overlayPath -Destination $projectSpecificPath
    }

    $starterRoot = Join-Path $sourceRoot "templates\$Template\starter-files"
    if (Test-Path -LiteralPath $starterRoot) {
        Copy-Item -Path (Join-Path $starterRoot "*") -Destination $targetRoot -Recurse -Force
        Write-Host "copied starter files for template: $Template"
    }
}

Write-Host ""
Write-Host "Initialization complete."
if ($Template) {
    Write-Host "Template: $Template"
    Write-Host "Template docs: templates\\$Template\\README.md"
}
Write-Host "Roles: $($resolvedRoles -join ', ')"
Write-Host "Next:"
Write-Host "1. Edit .agents\\project-specific.md"
Write-Host "2. Fill in real commands, business vocabulary, and security notes"
Write-Host "3. If using a template, read the template README and sample project-specific file"
Write-Host "4. Open the project with codex and run a small dry-run task"
