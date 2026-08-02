# Medical Dictionary by Specialty — Quality Review & Grading Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Comprehensive quality assessment of all 43 specialty chapters, grading each on completeness, accuracy, formatting, and clinical utility.

**Architecture:** The dictionary uses a chapter-per-specialty LaTeX structure with 5,507 entries across 968 pages. Each entry uses the `\medterm{}` command with bold red terms and automatic indexing.

**Tech Stack:** LaTeX (book class, twocolumn), pdflatex + makeindex, 43 chapter files in `chapters/`.

---

## Current Context / Assumptions

- **Project Status:** 5,507 entries across 43 specialties (per README)
- **Recent Work:** 7 under-populated chapters expanded to 50+ entries each (commit 6b3ae09)
- **Format:** Standardized `\medterm{Term}-- Definition` pattern throughout
- **Build:** 3-pass pdflatex + makeindex compiles successfully (medical_dictionary.pdf exists)
- **Structure:** Master `medical_dictionary.tex` includes all chapters in fixed order

---

## Grading Criteria (per Specialty)

| Criterion | Weight | Description |
|-----------|--------|-------------|
| **Completeness** | 30% | Entry count vs. specialty scope; coverage of major conditions |
| **Clinical Accuracy** | 30% | Correct pathophysiology, current guidelines, no outdated info |
| **Formatting Consistency** | 20% | Proper `\medterm{}--` syntax, section organization, cross-refs |
| **Clinical Utility** | 20% | Practical value for clinicians/students; actionable details |

**Grade Scale:** A (90-100), B (80-89), C (70-79), D (60-69), F (<60)

---

## Proposed Assessment Approach

### Phase 1: Automated Metrics Collection (Tasks 1-3)
- Count entries per chapter programmatically
- Validate LaTeX syntax (unclosed braces, double backslashes in tables)
- Check for duplicate entries across chapters

### Phase 2: Content Review by Domain (Tasks 4-12)
- Sample 10-15 entries per chapter for accuracy
- Verify section organization (pathophysiology, diagnosis, treatment)
- Check cross-references (See X, Also known as Y)

### Phase 3: Specialty Grading & Report (Tasks 13-15)
- Assign grades per specialty using rubric
- Identify top/bottom chapters
- Generate improvement recommendations

---

## Step-by-Step Plan

### Task 1: Count Entries Per Chapter
**Objective:** Get exact entry counts for all 43 chapters to verify README stats

**Files:**
- Read: `chapters/*.tex` (all 43 files)
- Script: Count `\medterm{` occurrences per file

**Step 1: Write counting script**
```python
# Count \medterm{ occurrences in each chapter
import subprocess, glob, os
for f in sorted(glob.glob('chapters/*.tex')):
    count = subprocess.run(['grep', '-c', r'\\medterm{', f], capture_output=True, text=True)
    print(f"{os.path.basename(f)}: {count.stdout.strip()}")
```

**Step 2: Run and verify against README table**

**Step 3: Commit**
```bash
git add .hermes/plans/2026-07-31_153000-quality-review-medical-dictionary.md
git commit -m "plan: add entry counting methodology"
```

---

### Task 2: Validate LaTeX Syntax & Formatting
**Objective:** Detect common LaTeX errors that break compilation or produce malformed output

**Files:**
- Check: `chapters/*.tex` for syntax issues
- Reference: `scripts/repair_tables.py` (existing table double-backslash fix)

**Step 1: Check for unclosed braces**
```bash
# Python script to scan for brace balance in \medterm{} commands
```

**Step 2: Check for double-backslash corruption in tables**
```bash
grep -n '\\\\textbf\\|\\\\textit\\|\\\\emph' chapters/*.tex
```

**Step 3: Check for malformed section headers (`>` instead of `}`)**
```bash
grep -n 'section{' chapters/*.tex | grep '>'
```

**Step 4: Verify consistent `\medterm{Term}-- Definition` format**
```bash
# Check for missing em-dash or extra spaces
grep -n '\\medterm{[^}]*}[^—-]' chapters/*.tex
```

---

### Task 3: Cross-Chapter Duplicate Detection
**Objective:** Find terms defined in multiple chapters (should redirect to canonical chapter)

**Files:**
- All `chapters/*.tex`
- Reference: "Canonical home for cross-chapter duplicates" (memory)

**Step 1: Extract all term names**
```bash
grep -ho '\\medterm{[^}]*}' chapters/*.tex | sed 's/\\medterm{\(.*\)}--.*/\1/' | sort
```

**Step 2: Find duplicates**
```bash
# Count occurrences of each term
```

**Step 3: Verify cross-reference format (should be `\medterm{Term}-- See Other Term.`)**

---

### Task 4: Cardiology Chapter Review (Sample)
**Objective:** Deep-dive review of largest chapter (280 entries per README)

**Files:**
- Read: `chapters/cardiology.tex` (already sampled - 576 lines)

**Step 1: Verify section structure** — has sections: Ischemic Heart Disease, Heart Failure, Arrhythmias

**Step 2: Sample 15 entries for accuracy**
- Check: Acute Coronary Syndrome, Heart Failure types, Atrial Fibrillation, etc.
- Verify: Current guidelines (ACC/AHA), drug names, thresholds

**Step 3: Check formatting consistency**
- All entries use `\medterm{}--` ?
- Index entries generated?
- Cross-refs (See X) present?

**Step 4: Grade Cardiology** (expected: A- to A)

---

### Task 5: Neurology Chapter Review
**Objective:** Review 2nd large chapter (169 entries)

**Files:**
- Read: `chapters/neurology.tex` (sampled - 348 lines)

**Step 1: Verify sections** — Cerebrovascular, Movement Disorders, Neuromuscular, etc.

**Step 2: Sample entries** — Stroke, ALS, MS, Epilepsy, Headache

**Step 3: Check for outdated terminology** (e.g., "CVA" vs "Stroke", "Grand Mal" vs "Tonic-Clonic")

**Step 4: Grade Neurology**

---

### Task 6: Gastroenterology Chapter Review
**Objective:** Review 3rd large chapter (276 entries)

**Files:**
- Read: `chapters/gastroenterology.tex` (sampled - 568 lines)

**Step 1: Sections** — Esophageal/Gastric, Intestinal/Colorectal, Hepatobiliary, Pancreatic

**Step 2: Sample entries** — IBD, GERD, Cirrhosis, Pancreatitis, Colorectal Ca screening

**Step 3: Verify endoscopic/therapeutic details are current**

**Step 4: Grade Gastroenterology**

---

### Task 7: Oncology Chapter Review
**Objective:** Review chapter with 91 entries (smaller but high-stakes)

**Files:**
- Read: `chapters/oncology.tex` (fully read - 183 lines)

**Step 1: Check staging systems** — TNM 8th ed, FIGO, Ann Arbor current?

**Step 2: Verify targeted therapies** — EGFR, ALK, PD-L1, PARP inhibitors current?

**Step 3: Check immunotherapy adverse events section**

**Step 4: Grade Oncology** (critical for accuracy)

---

### Task 8: Endocrinology Chapter Review
**Objective:** Review 197 entries

**Files:**
- Read: `chapters/endocrinology.tex` (sampled - 398 lines)

**Step 1: Diabetes section completeness** — T1, T2, GDM, complications, meds, tech (CGM, pumps)

**Step 2: Thyroid** — Hypo/hyper, nodules, cancer, pregnancy

**Step 3: Adrenal/Pituitary** — Cushing, Addison, Acromegaly, prolactinoma

**Step 4: Grade Endocrinology**

---

### Task 9: Hematology Chapter Review
**Objective:** Review 109 entries

**Files:**
- Read: `chapters/hematology.tex` (fully read - 224 lines)

**Step 1: Leukemia/lymphoma classifications current** — WHO 2022, ICC?

**Step 2: Coagulation** — DOACs, factor deficiencies, TTP/HUS/DIC

**Step 3: Transfusion thresholds** — Restrictive vs liberal (TRICC, etc.)

**Step 4: Grade Hematology**

---

### Task 10: Dermatology Chapter Review
**Objective:** Review 179 entries

**Files:**
- Read: `chapters/dermatology.tex` (sampled - 359 lines)

**Step 1: Skin cancer** — BCC, SCC, Melanoma staging/treatment current

**Step 2: Inflammatory** — Psoriasis biologics (IL-17/23, JAK), Atopic (JAK, dupilumab)

**Step 3: Infections** — Antifungal resistance, STI cutaneous manifestations

**Step 4: Grade Dermatology**

---

### Task 11: Pediatrics Chapter Review
**Objective:** Review 222 entries

**Files:**
- Read: `chapters/pediatrics.tex` (sampled - 446 lines)

**Step 1: Neonatal** — Sepsis, Jaundice, Respiratory distress, Congenital anomalies

**Step 2: Developmental/Behavioral** — Autism, ADHD, Milestones

**Step 3: Vaccines** — Current schedule (COVID, RSV, MenB updates)

**Step 4: Grade Pediatrics**

---

### Task 12: Psychiatry Chapter Review
**Objective:** Review 186 entries

**Files:**
- Read: `chapters/psychiatry.tex` (sampled - 373 lines)

**Step 1: DSM-5-TR alignment** — Terminology, criteria updates

**Step 2: Psychopharmacology** — Current guidelines (APA, NICE), side effect profiles

**Step 3: Therapy modalities** — CBT, DBT, IPT, EMDR evidence base

**Step 4: Grade Psychiatry**

---

### Task 13: Rheumatology & Remaining Specialties Quick Review
**Objective:** Review smaller chapters (Rheumatology 60, Immunology 66, etc.)

**Files:**
- Read: `chapters/rheumatology.tex` (fully read - 122 lines)
- Quick scan: `chapters/immunology.tex`, `chapters/infectious_disease.tex`, etc.

**Step 1: Rheumatology** — Classification criteria (ACR/EULAR 2010 RA, 2019 SLE), biologics/JAK current

**Step 2: Sample 3-5 entries per remaining chapter**

**Step 3: Flag any chapters <30 entries for expansion**

---

### Task 14: Compile Grades & Generate Report
**Objective:** Produce final quality report with grades and recommendations

**Files:**
- Create: `.hermes/reports/quality-report-2026-07-31.md`

**Report Structure:**
```
# Medical Dictionary Quality Report

## Summary
- Total entries: 5,507 (verified)
- Chapters graded: 43
- Average grade: X

## Per-Specialty Grades
| Specialty | Entries | Completeness | Accuracy | Format | Utility | Grade |
|-----------|---------|--------------|----------|--------|---------|-------|
| Cardiology | 280 | 95 | 92 | 90 | 95 | A- |
...

## Top 5 Chapters
1. ...
2. ...

## Bottom 5 Chapters (Need Expansion)
1. ...
2. ...

## Critical Issues Found
- Duplicate entries: X terms in Y chapters
- LaTeX syntax errors: Z files
- Outdated guidelines: List

## Recommendations
1. Expand chapters X, Y, Z to 50+ entries
2. Fix LaTeX issues in files A, B, C
3. Update outdated content in specialties P, Q, R
4. Standardize cross-reference format
```

---

### Task 15: Create Improvement Tracking Issues
**Objective:** Convert recommendations into actionable GitHub issues or TODO list

**Files:**
- Create: `.hermes/todo/quality-improvements.md`

**Format:**
```
## Immediate (LaTeX fixes)
- [ ] Fix double-backslash in cardiology.tex:45
- [ ] Fix unclosed brace in neurology.tex:123

## Short-term (Content updates)
- [ ] Update Oncology TNM to 8th edition
- [ ] Add JAK inhibitors to Dermatology psoriasis section
- [ ] Update Pediatrics vaccine schedule

## Medium-term (Chapter expansion)
- [ ] Expand Immunology (66→80 entries)
- [ ] Expand Toxicology (50→70 entries)
- [ ] Expand Vascular Surgery (51→70 entries)

## Ongoing
- [ ] Quarterly guideline review for Cardiology, Oncology, Hematology
- [ ] Annual cross-chapter duplicate audit
```

---

## Verification Steps

After each review task:
1. **Run build** to ensure no regressions: `pdflatex medical_dictionary.tex && makeindex medical_dictionary.idx && pdflatex medical_dictionary.tex && pdflatex medical_dictionary.tex`
2. **Check PDF output** for visual issues (overfull hbox, missing index entries)
3. **Verify index** contains all reviewed terms

---

## Risks & Tradeoffs

| Risk | Mitigation |
|------|------------|
| Subjective grading | Use rubric with specific criteria; document evidence for each grade |
| Time per chapter (20-30 min) | Batch similar specialties; use sampling not full read |
| Missing subtle inaccuracies | Focus on high-impact areas: drug doses, staging, guidelines |
| LaTeX errors silent with `-interaction=nonstopmode` | Always compile without flags for review |

---

## Open Questions

1. **Duplicate policy:** Should "Heart Attack" redirect to "Myocardial Infarction" or both have full entries?
2. **Entry length:** Target word count per entry? (Current: ~150-300 words)
3. **References:** Add citation keys (e.g., `[ACC/AHA 2023]`) for verifiability?
4. **Student Guide:** Create companion PDF with only "must-know" entries per specialty?

---

## Execution Handoff

**Plan complete and saved.** Ready to execute using subagent-driven-development — I'll dispatch a fresh subagent per task with two-stage review (spec compliance then code quality). Shall I proceed with Task 1 (entry counting)?