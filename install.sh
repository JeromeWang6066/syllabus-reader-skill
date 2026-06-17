#!/usr/bin/env bash
# ============================================================
#  Syllabus Reader — Universal Installer
#  Installs the syllabus analysis prompt into your AI tool's
#  global config directory so it's available in every session.
#
#  Usage:
#    ./install.sh [platform]
#    ./install.sh --all          (install everywhere)
#    ./install.sh --list         (show supported platforms)
#    ./install.sh --uninstall [platform]
#
#  Supported platforms:
#    workbuddy   → ~/.workbuddy/skills/syllabus-reader
#    claude-code → ~/.claude/rules/syllabus-reader.md
#    codex       → ~/.agents/skills/syllabus-reader
#    copilot     → ~/.copilot/instructions/syllabus-reader.md
#    windsurf    → ~/global_rules.md  (appends to existing)
#    cursor      → ~/.cursor/rules/syllabus-reader.mdc
# ============================================================

set -e

REPO_URL="https://github.com/JeromeWang6066/syllabus-reader-skill.git"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLATFORMS="workbuddy claude-code codex copilot windsurf cursor"

usage() {
    echo "Usage: $0 [platform] [--all] [--list] [--uninstall]"
    echo ""
    echo "Platforms:"
    echo "  workbuddy     Install to ~/.workbuddy/skills/          (git clone)"
    echo "  claude-code   Install to ~/.claude/rules/                (global rule)"
    echo "  codex         Install to ~/.agents/skills/               (git clone)"
    echo "  copilot       Install to ~/.copilot/instructions/        (user-level)"
    echo "  windsurf      Append prompt to ~/global_rules.md"
    echo "  cursor        Install to ~/.cursor/rules/                 (user-level)"
    echo ""
    echo "Flags:"
    echo "  --all           Install on all platforms"
    echo "  --list          List supported platforms"
    echo "  --uninstall     Remove from specified platform"
}

list_platforms() {
    echo "Supported platforms:"
    for p in $PLATFORMS; do
        echo "  - $p"
    done
}

# --- WorkBuddy ---
install_workbuddy() {
    local target="$HOME/.workbuddy/skills/syllabus-reader"
    if [ -d "$target" ]; then
        echo "[WorkBuddy] Already installed at $target"
        echo "  To update: cd $target && git pull"
        return 0
    fi
    mkdir -p "$(dirname "$target")"
    git clone "$REPO_URL" "$target"
    echo "[WorkBuddy] ✅ Installed to $target"
    echo "  Restart WorkBuddy to activate."
}

uninstall_workbuddy() {
    local target="$HOME/.workbuddy/skills/syllabus-reader"
    rm -rf "$target"
    echo "[WorkBuddy] 🗑️  Removed from $target"
}

# --- Claude Code ---
install_claude_code() {
    local target_dir="$HOME/.claude/rules"
    local target="$target_dir/syllabus-reader.md"
    mkdir -p "$target_dir"

    # Copy the full SKILL.md as a global rule (with frontmatter)
    cat > "$target" << 'HEADER'
---
description: Syllabus Reader — parse and analyze university course syllabi with proactive risk flagging. Engages when user provides or mentions a syllabus.
---

HEADER

    # Append SKILL.md content (skip YAML frontmatter)
    sed -n '/^---$/,$ p' "$SCRIPT_DIR/SKILL.md" | tail -n +2 >> "$target"

    echo "[Claude Code] ✅ Installed global rule to $target"
    echo "  Available in all projects. Type /skills or mention 'syllabus' to trigger."
}

uninstall_claude_code() {
    rm -f "$HOME/.claude/rules/syllabus-reader.md"
    echo "[Claude Code] 🗑️  Removed global rule"
}

# --- OpenAI Codex CLI ---
install_codex() {
    local target="$HOME/.agents/skills/syllabus-reader"
    if [ -d "$target" ]; then
        echo "[Codex] Already installed at $target"
        echo "  To update: cd $target && git pull"
        return 0
    fi
    mkdir -p "$(dirname "$target")"
    git clone "$REPO_URL" "$target"
    echo "[Codex] ✅ Installed to $target"
    echo "  Run 'codex', then use /skills to activate."
}

uninstall_codex() {
    rm -rf "$HOME/.agents/skills/syllabus-reader"
    echo "[Codex] 🗑️  Removed from ~/.agents/skills/"
}

# --- GitHub Copilot Chat ---
install_copilot() {
    local target_dir="$HOME/.copilot/instructions"
    local target="$target_dir/syllabus-reader.instructions.md"
    mkdir -p "$target_dir"

    # Create as an always-on instruction with applyTo: **
    cat > "$target" << HEADER
---
name: Syllabus Reader
description: Parse university course syllabi with risk flagging
applyTo: '**'
---

HEADER

    cat "$SCRIPT_DIR/prompt.md" >> "$target"

    echo "[Copilot Chat] ✅ Installed user-level instruction to $target"
    echo "  Available across all VS Code workspaces automatically."
}

uninstall_copilot() {
    rm -f "$HOME/.copilot/instructions/syllabus-reader.instructions.md"
    echo "[Copilot Chat] 🗑️  Removed user-level instruction"
}

# --- Windsurf ---
install_windsurf() {
    local target="$HOME/global_rules.md"
    touch "$target"

    # Check if already appended
    if grep -q "# Syllabus Reader" "$target" 2>/dev/null; then
        echo "[Windsurf] Already present in $target"
        return 0
    fi

    # Append as a new section
    {
        echo ""
        echo "---"
        echo ""
        echo "# Syllabus Reader (installed via syllabus-reader-skill)"
        echo ""
        cat "$SCRIPT_DIR/prompt.md"
    } >> "$target"

    echo "[Windsurf] ✅ Appended prompt to $target"
    echo "  ⚠️  RESTART Windsurf for changes to take effect."
}

uninstall_windsurf() {
    local target="$HOME/global_rules.md"
    if [ -f "$target" ]; then
        # Remove the section between markers (non-destructive, keeps other content)
        python3 -c "
import sys
lines = open('$target').readlines()
skip = False
output = []
for line in lines:
    if '# Syllabus Reader (installed via syllabus-reader-skill)' in line:
        skip = True
        continue
    if skip:
        if line.strip() == '---':
            continue
        if not skip:
            output.append(line)
        # Keep reading until we find end marker or next top-level heading starting with #
        if skip and line.startswith('# ') and 'Syllabus Reader' not in line:
            output.append(line)
            skip = False
        elif not skip:
            output.append(line)
open('$target','w').writelines(output)
" 2>/dev/null || echo "  Manual cleanup may be needed: edit ~/global_rules.md and remove the '# Syllabus Reader' section"
    fi
    echo "[Windsurf] 🗑️  Removed from $target"
}

# --- Cursor ---
install_cursor() {
    local target_dir="$HOME/.cursor/rules"
    local target="$target_dir/syllabus-reader.mdc"
    mkdir -p "$target_dir"

    # Cursor uses .mdc format with optional frontmatter
    cat > "$target" << EOF
---
alwaysApply: false
description: Syllabus Reader — parse university course syllabi with risk flagging. Use when user uploads/mentions a syllabus.
---

EOF

    cat "$SCRIPT_DIR/prompt.md" >> "$target"

    echo "[Cursor] ✅ Installed user rule to $target"
    echo "  Available globally. Reference @syllabus-reader in chat to invoke."
}

uninstall_cursor() {
    rm -f "$HOME/.cursor/rules/syllabus-reader.mdc"
    echo "[Cursor] 🗑️  Removed user rule"
}

# --- Dispatcher ---
do_install() {
    case "$1" in
        workbuddy)       install_workbuddy ;;
        claude-code)     install_claude_code ;;
        codex)           install_codex ;;
        copilot)         install_copilot ;;
        windsurf)        install_windsurf ;;
        cursor)          install_cursor ;;
        *)
            echo "Unknown platform: $1"
            echo "Run '$0 --list' to see supported platforms"
            exit 1
            ;;
    esac
}

do_uninstall() {
    case "$1" in
        workbuddy)       uninstall_workbuddy ;;
        claude-code)     uninstall_claude_code ;;
        codex)           uninstall_codex ;;
        copilot)         uninstall_copilot ;;
        windsurf)        uninstall_windsurf ;;
        cursor)          uninstall_cursor ;;
        *)
            echo "Unknown platform: $1"
            exit 1
            ;;
    esac
}

# --- Main ---
case "${1:-}" in
    --help|-h) usage ;;
    --list)   list_platforms ;;
    --all)
        for p in $PLATFORMS; do
            echo ""
            do_install "$p"
        done
        echo ""
        echo "All done! 🎉"
        ;;
    --uninstall)
        shift
        if [ -z "${1:-}" ]; then
            echo "Usage: $0 --uninstall <platform>"
            exit 1
        fi
        do_uninstall "$1"
        ;;
    "")
        usage
        echo ""
        echo "Quick start:"
        echo "  $0 workbuddy       # Install for WorkBuddy (git clone)"
        echo "  $0 claude-code     # Install for Claude Code (global rule)"
        echo "  $0 codex           # Install for OpenAI Codex CLI (git clone)"
        echo "  $0 copilot         # Install for Copilot Chat (user instructions)"
        echo "  $0 windsurf        # Install for Windsurf (global rules)"
        echo "  $0 cursor          # Install for Cursor (global user rule)"
        echo ""
        echo "Or: $0 --all         # Install on every platform at once"
        ;;
    *)
        do_install "$1"
        ;;
esac
