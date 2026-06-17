# Syllabus Reader

Parse university course syllabi and extract structured information with **proactive risk flagging** — hidden pitfalls, grade traps, attendance triggers, and workload collisions that students easily overlook.

Give it a syllabus (PDF, DOCX, URL), get back a comprehensive breakdown. Works on **WorkBuddy, Claude Code, Codex, Cursor, Windsurf, Copilot Chat** — any AI coding tool.

> Works with university syllabi worldwide — covers all major grading systems, term structures, and policy conventions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platforms](https://img.shields.io/badge/platform-Universal-purple)](#supported-platforms)

---

## Quick Start

### Any AI Tool — Paste the Prompt

The fastest way: copy `prompt.md` or `SKILL.md` into your AI tool, then provide a syllabus.

```
Copy → Paste into Claude Code / Codex / Cursor / ChatGPT → Done
```

Or paste this directly:

````
You are a syllabus analysis assistant. Parse the provided syllabus and extract six categories: (1) Basic Info, (2) Schedule, (3) Teaching Content, (4) Grading, (5) Other Notes, (6) Risk Flags. For Risk Flags, proactively scan for: attendance fail triggers, grade threshold traps, workload collision weeks, hidden costs, late work penalties, syllabus quiz requirements, group work risks, ungraded-but-required components, strict prerequisites. Use [CRITICAL] / [HIGH] / [MEDIUM] severity tags. Default output in Chinese; switch to English if I speak English. Never translate course names, book titles, person names, or university names.
````

### WorkBuddy — One-Click Install

```bash
git clone https://github.com/JeromeWang6066/syllabus-reader-skill.git ~/.workbuddy/skills/syllabus-reader
```

Restart WorkBuddy, then try: **"帮我解读这份 syllabus"**

### Claude Code

```bash
# Copy adapter to your project
cp adapters/claude-code/CLAUDE.md CLAUDE.md
```

Or paste `SKILL.md` or `prompt.md` into your instruction.

### OpenAI Codex / Copilot Chat

Copy `adapters/codex/INSTRUCTIONS.md` to your project's `.codex/` directory, or paste `prompt.md` directly.

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

## Supported Platforms

| Platform | How to Use |
|----------|------------|
| **WorkBuddy** | `git clone` to `~/.workbuddy/skills/` → auto-loads |
| **Claude Code** | Copy `adapters/claude-code/CLAUDE.md` to project root as `CLAUDE.md` |
| **OpenAI Codex** | Copy `adapters/codex/INSTRUCTIONS.md` to `.codex/` directory |
| **Cursor** | Paste `SKILL.md` or `prompt.md` into Cursor Rules |
| **Windsurf** | Paste `SKILL.md` or `prompt.md` as a global/workspace rule |
| **GitHub Copilot Chat** | Paste `prompt.md` as a custom instruction |
| **ChatGPT / Claude** | Paste `prompt.md` at the start of conversation |
| **Any AI tool** | Paste `SKILL.md` or `prompt.md` — universal compatibility |

---

## Repository Structure

```
syllabus-reader-skill/
├── SKILL.md                                  # Canonical instructions (all platforms)
├── prompt.md                                 # Condensed universal prompt (all platforms)
├── README.md                                 # This file
├── LICENSE                                   # MIT License
├── assets/
│   └── syllabus_summary_template.md          # Output template (Chinese default)
├── references/
│   └── syllabus_patterns.md                  # Pattern library for US & Chinese syllabi
├── scripts/
│   └── generate_ics.py                       # Optional: Generate .ics calendar file
└── adapters/
    ├── claude-code/
    │   └── CLAUDE.md                         # Claude Code adapter
    └── codex/
        └── INSTRUCTIONS.md                   # OpenAI Codex adapter
```

### Key Files

| File | Purpose |
|------|---------|
| `SKILL.md` | **The canonical instruction set.** The YAML at top is for WorkBuddy metadata; all other AI tools can read it by starting from `# Syllabus Reader`. Contains the most complete and detailed version. If in doubt, use `SKILL.md` — it works everywhere. |
| `prompt.md` | **Condensed universal prompt.** Paste into any AI tool for quick syllabus analysis. Self-contained, platform-agnostic. |
| `references/syllabus_patterns.md` | Comprehensive library of section headers, grading patterns, terminology, and risk indicators covering major university systems worldwide. |
| `assets/syllabus_summary_template.md` | Structured Markdown output template. The standard format for results regardless of platform. |
| `scripts/generate_ics.py` | Standalone Python utility. Feed a JSON array of events → `.ics` file for Apple Calendar / Outlook / Google Calendar. |
| `adapters/` | Platform-specific adapter files (Claude Code, Codex, etc.). |

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
