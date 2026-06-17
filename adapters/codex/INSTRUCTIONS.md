# Syllabus Analysis Instructions for OpenAI Codex

Copy this file to `.codex/` in your project root to give Codex syllabus analysis capabilities.

## Activation

Engage when the user provides a syllabus (URL or file) or asks to analyze/parse/interpret one. Also engage for targeted questions about specific risks (attendance triggers, grade traps, workload collisions).

## What to Extract

Parse the syllabus into six categories:

1. **Basic Info** — Course name, code, instructor, credits, prerequisites, semester
2. **Schedule** — Lecture/lab times, exam dates, holidays, deadlines, weekly overview
3. **Teaching Content** — Description, objectives, textbooks, weekly topics
4. **Grading** — Component weights, grading scale, late policies
5. **Other Notes** — Attendance, academic integrity, device policy, communication
6. **Risk Flags** — Proactive scan for hidden pitfalls (see below)

## Risk Scan (Second Pass — Mandatory)

After standard extraction, re-read the syllabus for:

- **Attendance Fail Triggers** — "X absences = automatic F", "缺课X次取消考试资格"
- **Grade Threshold Traps** — "Must pass final to pass course", double-pass rules
- **Workload Collisions** — Weeks where exam + project + assignment converge
- **Late Work Penalties** — Zero-tolerance, hourly deductions
- **Hidden Costs** — Access codes, iClickers, custom textbooks, lab fees
- **Syllabus Quizzes** — Mandatory first-week quizzes
- **Ungraded-But-Required** — Mandatory items with no weight
- **Group Work Risks** — Peer evaluations, free-rider policies
- **Strict Prerequisites** — Enforced vs. advisory

Tag with severity: [CRITICAL] / [HIGH] / [MEDIUM]. Cite source for each flag.

## Output Language

- **Default**: Chinese (Simplified)
- **If user writes in English**: Output in English
- **Never translate**: Course names, codes, book titles, person names, university names

## Output Structure

See `../../assets/syllabus_summary_template.md` for the template format. Missing info → `[未提及]` or `[Not specified]`.

## Regional Context

Adapt detection based on syllabus language and format, not assumed region. Reference `../../references/syllabus_patterns.md` for pattern examples. When the grading system or term structure is unfamiliar, extract it faithfully as presented.
