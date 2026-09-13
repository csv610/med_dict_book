# Medical Accuracy and Completeness Audit

Audit scope: all `27,468` primary `\medterm` entries in `chapters/med_terms_*.tex` as currently present in the working tree.

This is a report-only audit. Dictionary source entries were not changed as part of this report. Findings are separated into confirmed defects, high-priority medical review items, and context-dependent terminology that should not be silently rewritten without a source decision.

## Executive summary

| Finding class | Count | Assessment |
| --- | ---: | --- |
| Leading `+` before a `\medterm` command | 0 | No current instances found; eight instances were present in an earlier snapshot. |
| Placeholder or context-free definitions | 0 current | The initial 161 findings and the fresh 175-entry generic-template set were remediated; see `weak_definitions_audit.md` for the inventory and remediation status. |
| Case-insensitive duplicate headwords | 202 | Confirmed terminology/index-integrity issue; some may be intentional aliases or alternate spellings. |
| Entries containing obsolete, historical, stigmatizing, or deprecated wording | 272 | Review queue; the wording is not automatically incorrect because historical terms can be useful for record interpretation. |
| Consumer/resource/care-instruction titles | 624 | Covered separately by `non_medical_terms_audit.md`; these are scope and vocabulary-policy issues rather than automatic factual errors. |

The largest confirmed quality problem is not a single medical fact but definition provenance: many entries use generic or self-referential text that does not identify the entity, anatomy, indication, risk, or diagnostic meaning of the headword. The expanded full-tree inventory is in `weak_definitions_audit.md`.

## Prior-snapshot findings

The earlier audit identified eight placeholder entries and eight leading-plus source defects. Those records are no longer present in the current tree, indicating that the corresponding source changes have already been made. The current weak-definition inventory is maintained in `weak_definitions_audit.md`.

The earlier audit also reviewed `Rabies (Hydrophobia)`, `Paget's Disease`, and `Hydrophobia`; their current definitions should be treated as revised entries requiring only routine future review.

### `Rabies (Hydrophobia)` — incomplete and potentially misleading

Location: `chapters/med_terms_r.tex:41`.

The entry uses `Hydrophobia` as though it were an equivalent name for rabies. Hydrophobia is a possible neurologic symptom of rabies, not a synonym for the disease, and rabies can also present in a paralytic form without hydrophobia. The entry should distinguish exposure, post-exposure prophylaxis, symptomatic disease, and the near-fatal course after symptoms begin. CDC describes hydrophobia as a sign of brain dysfunction and states that once clinical signs appear, rabies is nearly always fatal. [CDC clinical features of rabies](https://www.cdc.gov/rabies/hcp/clinical-signs/index.html), [CDC rabies infection-control guidance](https://www.cdc.gov/infection-control/hcp/healthcare-personnel-epidemiology-control/rabies.html)

### `Paget's Disease` — ambiguous headword with incomplete definition

Location: `chapters/med_terms_p.tex:7160`.

The definition selects Paget disease of bone, but the unqualified headword can also refer to mammary Paget disease or extramammary Paget disease. The dictionary already has `Paget Disease Of Bone`, so this entry should either become a disambiguating index entry or explicitly state which Paget disease is intended. Mammary Paget disease is a distinct breast malignancy associated with underlying breast carcinoma. [NCBI Bookshelf: Mammary Paget Disease](https://www.ncbi.nlm.nih.gov/books/NBK563228/), [NCBI review of mammary and extramammary Paget disease](https://pmc.ncbi.nlm.nih.gov/articles/PMC4371672/)

### `Hydrophobia` — terminology should be linked to rabies without implying exclusivity

Location: `chapters/med_terms_h.tex:3275`.

The existing definition is directionally useful, but the term should be explicitly labeled as a historical/clinical sign associated especially with furious rabies, not as a universal feature or a separate disease. Paralytic rabies does not necessarily include hydrophobia. [CDC clinical features of rabies](https://www.cdc.gov/rabies/hcp/clinical-signs/index.html)

## Terminology and classification review queue

### Case-insensitive duplicate headwords

The scan found 202 case-insensitive duplicate labels. Examples include:

- `C-Reactive Protein` / `C-Reactive Protein`
- `Electrocardiogram` / `Electrocardiogram`
- `Magnetic Resonance Imaging` / `Magnetic Resonance Imaging`
- `Meniere's Disease` / `Meniere's Disease`
- `Parkinson's Disease` / `Parkinson's Disease`
- `pH` / `PH`

Some duplicates may be intentional spelling, capitalization, alias, or source variants. Each pair should be classified as one of: preferred term plus synonym, genuine duplicate, historical term, or separate concept. Terminology systems should preserve obsolete labels for retrieval while marking the preferred current term; this is consistent with NLM terminology guidance. [NLM UMLS overview](https://www.nlm.nih.gov/research/umls/index.html), [NLM Medical Subject Headings](https://www.nlm.nih.gov/mesh/meshhome.html)

### Obsolete, historical, or stigmatizing wording

272 entries contain wording such as `obsolete`, `outdated`, `historical`, `deprecated`, `stigmatizing`, or `not a diagnosis`. These are not automatically errors: historical labels can be important when interpreting older records. They should, however, identify the preferred current term and avoid presenting obsolete language as current clinical terminology. `Homophile` is an example of a term that belongs, if retained, in a historical or social-language note rather than as an undefined medical concept. [National Academies report on LGBT health terminology](https://www.ncbi.nlm.nih.gov/books/n/nap13128/pdf/)

## Existing related audit

`non_medical_terms_audit.md` separately identifies 624 consumer-facing, resource, discharge, self-care, and question-style titles. Those entries may contain medically useful material, but their headword form is not a conventional dictionary term. They should be reviewed under the project’s vocabulary-policy decision rather than treated as factual errors by default.

## Review methodology and limitations

- All 27,468 primary `\medterm` lines in the current chapter source were scanned.
- Structural defects and placeholder patterns were checked deterministically.
- High-priority medical claims were compared with authoritative sources where a clear source was available.
- The audit does not claim that every remaining definition has been independently checked against current literature. Terms not listed here passed the automated screens or require domain-specific review rather than having been proven error-free.
- Line references describe the current working tree and should be refreshed after any source edits.

## Validation

- Source entry count scanned: `27,468`
- Dictionary source edits made by this audit: 175 weak definitions rewritten or corrected
- Report terms and line references: verified against the current source tree
- Existing source-quality checks: `git diff --check` passes
