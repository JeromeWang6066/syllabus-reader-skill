---
name: syllabus-reader
description: "This skill should be used when the user wants to interpret, parse, or summarize a university course syllabus from any country or institution. It handles uploaded files (PDF, DOCX) or URLs pointing to course syllabus pages. The skill extracts key information: basic course info, schedule, teaching content, grading breakdown, other important notes, and proactively flags hidden risks and pitfalls (attendance fail triggers, strict prerequisites, workload collision weeks, grade threshold traps, hidden costs, group work risks, and other easily overlooked policies). Outputs a clean structured summary with severity-ranked risk flags. Compatible with syllabi worldwide across all major university systems, grading schemes, and term structures. Trigger keywords include: syllabus, 教学大纲, 课程大纲, course outline, 课程介绍, analyze this syllabus, 解读这份大纲, parse my syllabus, 帮我整理课程大纲, 课程安排, syllabus summary, 课程解析, what to watch out for, hidden requirements, potential pitfalls."
agent_created: true
---

<!-- 
Platform compatibility:
- WorkBuddy: Reads the YAML above for skill metadata. Ignores this comment.
- All other AI tools (Claude Code, Codex, Cursor, ChatGPT, etc.): 
  Ignore the YAML block above. Start reading from "# Syllabus Reader" below.
  This file is the canonical instruction set — reference it directly or paste
  its content into your AI tool's system prompt / rules / custom instructions.
-->

# Syllabus Reader

## Overview

Parse and interpret university course syllabi from various sources (PDF, DOCX, HTML/web pages).
Extract and organize six core categories of information into a consistent, readable summary
format. Beyond basic information, proactively scan for hidden risks and critical policies
that students easily overlook — strict attendance triggers, prerequisite enforcement,
workload collision periods, and grade thresholds that can unexpectedly fail a student.
Works with syllabi from universities worldwide, covering all major grading systems
and term structures.

## When to Engage

Engage when the user:
- Uploads a syllabus file (PDF, DOCX) or provides a syllabus URL
- Asks to "interpret", "parse", "summarize", "analyze" a syllabus
- Uses keywords like: syllabus, 教学大纲, 课程大纲, course outline, 课程安排
- Wants to extract schedule, grading, or course content from a syllabus document
- Wants to find "hidden requirements", "gotchas", "things to watch out for", "whether this course is hard", or "what could go wrong"
- Asks specifically about attendance fail triggers, grade thresholds, or workload balance

## Core Extraction Targets

For every syllabus, extract information organized into these six categories:

### 1. Basic Course Information
- Course name (full name + course code/number if available)
- Instructor(s) name, email, office location, office hours
- Credits/units, credit hours
- Semester/term and academic year
- Prerequisites or co-requisites
- Course level (undergraduate/graduate)

### 2. Schedule and Time Arrangement
- Lecture days and times
- Lab/tutorial/recitation sessions (separate from lectures)
- Important dates: add/drop deadline, withdrawal deadline, holidays
- Exam dates: midterm(s), final exam date and time
- Weekly schedule overview

### 3. Teaching Content
- Course description and learning objectives
- Required textbooks and supplementary readings
- Weekly or module-by-module topic breakdown
- Key assignments, projects, papers with due dates
- Field trips, guest lectures, or special events

### 4. Grading Breakdown
- Grade components and their weights (assignments, exams, participation, projects, etc.)
- Grading scale (letter grade boundaries, percentage ranges)
- Late submission policy
- Extra credit opportunities (if any)
- Pass/fail or audit options

### 5. Other Important Notes
- Attendance policy
- Academic integrity / plagiarism policy
- Classroom etiquette and device policy
- Accommodation and accessibility statements
- Communication policy (email response time, preferred channels)
- Any course-specific rules or expectations

### 6. Special Attention / Risk Flags (特别关注 / 避坑提示)

This is the critical value-add of this skill. Proactively scan the syllabus for policies
and patterns that can unexpectedly cause a student to fail or struggle. Students often
skim syllabi and miss these. Flag them prominently with severity levels.

#### Severity Levels

Use these levels when flagging risks:
- **[CRITICAL]** — Can cause automatic failure or course drop (fail trigger, hard prerequisite)
- **[HIGH]** — Significant impact on grade or schedule (grade threshold, heavy workload collision)
- **[MEDIUM]** — Worth being aware of (hidden costs, tricky policies, time-consuming tasks)

#### Risk Categories to Scan For

**A. Attendance / Participation Fail Triggers (出勤挂科红线)**
Scan for hard attendance thresholds:
- "X or more absences = automatic F" or "X or more unexcused absences = failure"
- Look for exact numbers: "3 absences", "4 unexcused absences", "more than 2 classes missed"
- Chinese: "缺课X次取消考试资格", "缺勤达X次按不及格处理", "旷课X节取消考核资格"
- US: "accumulation of X unexcused absences will result in an F", "miss more than X classes = automatic failure"
- Also flag: "each absence after X deducts Y points from final grade"
- Note if late arrivals or early departures count toward the absence count

**B. Strict / Hard Prerequisites (严格前置要求)**
Scan for prerequisites that are enforced, not just recommended:
- "Must have completed X with grade C or better" or "grade of B- or above in Y"
- "Students who have not completed X will be administratively dropped"
- Chinese: "必须先修X课程", "未修X者不得选课", "需要X基础"
- Flag prerequisite chains: if this course is itself a prereq for other courses
- Check for co-requisites: courses that must be taken simultaneously
- Distinguish between "Recommended background" (advisory) vs "Prerequisite" (enforced)

**C. Workload Collision / Heavy Weeks (任务集中碰撞)**
Cross-reference the weekly schedule to find weeks where multiple deadlines, exams,
or large assignments converge:
- Weeks where a problem set, project milestone, and midterm all land
- Weeks right before or after breaks (Thanksgiving, Spring Break, 国庆, 五一)
- Reading Week that is actually a project work week
- Sequential deadlines with less than 48 hours between them
- Flag: "Week X has [list of items] — this is the heaviest week"
- Suggest advance preparation strategies for these collision weeks

**D. Grade Threshold Traps (评分门槛陷阱)**
Scan for conditional grading rules:
- "Must pass both exam and coursework components separately" (double-pass rule)
- "Must score at least X% on the final to pass the course regardless of total"
- "If you score below X% on any major assignment, you cannot get above a B-"
- Chinese: "期末考试不及格则总评不及格", "各项成绩均须达到XX分"
- UK/US: "must achieve a minimum of 40% on the final exam to pass the module", "must earn at least a C- on all major assignments"
- Flag curve policies: "only top X% get A", "grades are curved to a B- median"

**E. Late Work / Make-Up Traps (迟交补交陷阱)**
Scan for unusually strict late policies:
- "No late work accepted under any circumstances" / "late submissions receive a zero"
- "X% deduction per hour" (aggressive hourly penalties)
- "No make-up exams except for documented [very narrow list]"
- "Vacation travel is not an excused absence for exams"
- "Technical issues are not valid excuses"
- Chinese: "逾期不补", "迟交按零分处理", "不接受任何理由补交"
- Also flag generous policies positively: "two free late days", "lowest quiz dropped"

**F. Hidden Costs & Materials (隐藏成本与材料)**
- Required software licenses, lab fees, field trip costs
- Textbooks that are custom editions only available at the campus bookstore
- iClicker or similar response devices required (common in US large lectures)
- Online platform access codes (Pearson MyLab, McGraw-Hill Connect, WileyPlus)
- Printing or materials costs for studio/design courses
- Chinese: 需要购买指定实验器材/材料费

**G. Syllabus Quiz / Contract (大纲确认测验)**
- Some professors require a syllabus quiz in the first week (often graded or mandatory)
- Missing it can mean being dropped from the course
- Look for: "Syllabus Quiz", "Syllabus Acknowledgement", "Course Contract"
- Chinese: "大纲确认", "课程须知测试"

**H. Ungraded But Required (不计分但必须完成)**
- Items listed as "required" but not given a grade weight
- "All reading responses must be submitted to be eligible for a passing grade"
- "Attendance at [X events] is mandatory for course completion"
- "Peer review participation required regardless of grade weight"

**I. Group Work Risks (小组作业雷点)**
- Large group projects where your grade depends heavily on others
- "Peer evaluation may lower your individual grade"
- Mandatory group meetings outside class time
- "Free-rider policy" — group members can be voted out

#### Risk Flagging in Output

When presenting risks:
1. Only flag risks actually found in the syllabus — never fabricate
2. Group by severity level (CRITICAL first)
3. For each risk, cite the source (quote the specific passage or section)
4. If no major risks are found, explicitly state "未发现严重风险" (or "No critical risk flags identified" if outputting in English)
5. Place this section prominently BEFORE the action items, so the user sees it

## Workflow

### Step 1: Receive Input

Determine the input type:
- **File upload**: Read the file using the appropriate tool. For PDF, read directly.
  For DOCX, convert or extract text.
- **URL**: Fetch the web page content. If it leads to a downloadable file, download
  and read it.

### Step 2: Parse and Extract

Read through the syllabus content systematically. Look for section headers and
structural cues to identify the six information categories. Refer to
`references/syllabus_patterns.md` for common section header patterns and
risk indicator patterns across university systems worldwide.

Key parsing strategies:
- Look for numbered or bold section headers as category boundaries
- Recognize tables (especially for schedules and grading breakdowns)
- Identify dates in various formats (YYYY-MM-DD, MM/DD, "Week 1", etc.)
- Capture both explicit statements and infer implicit information

After completing the standard extraction, perform a dedicated **risk scan pass**:
re-read the syllabus specifically looking for the risk categories defined above
(Section 6). Cross-reference multiple sections — for example, cross-check the
weekly schedule against the assignment due dates to detect workload collision
weeks. Pay extra attention to:
- Numbered thresholds (absences, minimum scores, late day counts)
- All-caps or bolded policy statements (these often indicate enforced rules)
- Sections labeled "Important", "Note", "Warning", "注意", "重要"
- Fine print about prerequisites and enrollment conditions

### Step 3: Organize into Structured Output

Use the template in `assets/syllabus_summary_template.md` to structure the output.
Populate each section with extracted information, including the new special attention
section (Section 6 in the template).

**Output Language Rule (CRITICAL):**

Default to Chinese for all output text — section headers, field labels, descriptions,
risk narratives, action items. This is the primary output language.

Exceptions that MUST stay in the original language, never translated:
- Course names (e.g. "Design and Analysis of Algorithms")
- Course codes (e.g. "COMPSCI 308")
- Book titles (e.g. "Introduction to Algorithms")
- Personal names (e.g. "Mustafa MISIR")
- University/institution names (e.g. "Duke Kunshan University")
- Technical terms where the original is standard (e.g. "Divide and Conquer")
- Specific policy quotations from the syllabus

Language matching rule:
- If the user's conversation is in English → output entirely in English
- If the user's conversation is in Chinese → output in Chinese (default)
- The user's conversation language always overrides the default
- When in doubt about the user's preferred language, default to Chinese

Guidelines for the output:
- Use the exact course name and code from the syllabus
- Present dates in a clean, consistent format
- Display grading as a clear breakdown with percentages
- Flag items as `[未提及]` (or `[Not specified]` if outputting in English) when information is not found in the syllabus; use `[部分信息]` (EN: `[Partial]`) when information exists but is incomplete — see "Handling Incomplete Syllabi" below for the distinction
- Add a brief "Quick Look" summary box at the top with the most critical info
- For risk items, use severity tags matching the output language: [致命] / [高危] / [注意] in Chinese, [CRITICAL] / [HIGH] / [MEDIUM] in English
- Cite the specific passage or section for each flagged risk

### Step 4: Present the Summary

Output the completed structured summary. After the main summary, add a short section
with actionable suggestions:
- Key dates to add to calendar
- First upcoming deadline
- Items needing clarification (marked as `[未提及]`)

## Handling Incomplete Syllabi

When information is not fully present in the syllabus, use two distinct markers:

- **`[未提及]`** (EN: `[Not specified]`): The information is **completely absent**
  from the syllabus. No mention, no hint. Example: no grading breakdown at all.
- **`[部分信息]`** (EN: `[Partial]`): Some information is present but **incomplete**.
  Example: a reading list mentions "Chapters 1-5" without specifying the textbook.

For each marked item:
1. Apply the correct marker immediately after the field label
2. Note what information is missing
3. Suggest where the user might find this information (e.g., "Check the department website"
   or "Usually announced in the first class")

## Regional Adaptation

This skill works with syllabi from any university system worldwide. Adapt detection
strategies based on the syllabus language and format, not on assumed region.

### Detection Principles

**Language-based defaults:**
- English-language syllabi → expect semester-based systems, letter grades, LMS references
- Chinese-language syllabi → expect 平时/期末 splits, 百分制/五级制, WeChat groups
- Other languages → infer structure from section headers and grading patterns directly

**Context clues to identify the university system:**
- Letter grades (A/B/C/D/F) → likely US, Canada, UK, Australia, or international schools
- Percentage systems (百分制) or descriptive grades (优秀/良好) → likely China or East Asia
- Numbered scales (1.0-4.0, 0-20, 1-10) → identify the specific scale and map accordingly
- ECTS grades (A-E) → likely European
- "Module" instead of "course" → likely UK/Ireland
- "Subject" or "unit" → likely Australia/New Zealand

**Term structure adaptation:**
- Identify the total number of weeks from the schedule
- Detect holidays and breaks from the context (named, dated, or week-gap patterns)
- Adapt workload collision detection to the actual term length, not a fixed assumption

**Grading adaptation:**
- Extract grade component weights directly from the syllabus — never assume a split
- Present the grading scale exactly as it appears in the syllabus
- When the grading system is unfamiliar, describe it faithfully and note it as-is

**Holiday and deadline awareness:**
- Recognize named holidays in any language from the schedule
- Flag weeks immediately before/after any break as potential high-stress periods
- Note add/drop and withdrawal deadlines regardless of the naming convention used

## Resources

### scripts/generate_ics.py
Optional utility: converts a JSON array of course events into an ICS calendar file
(importable by Apple Calendar, Outlook, Google Calendar). Not part of the standard
workflow — only run if the user explicitly requests a calendar file.
Usage: `python scripts/generate_ics.py -i <events.json> -o <output.ics> [-t <timezone>]`
Works on any platform with Python 3 — generates an `.ics` file on disk.

### references/syllabus_patterns.md
Comprehensive reference library of section header patterns, grading structures,
terminology, and critical risk indicators for university syllabi worldwide.
Use this reference when:
- Encountering an unfamiliar syllabus format or section naming convention
- Having trouble identifying section boundaries
- Performing the risk scan pass — check patterns against the syllabus text
- Need examples of what a specific risk looks like in each region
The reference includes dedicated sections on all nine risk categories by region.

### assets/syllabus_summary_template.md
Markdown template for the structured output. Use as the base skeleton — populate
each section with extracted information. Read it once to understand the format,
then write the output following the same structure.
