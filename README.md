# Syllabus Reader — WorkBuddy Skill

A WorkBuddy Skill that parses university course syllabi and extracts structured information with proactive risk flagging. Upload a PDF, DOCX, or provide a URL — the skill reads the syllabus and produces a clean, comprehensive summary that highlights hidden pitfalls students often miss.

> Optimized for **US university syllabi** with full **Chinese university** support.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![WorkBuddy Skill](https://img.shields.io/badge/WorkBuddy-Skill-blue)](https://www.codebuddy.cn/docs/workbuddy/Overview)

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
| **Risk Flags** | Proactive scanning for hidden risks and pitfalls (see below) |

### Proactive Risk Flagging — The Key Differentiator

Students often skim syllabi and miss critical policies. This skill performs a dedicated risk scan pass to catch:

| Severity | What It Flags |
|----------|---------------|
| **[CRITICAL]** | Attendance-based failure triggers, hard prerequisites that can drop you |
| **[HIGH]** | Double-pass rules, minimum final exam thresholds, workload collision weeks |
| **[MEDIUM]** | Hidden costs (iClickers, access codes), syllabus quizzes, group work risks |

**Specific risks scanned for:**
- **Attendance Fail Triggers** — "3 absences = automatic F" rules
- **Grade Threshold Traps** — "Must pass final to pass course" or "Must score ≥40% on each component"
- **Workload Collision Detection** — weeks where exam + project + problem set all converge
- **Late Work Traps** — zero-tolerance late policies, aggressive hourly deductions
- **Hidden Costs** — mandatory access codes, iClickers, custom-edition textbooks
- **Syllabus Quiz Requirements** — mandatory quizzes you must complete to stay enrolled
- **Group Work Risks** — peer evaluations that can tank your grade
- **Ungraded-But-Required** — items listed as mandatory but receiving no grade weight
- **Strict Prerequisites** — enforced prerequisites vs. advisory "recommended background"

---

## Installation

### Prerequisites
- [WorkBuddy](https://www.codebuddy.cn/) installed on your machine

### Method 1: Clone to Skills Directory

```bash
git clone https://github.com/JeromeWang6066/syllabus-reader-skill.git ~/.workbuddy/skills/syllabus-reader
```

Restart WorkBuddy and the skill will be automatically loaded.

### Method 2: Manual Download

1. Download and extract the repository ZIP
2. Move the `syllabus-reader` folder into `~/.workbuddy/skills/`
3. Restart WorkBuddy

Verify installation by saying **"Help me analyze a syllabus"** in any WorkBuddy conversation — the skill will activate.

---

## Usage

### Trigger Keywords

Any of these phrases will trigger the skill:
- `syllabus`, `教学大纲`, `课程大纲`, `course outline`, `课程介绍`
- `analyze this syllabus`, `解读这份大纲`, `parse my syllabus`
- `帮我整理课程大纲`, `课程安排`, `syllabus summary`
- `what to watch out for`, `hidden requirements`, `potential pitfalls`

### Examples

**From a URL:**
```
Analyze this syllabus: https://example.com/course-syllabus.html
```

**From an uploaded file:**
```
Upload a PDF or DOCX file of the syllabus and ask:
"请帮我解读这份教学大纲" or "Parse this syllabus for me"
```

**Ask about specific risks:**
```
"Are there any attendance fail triggers in this syllabus?"
"What are the heaviest workload weeks?"
"Is there a double-pass rule?"
```

### Output Language

- **Default**: Chinese (Simplified) — headers, labels, descriptions, action items
- **If you chat in English**: Output automatically switches to English
- **Never translated**: course names, book titles, personal names, university names, direct quotations

---

## Skill Structure

```
syllabus-reader/
├── SKILL.md                          # Core skill definition and workflow
├── README.md                         # This file
├── LICENSE                           # MIT License
├── assets/
│   └── syllabus_summary_template.md  # Output template (Chinese default)
├── references/
│   └── syllabus_patterns.md          # Pattern library for US & Chinese syllabi
└── scripts/
    └── generate_ics.py               # Optional: Generate .ics calendar from events JSON
```

### Files Explained

| File | Purpose |
|------|---------|
| `SKILL.md` | Main skill definition — YAML frontmatter + Markdown. Defines the four-step workflow, six extraction categories, nine risk categories, regional adaptation rules, and output language rules. |
| `assets/syllabus_summary_template.md` | The structured Markdown template used to format output. Pure Chinese default with inline language rules. |
| `references/syllabus_patterns.md` | Comprehensive library of syllabus section headers, grading patterns, terminology, and risk indicators for both US and Chinese university systems. Loaded as a reference during parsing. |
| `scripts/generate_ics.py` | Standalone Python utility. Not part of the standard skill workflow — use manually if you want to convert course events into an `.ics` calendar file importable by Apple Calendar, Outlook, or Google Calendar. |

---

## Example Output (Abbreviated)

```
# Design and Analysis of Algorithms — 课程大纲解读

> 快速概览
> - 课程代码：COMPSCI 308
> - 授课教师：Mustafa MISIR
> - 学分/学时：4 / 4
> - 学期：Fall 2026
> - 风险等级：中
> - 致命红线：无

## 一、课程基本信息
| 项目 | 详情 |
|------|------|
| 课程名称 | Design and Analysis of Algorithms |
| ... | ... |

## 六、特别关注
### [高危] 重要提醒
| 风险项 | 详情 | 来源 |
|--------|------|------|
| 任务密集周 | Week 9: Midterm + Project Phase 2 截止 | Schedule section |

### 任务密集周
| 周次 | 任务 | 建议 |
|------|------|------|
| Week 9 (Oct 19-23) | Midterm Exam + Project Phase 2 Due | 提前一周开始复习和项目收尾 |
```

---

## Contributing

Contributions are welcome! If you find a syllabus pattern that isn't detected, or have ideas for new risk categories:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-risk-pattern`)
3. Add your patterns to `references/syllabus_patterns.md`
4. Update `SKILL.md` if needed
5. Submit a pull request

---

## License

MIT — see [LICENSE](LICENSE) for details.

---

## Acknowledgments

Built on the [WorkBuddy Skill](https://www.codebuddy.cn/docs/workbuddy/Overview) system. Optimized based on real-world syllabus analysis across US and Chinese universities at all levels (undergraduate and graduate).
