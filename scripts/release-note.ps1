param(
    [Parameter(Mandatory = $true)]
    [string]$Version,
    [ValidateSet("major", "minor", "patch")]
    [string]$Type = "minor",
    [string[]]$Highlights = @(),
    [string]$ConsumerImpact = "update recommended",
    [switch]$WriteFile
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$releaseDate = Get-Date -Format "yyyy-MM-dd"

if ($Highlights.Count -eq 0) {
    $Highlights = @(
        "Summarize the main structural or user-facing changes here",
        "Call out role, template, or script changes that consumers will notice"
    )
}

$lines = @()
$lines += "# Release Note: $Version"
$lines += ""
$lines += "- Date: $releaseDate"
$lines += "- Type: $Type"
$lines += "- Consumer impact: $ConsumerImpact"
$lines += ""
$lines += "## Highlights"
$lines += ""
foreach ($item in $Highlights) {
    $lines += "- $item"
}
$lines += ""
$lines += "## Upgrade Guidance"
$lines += ""
$lines += '- Review whether the affected change touches `core/`, a role pack, `advanced/`, templates, or scripts.'
$lines += "- For existing consumer repositories, prefer scratch-dir comparison before merging updates."
$lines += "- Preserve each consumer repository's `.agents/project-specific.md` and other project-local truth."
$lines += ""
$lines += "## Validation"
$lines += ""
$lines += "- State what was re-tested."
$lines += "- Note any role or template combinations explicitly checked."

$output = $lines -join "`r`n"

if ($WriteFile) {
    $releaseDir = Join-Path $repoRoot "docs\releases"
    if (-not (Test-Path -LiteralPath $releaseDir)) {
        New-Item -ItemType Directory -Path $releaseDir -Force | Out-Null
    }

    $safeVersion = $Version -replace '[^a-zA-Z0-9._-]', '_'
    $filePath = Join-Path $releaseDir "$safeVersion.md"
    Set-Content -LiteralPath $filePath -Value $output -NoNewline
    Write-Host "wrote: $filePath"
}
else {
    Write-Output $output
}
