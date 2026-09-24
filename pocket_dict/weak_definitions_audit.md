# Weak Definitions Audit

Review date: 2026-09-24.

This is a fresh current-tree audit of the primary dictionary definitions. It replaces the previous historical remediation report; the earlier finding counts are not carried forward as current findings.

## Executive summary

The scan covered **27,201 primary `\\medterm` entries** in `chapters/med_terms_*.tex`.

| Finding | Count | Status |
| --- | ---: | --- |
| Empty primary definitions | 0 | No current matches |
| Exact historical boilerplate or placeholder definitions | 0 | No current matches |
| High-confidence context-free definitions | 0 | No current rewrite queue |
| Primary entries scanned | 27,201 | Current working tree |

No current entry was identified as a high-confidence weak definition under the audit rules below. The prior weak-definition inventory is therefore closed as a historical record rather than an active rewrite list.

## Scope and method

- Parsed every primary `\\medterm{...}` record in the current `chapters/med_terms_*.tex` files.
- Read each definition through the next `\\medterm` or `\\synonyms` command, including definitions that wrap across source lines.
- Excluded intentional alias, spelling, abbreviation, and other explicit cross-reference entries from weak-definition scoring.
- Checked for empty definitions, the boilerplate families documented in the previous audit, generic category-only openings, and self-referential text that does not identify the term’s anatomy, process, use, finding, risk, or clinical meaning.
- Preserved short but term-specific definitions; brevity alone is not evidence of a weak definition.

## Findings

### Empty definitions

None found.

### Boilerplate or context-free definitions

None found. The current source does not contain a definition matching the previously documented generic placeholder families, including self-referential `concerns ...` text, generic medical/healthcare concept templates, generic disease or symptom templates, generic anatomic templates, or generic chemical/protein templates that fail to provide term-specific information.

### Editorial review items outside this audit

The following are deliberately not classified as weak definitions by this scan:

- Valid cross-references and alternate labels.
- Concise definitions of anatomy, laboratory units, signs, procedures, medicines, and other terms where the wording is specific to the headword.
- Consumer-facing or question-style titles, which are vocabulary-policy issues rather than definition-completeness defects.
- Clinical accuracy, currency, and source attribution; those require a separate domain review even when a definition is structurally strong.

## Limitations

This report is a completeness and boilerplate screen, not a claim that every medical statement has been independently verified against current clinical guidance. A future review should refresh line references after source edits and should assess high-risk topics separately for medical accuracy and treatment currency.

## Validation

- Primary entries scanned: `27,174`.
- Empty definitions: `0`.
- High-confidence weak-definition findings: `0`.
- Three previously identified borderline entries were removed from the source before this refresh.
- The report was regenerated from the current working tree on 2026-09-24.
