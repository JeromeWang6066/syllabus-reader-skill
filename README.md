# Syllabus Reader

Parse university course syllabi and extract structured information with **proactive risk flagging** — hidden pitfalls, grade traps, attendance triggers, and workload collisions that students easily overlook.

Give it a syllabus (PDF, DOCX, URL), get back a comprehensive breakdown. Works on **WorkBuddy, Claude Code, Codex, Cursor, Windsurf, Copilot Chat** — any AI coding tool.

> Works with university syllabi worldwide — covers all major grading systems, term structures, and policy conventions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platforms](https://img.shields.io/badge/platform-Universal-purple)](#installation)

---

## Installation

### One-Line Install (Recommended)

**Bash / Git Bash:**
```bash
curl -fsSL https://raw.githubusercontent.com/JeromeWang6066/syllabus-reader-skill/main/install.sh | bash -s -- <platform>
```

**PowerShell:**
```powershell
irm https://raw.githubusercontent.com/JeromeWang6066/syllabus-reader-skill/main/install.ps1 | iex; .\install.ps1 -Platform <platform>
```

Replace `<platform>` with one of:
- **workbuddy**     → `~/.workbuddy/skills/`  (git clone, auto-loads)
- **claude-code**   → `~/.claude/rules/`       (global rule, all projects)
- **codex**         → `~/.agents/skills/`      (git clone, native skill support)
- **copilot**       → `~/.copilot/instructions/` (user-level, all workspaces)
- **windsurf**      → `~/global_rules.md`       (appends to global rules)
- **cursor**        → `~/.cursor/rules/`        (global user rule)

### Clone & Run Locally

```bash
git clone https://github.com/JeromeWang6066/syllabus-reader-skill.git
cd syllabus-reader-skill

# Bash:
./install.sh <platform>

# PowerShell:
.\install.ps1 -Platform <platform>

# Or install everywhere at once:
./install.sh --all          # Bash
.\install.ps1 -All          # PowerShell
```

### Uninstall

```bash
./install.sh --uninstall <platform>
.\install.ps1 -Uninstall <platform>
```

---

## Supported Platforms

Each platform has its own native config directory for global rules/instructions. The installer places the prompt there so it works across all projects automatically — no copying or pasting needed after initial setup.

| Platform | Config Directory | Method | Scope |
|----------|------------------|--------|-------|
| **[WorkBuddy](#workbuddy)** | `~/.workbuddy/skills/` | `git clone` into skills directory | All sessions, auto-loads |
| **[OpenAI Codex CLI](#openai-codex-cli)** | `~/.agents/skills/` | `git clone` into skills directory | All sessions, `/skills` to invoke |
| **[Claude Code](#claude-code)** | `~/.claude/rules/` | Global rule file (`*.md`) | All projects, auto-discovers |
| **[GitHub Copilot Chat](#github-copilot-chat)** | `~/.copilot/instructions/` | User-level instruction (`*.instructions.md`) | All VS Code workspaces, auto-discovers |
| **[Windsurf](#windsurf)** | `~/global_rules.md` | Append to single global rules file | All projects, requires restart |
| **[Cursor](#cursor)** | `~/.cursor/rules/` | User rule file (`*.mdc`) | Global, reference via `@` in chat |

> **Note:** For platforms without a file-based global config (**ChatGPT**, **Claude web**, **Gemini**), copy [`prompt.md`](prompt.md) and paste it as your system prompt or custom instructions.

### WorkBuddy

```bash
./install.sh workbuddy
# → git clones to ~/.workbuddy/skills/syllabus-reader
# → Restart WorkBuddy → ready to use
```

The SKILL.md YAML metadata is read automatically. No extra configuration needed.

### OpenAI Codex CLI

```bash
./install.sh codex
# → git clones to ~/.agents/skills/syllabus-reader
# → In Codex session: type /skills to see and activate
```

Codex natively supports skills in this directory — same format as WorkBuddy's SKILL.md (YAML frontmatter + Markdown).

### Claude Code

```bash
./install.sh claude-code
# → writes ~/.claude/rules/syllabus-reader.md (global rule)
# → Available immediately in ALL projects
```

Claude Code loads `~/.claude/rules/*.md` at the start of every session, across all projects. The rule auto-discovers based on context — when you mention a syllabus, it activates.

### GitHub Copilot Chat

```bash
./install.sh copilot
# → writes ~/.copilot/instructions/syllabus-reader.instructions.md
# → Available in every VS Code workspace automatically
```

Copilot recursively scans `~/.copilot/instructions/` and applies user-level instructions globally. Uses `applyTo: '**'` so it activates on all files.

### Windsurf

```bash
./install.sh windsurf
# → appends prompt content to ~/global_rules.md
# → *** RESTART Windsurf ***
```

Windsurf reads `~/global_rules.md` on startup. Changes require an application restart. The section is cleanly delimited so uninstallation is non-destructive.

### Cursor

```bash
./install.sh cursor
# → writes ~/.cursor/rules/syllabus-reader.mdc (user rule)
# → Reference @syllabus-reader in chat to invoke
```

Cursor supports user-level rules via `.cursor/rules/*.mdc`. Set `alwaysApply: false` so it only loads when referenced or when relevant.

---

## Features

### Six Extraction Categories

| Category | What It Covers |
|----------|----------------|
| **Basic Info** | Course name, code, instructor, contact, credits, prerequisites, semester |
| **Schedule** | Lecture/lab times, exam dates, holidays, add/drop deadlines, weekly overview |
| **Teaching Content** | Course description, learning objectives, textbooks, weekly topic breakdown |
| **Grading** | Component weights, grading scale, late policies, extra credit |
| **Other Notes** | Attendance policy, academic integrity, device policy, communication rules |
| **Risk Flags** | Proactive scanning for hidden risks and pitfalls (the key differentiator) |

### Proactive Risk Flagging

Students often skim syllabi and miss critical policies. The prompt performs a dedicated risk scan pass to catch:

| Severity | What It Flags |
|----------|---------------|
| **[CRITICAL]** | Attendance-based failure triggers, hard prerequisites that can drop you |
| **[HIGH]** | Double-pass rules, minimum final exam thresholds, workload collision weeks |
| **[MEDIUM]** | Hidden costs (iClickers, access codes), syllabus quizzes, group work risks |

**Nine risk categories scanned for:**
- **Attendance Fail Triggers** — "3 absences = automatic F"
- **Grade Threshold Traps** — "Must pass final to pass course"
- **Workload Collision Detection** — weeks where exam + project + problem set converge
- **Late Work Traps** — zero-tolerance policies, aggressive hourly deductions
- **Hidden Costs** — mandatory access codes, iClickers, custom editions
- **Syllabus Quiz Requirements** — must pass to stay enrolled
- **Group Work Risks** — peer evaluations that sink your grade
- **Ungraded-But-Required** — mandatory items with no grade weight
- **Strict Prerequisites** — enforced vs. advisory "recommended background"

### Output Language

- **Default**: Chinese (Simplified)
- **If you chat in English**: Output switches to English
- **Never translated**: course names, book titles, personal names, university names, direct quotations

---

## Repository Structure

```
syllabus-reader-skill/
├── SKILL.md                                  # Canonical instructions (all platforms)
├── prompt.md                                 # Condensed universal prompt
├── install.sh                                # Universal installer (Bash)
├── install.ps1                               # Universal installer (PowerShell)
├── README.md                                 # This file
├── LICENSE                                   # MIT License
├── assets/
│   └── syllabus_summary_template.md          # Output template (Chinese default)
├── references/
│   └── syllabus_patterns.md                  # Pattern library for worldwide syllabi
└── scripts/
    └── generate_ics.py                       # Optional: Generate .ics calendar file
```

### Key Files

| File | Purpose |
|------|---------|
| [`SKILL.md`](SKILL.md) | **The canonical instruction set.** Works on every platform — ignore the YAML frontmatter if not using WorkBuddy. Contains the most complete version with detailed risk categories, regional adaptation logic, and output formatting rules. |
| [`prompt.md`](prompt.md) | **Condensed universal prompt.** Self-contained, platform-agnostic. Paste into any AI tool that doesn't have a config directory. |
| [`references/syllabus_patterns.md`](references/syllabus_patterns.md) | Comprehensive library of section headers, grading patterns, terminology, and risk indicators covering major university systems worldwide. |
| [`assets/syllabus_summary_template.md`](assets/syllabus_summary_template.md) | Structured Markdown output template. The standard format for results regardless of platform. |
| [`scripts/generate_ics.py`](scripts/generate_ics.py) | Standalone Python utility. Feed a JSON array of events → `.ics` file for Apple Calendar / Outlook / Google Calendar. |

---

## Usage Examples

**From a URL:**
```
Analyze this syllabus: https://example.com/course-syllabus.html
```

**From a file:**
```
Upload a PDF or DOCX and say:
"请帮我解读这份教学大纲" or "Parse this syllabus for me"
```

**Targeted questions:**
```
"Are there any attendance fail triggers in this syllabus?"
"What are the heaviest workload weeks?"
"Is there a double-pass rule?"
"What hidden costs should I budget for?"
```

---

## Example Output (Abbreviated)

```
# Design and Analysis of Algorithms — 课程大纲解读

> 快速概览
> - 课程代码：COMPSCI 308  |  学分：4  |  学期：Fall 2026
> - 风险等级：中  |  致命红线：无

## 六、特别关注
### [高危] 重要提醒
| 风险项 | 详情 | 来源 |
|--------|------|------|
| 任务密集周 | Week 9: Midterm + Project Phase 2 截止 | Schedule section |

### 任务密集周
| 周次 | 任务 | 建议 |
|------|------|------|
| Week 9 (Oct 19-23) | Midterm Exam + Project Phase 2 Due | 提前一周开始复习和收尾 |
```

---

## Contributing

Contributions welcome! Found a syllabus pattern that doesn't get detected? Have ideas for new risk categories?

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-risk-pattern`)
3. Add patterns to `references/syllabus_patterns.md`
4. Update `SKILL.md` and `prompt.md` if the detection logic changes
5. Submit a pull request

---

## License

MIT — see [LICENSE](LICENSE).

---

## Acknowledgments

Built from real-world syllabus analysis across US and Chinese universities. The risk flagging system was developed by analyzing hundreds of syllabi to identify the patterns that most frequently catch students off guard.
