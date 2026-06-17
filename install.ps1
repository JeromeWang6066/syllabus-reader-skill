# ============================================================
#  Syllabus Reader — Universal Installer (PowerShell)
#  Installs the syllabus analysis prompt into your AI tool's
#  global config directory so it's available in every session.
#
#  Usage:
#    .\install.ps1 [platform]
#    .\install.ps1 -All
#    .\install.ps1 -List
#    .\install.ps1 -Uninstall <platform>
# ============================================================

param(
    [string]$Platform,
    [switch]$All,
    [switch]$List,
    [switch]$Uninstall,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/JeromeWang6066/syllabus-reader-skill.git"
$ScriptDir = $PSScriptRoot

function Show-Help {
    @"
Syllabus Reader — Universal Installer for AI Coding Tools

Usage: .\install.ps1 [-Platform <name>] [-All] [-List] [-Uninstall]

Platforms:
    workbuddy     Install to ~/.workbuddy/skills/          (git clone)
    claude-code   Install to ~/.claude/rules/                (global rule)
    codex         Install to ~/.agents/skills/               (git clone)
    copilot       Install to ~/.copilot/instructions/        (user-level)
    windsurf      Append prompt to ~/global_rules.md
    cursor        Install to ~/.cursor/rules/                 (user-level)

Flags:
    -All           Install on all platforms
    -List          List supported platforms
    -Uninstall     Remove from specified platform

Examples:
    .\install.ps1 workbuddy       # Install for WorkBuddy
    .\install.ps1 codex           # Install for OpenAI Codex CLI
    .\install.ps1 claude-code     # Install for Claude Code
    .\install.ps1 copilot         # Install for GitHub Copilot Chat
    .\install.ps1 windsurf        # Install for Windsurf
    .\install.ps1 cursor          # Install for Cursor
    .\install.ps1 -All            # Install on every platform
"@
}

function Show-Platforms {
    "Supported platforms:"
    @("workbuddy", "claude-code", "codex", "copilot", "windsurf", "cursor") | ForEach-Object { "  - $_" }
}

# --- Helper: Get SKILL.md content without YAML frontmatter ---
function Get-SkillContent {
    $lines = Get-Content "$ScriptDir\SKILL.md" -Encoding UTF8
    $skipYaml = $false
    $yamlEnds = 0
    foreach ($line in $lines) {
        if ($line -match '^---$') {
            $yamlEnds++
            if ($yamlEnds -ge 2) { $skipYaml = $true; continue }
        }
        if ($skipYaml) { $line }
    }
}

# --- Helper: Get prompt.md content ---
function Get-PromptContent {
    Get-Content "$ScriptDir\prompt.md" -Raw -Encoding UTF8
}

# --- WorkBuddy ---
function Install-WorkBuddy {
    $target = Join-Path $env:USERPROFILE ".workbuddy\skills\syllabus-reader"
    if (Test-Path $target) {
        "[WorkBuddy] Already installed at $target"
        "  To update: cd $target; git pull"
        return
    }

    New-Item -ItemType Directory -Path (Split-Path $target) -Force | Out-Null
    git clone $RepoUrl $target
    "[WorkBuddy] Installed to $target"
    "  Restart WorkBuddy to activate."
}

function Uninstall-WorkBuddy {
    $target = Join-Path $env:USERPROFILE ".workbuddy\skills\syllabus-reader"
    if (Test-Path $target) { Remove-Item -Recurse -Force $target }
    "[WorkBuddy] Removed from $target"
}

# --- Claude Code ---
function Install-ClaudeCode {
    $targetDir = Join-Path $env:USERPROFILE ".claude\rules"
    $target = Join-Path $targetDir "syllabus-reader.md"
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    $header = @"
---
description: Syllabus Reader — parse and analyze university course syllabi with proactive risk flagging. Engages when user provides or mentions a syllabus.
---

"@
    $skillContent = Get-SkillContent | Out-String
    Set-Content -Path $target -Value ($header + $skillContent) -Encoding UTF8

    "[Claude Code] Installed global rule to $target"
    "  Available in all projects. Mention 'syllabus' to trigger."
}

function Uninstall-ClaudeCode {
    $target = Join-Path $env:USERPROFILE ".claude\rules\syllabus-reader.md"
    if (Test-Path $target) { Remove-Item -Force $target }
    "[Claude Code] Removed global rule"
}

# --- OpenAI Codex CLI ---
function Install-Codex {
    $target = Join-Path $env:USERPROFILE ".agents\skills\syllabus-reader"
    if (Test-Path $target) {
        "[Codex] Already installed at $target"
        "  To update: cd $target; git pull"
        return
    }
    New-Item -ItemType Directory -Path (Split-Path $target) -Force | Out-Null
    git clone $RepoUrl $target
    "[Codex] Installed to $target"
    "  Run 'codex', then use /skills to activate."
}

function Uninstall-Codex {
    $target = Join-Path $env:USERPROFILE ".agents\skills\syllabus-reader"
    if (Test-Path $target) { Remove-Item -Recurse -Force $target }
    "[Codex] Removed from ~/.agents/skills/"
}

# --- GitHub Copilot Chat ---
function Install-Copilot {
    $targetDir = Join-Path $env:USERPROFILE ".copilot\instructions"
    $target = Join-Path $targetDir "syllabus-reader.instructions.md"
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    $header = @"
---
name: Syllabus Reader
description: Parse university course syllabi with risk flagging
applyTo: '**'
---

"@
    $promptContent = Get-PromptContent
    Set-Content -Path $target -Value ($header + $promptContent) -Encoding UTF8

    "[Copilot Chat] Installed user-level instruction to $target"
    "  Available across all VS Code workspaces automatically."
}

function Uninstall-Copilot {
    $target = Join-Path $env:USERPROFILE ".copilot\instructions\syllabus-reader.instructions.md"
    if (Test-Path $target) { Remove-Item -Force $target }
    "[Copilot Chat] Removed user-level instruction"
}

# --- Windsurf ---
function Install-Windsurf {
    $target = Join-Path $env:USERPROFILE "global_rules.md"
    if (-not (Test-Path $target)) { Set-Content -Path $target -Value "" -Encoding UTF8 }

    $existing = Get-Content $target -Raw -ErrorAction SilentlyContinue
    if ($existing -and $existing -match "# Syllabus Reader") {
        "[Windsurf] Already present in $target"
        return
    }

    $section = "`n---`n`n# Syllabus Reader (installed via syllabus-reader-skill)`n`n" + (Get-PromptContent)
    Add-Content -Path $target -Value $section -Encoding UTF8

    "[Windsurf] Appended prompt to $target"
    "  *** RESTART Windsurf for changes to take effect. ***"
}

function Uninstall-Windsurf {
    $target = Join-Path $env:USERPROFILE "global_rules.md"
    if (Test-Path $target) {
        # Simple approach: remove the section
        $lines = Get-Content $target -Encoding UTF8
        $output = @()
        $skipping = $false
        foreach ($line in $lines) {
            if ($line -match '# Syllabus Reader \(installed via syllabus-reader-skill\)') {
                $skipping = $true; continue
            }
            if (-not $skipping) { $output += $line }
            elseif ($line -match '^# ' -and $line -notmatch 'Syllabus Reader') {
                $skipping = $false; $output += $line
            }
        }
        Set-Content -Path $target -Value $output -Encoding UTF8
    }
    "[Windsurf] Removed from $target"
}

# --- Cursor ---
function Install-Cursor {
    $targetDir = Join-Path $env:USERPROFILE ".cursor\rules"
    $target = Join-Path $targetDir "syllabus-reader.mdc"
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    $header = @"
---
alwaysApply: false
description: Syllabus Reader — parse university course syllabi with risk flagging. Use when user uploads/mentions a syllabus.
---

"@
    $promptContent = Get-PromptContent
    Set-Content -Path $target -Value ($header + $promptContent) -Encoding UTF8

    "[Cursor] Installed user rule to $target"
    "  Available globally. Reference @syllabus-reader in chat to invoke."
}

function Uninstall-Cursor {
    $target = Join-Path $env:USERPROFILE ".cursor\rules\syllabus-reader.mdc"
    if (Test-Path $target) { Remove-Item -Force $target }
    "[Cursor] Removed user rule"
}

# --- Dispatcher ---
$dispatch = @{
    "workbuddy"   = @{ install = "Install-WorkBuddy"; uninstall = "Uninstall-WorkBuddy" }
    "claude-code" = @{ install = "Install-ClaudeCode"; uninstall = "Uninstall-ClaudeCode" }
    "codex"       = @{ install = "Install-Codex"; uninstall = "Uninstall-Codex" }
    "copilot"     = @{ install = "Install-Copilot"; uninstall = "Uninstall-Copilot" }
    "windsurf"    = @{ install = "Install-Windsurf"; uninstall = "Uninstall-Windsurf" }
    "cursor"      = @{ install = "Install-Cursor"; uninstall = "Uninstall-Cursor" }
}

if ($Help) { Show-Help; exit 0 }
if ($List) { Show-Platforms; exit 0 }

if ($All) {
    foreach ($p in $dispatch.Keys) {
        & $dispatch[$p].install
        ""
    }
    "`nAll done!"
    exit 0
}

if ($Uninstall) {
    if (-not $dispatch.ContainsKey($Platform)) {
        Write-Error "Unknown platform: $Platform"
        "Valid platforms: $($dispatch.Keys -join ', ')"
        exit 1
    }
    & $dispatch[$Platform].uninstall
    exit 0
}

if ([string]::IsNullOrEmpty($Platform)) {
    Show-Help
    ""
    "Quick start examples:"
    '    .\install.ps1 -Platform workbuddy'
    '    .\install.ps1 -Platform claude-code'
    '    .\install.ps1 -Platform codex'
    '    .\install.ps1 -Platform copilot'
    '    .\install.ps1 -Platform windsurf'
    '    .\install.ps1 -Platform cursor'
    ''
    '    .\install.ps1 -All              # All platforms at once'
    exit 0
}

if (-not $dispatch.ContainsKey($Platform)) {
    Write-Error "Unknown platform: $Platform"
    "Valid platforms: $($dispatch.Keys -join ', ')"
    exit 1
}

& $dispatch[$Platform].install
