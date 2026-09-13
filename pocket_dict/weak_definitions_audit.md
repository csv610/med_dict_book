# Weak Definitions Audit

Review date: 2026-09-12.

This audit records the initial weak-definition findings and the subsequent remediation. Existing uncommitted source edits were preserved.

## Executive summary

The initial scan found **161 confirmed boilerplate or materially context-free primary definitions**. A fresh independent pass found and corrected **175 additional generic or misclassified definitions** that were not caught by the original exact-template scan.

These findings should be treated as a rewrite queue, not automatic deletion candidates. Some headwords are valid medical terms but require term-specific definitions; others are consumer-facing or general-language titles that may need a vocabulary-policy decision.

| Finding | Count | Severity |
| --- | ---: | --- |
| Self-referential `concerns ...` template | 47 | High completeness defect |
| Generic medical/healthcare concept template | 68 | High completeness defect |
| Generic disease/symptom/clinical-finding template | 22 | High completeness defect |
| Generic protein/enzyme template | 9 | Moderate completeness defect |
| Generic anatomic template | 4 | Moderate completeness defect |
| Generic concept template | 3 | High completeness defect |
| Generic chemical/material template | 3 | Moderate completeness defect |
| Clinical-topic template | 2 | Moderate completeness defect |
| Clinical-term template | 2 | Moderate completeness defect |
| Generic body-structure template | 1 | High completeness defect |
| **Initial high-confidence findings** | **161** | |
| **Fresh generic-template findings** | **175** | |
| Earlier placeholder/context-free findings | 8 | Moderate to high; see `medical_accuracy_audit.md` |

Counts are by entry. The categories above do not overlap.

## Remediation status

All 161 initial exact-template findings and 175 fresh generic-template findings have been addressed through specific rewrites, redirects, merges, restoration of stronger definitions, or removal of duplicative entries. A repeat scan reports **0 remaining matches** for the audited boilerplate patterns.

## Complete inventory of new findings

The locations below refer to the current working tree. Each listed entry begins with the indicated boilerplate pattern and should be individually rewritten or reclassified.

### Self-referential placeholder — 47

- `chapters/med_terms_b.tex`: `Bee, Wasp, Hornet, Or Yellow Jacket Sting` (895); `Buying And Caring For Baby Bottles And Nipples` (4450)
- `chapters/med_terms_d.tex`: `Dysgammaglobulinemia` (3710)
- `chapters/med_terms_e.tex`: `Ear - Blocked At High Altitudes` (22); `Ear Emergencies` (41); `Ear Tag` (73); `Earlobe Creases` (115); `Endothelin` (1454); `Endotoxin` (1472); `Enlarged Liver` (1564); `Enzyme Markers` (1809); `Epipodophyllotoxin` (2121); `Epitope` (2172); `Epitope Mapping` (2174); `Epoxy Compounds` (2201); `Euchromatin` (2941); `Excessive Carrying Angle Of The Elbow` (3094); `Eyelid Bump` (3696); `Eyelid Drooping` (3702); `Eyelid Lift` (3708); `Eyelid Twitch` (3714); `Eyes - Bulging` (3718)
- `chapters/med_terms_f.tex`: `Facial Nerve Palsy Due To Birth Trauma` (52); `Fast Heart Rate - Tachycardia` (392); `Fecal Smear` (569); `Fingers That Change Color` (1299); `Flat Bones` (1452)
- `chapters/med_terms_g.tex`: `Gastroesophageal Reflux In Infants` (629); `Genetically Modified Organisms - GMOs` (1007)
- `chapters/med_terms_h.tex`: `Hearing Loss And Music` (774)
- `chapters/med_terms_i.tex`: `Immunoglobulin D` (479); `Immunoglobulin Idiotype` (488); `Immunoglobulin Isotype` (490)
- `chapters/med_terms_l.tex`: `Long Bones` (2162); `Low-Set Ears And Pinna Abnormalities` (2392); `Lower Esophageal Ring` (2399)
- `chapters/med_terms_m.tex`: `Melanoma Of The Eye` (1412); `Metabolic Neuropathies` (1899); `Minority Health` (2860)
- `chapters/med_terms_p.tex`: `Patchy Skin Color` (1030); `Peptide Biosynthesis` (1715); `Peptide Library` (1723); `Peptide Metabolism` (1725); `Peptide Transport` (1727); `Peptide Yy` (1729)
- `chapters/med_terms_r.tex`: `Radiologic Health` (266); `Rural Health` (2681)

### Generic medical/healthcare concept template — 68

- `chapters/med_terms_d.tex`: `Dietary Supplementation` (2003)
- `chapters/med_terms_f.tex`: `Facial Expression` (35); `Fasting` (399); `Fat Body` (419); `Fat Pad` (429); `Feeding Poor` (609); `Female` (630); `Female Phenotype` (666); `Femtogram` (719); `Femtoliter` (720); `Fetal Stage` (911); `Follicular Fluid` (1934); `Follicular Hyperkeratosis` (1935); `Food` (2002); `Food Consumption` (2026); `Food Safety` (2048); `Forelimb` (2181); `Fourth Finger` (2327); `Fucose` (2705)
- `chapters/med_terms_h.tex`: `Heart Failure In Children` (858); `Hepatic Fissure` (1642); `Hepatic Lamina` (1663); `Hepatitis A - Children` (1703); `Hepatitis B - Children` (1714); `High Blood Pressure In Infants - Hypertension` (2230); `Hind` (2316)
- `chapters/med_terms_k.tex`: `Keeping Your Medicines Organized` (94); `Keratoconjunctivitis` (137); `Keratosis` (186); `Keratosis Obturans` (189); `Ketotic Hypoglycemia` (264); `Kinetosome` (406); `Kneecap Dislocation` (552); `Knuckle Pad` (578)
- `chapters/med_terms_m.tex`: `Mouth Sores` (3617); `Mucopolysaccharidosis Type I` (3789); `Mucopolysaccharidosis Type II` (3790); `Mucopolysaccharidosis Type III` (3791); `Mucopolysaccharidosis Type IV` (3792); `Multiple Mononeuropathy` (3966); `Multiple System Atrophy - Cerebellar Subtype` (4000); `Multiple System Atrophy - Parkinsonian Type` (4001); `Myocarditis - Pediatric` (4505)
- `chapters/med_terms_n.tex`: `Nasal Passage` (156); `Nausea And Acupressure` (221); `Neck, Chronic Stiff` (288); `Negative-Strand RNA Virus` (362); `Nonagenarian` (1382); `NREM Sleep` (1597); `Nurse Assistant` (1689)
- `chapters/med_terms_u.tex`: `UDP-Glucuronosyltransferase` (21); `Umbilical Vein` (173); `Urinary Incontinence Products` (655); `Urine 24-Hour Volume` (701); `Urine Conductivity` (713); `Urine Drainage Bags` (720); `Uterine Adnexae` (864); `Uterine Bleeding` (875); `Uterine Cavity` (880); `Uterine Fistula` (899); `Uterine Fornix` (900)
- `chapters/med_terms_v.tex`: `Vaginal Bleeding Between Periods` (60); `Vaginal Cysts` (80); `Vincent Infection` (958)
- `chapters/med_terms_w.tex`: `Walking Abnormalities` (43)
- `chapters/med_terms_x.tex`: `X, Factor` (6)
- `chapters/med_terms_y.tex`: `Y-Linked Inheritance` (6); `YAG Laser Surgery` (12)

### Generic disease/symptom/clinical-finding template — 22

- `chapters/med_terms_d.tex`: `Diabetes And Kidney Disease` (1513); `Diabetic Hyperglycemic Hyperosmolar Syndrome` (1628)
- `chapters/med_terms_l.tex`: `Leg Pain` (830); `Lesch-Nyhan Syndrome` (1048); `Low Back Pain - Acute` (2284); `Low Back Pain - Chronic` (2285)
- `chapters/med_terms_p.tex`: `Pituitary Tumor` (3140); `Pneumocyte` (3631); `Pneumomediastinum` (3637); `Pneumothorax - Infants` (3659); `Polyhydramnios` (3878); `Pott'S Disease` (4658); `Psychosis` (6256)
- `chapters/med_terms_s.tex`: `Spinal Injury` (3262); `Sprue, Nontropical` (3525); `Stereotypic Movement Disorder` (3865); `Stiff Baby Syndrome` (3919); `Subclinical Disease` (4288); `Sunflower Syndrome` (4582); `Syndrome, Nervous Colon` (5057); `Syndrome, TAR` (5060)
- `chapters/med_terms_t.tex`: `Tumor Marker, NSE` (3252)

### Other exact generic templates — 24

- `chapters/med_terms_c.tex`: `Chalazion` (2895); `Chancroid` (2909); `Choroid` (3849) — generic concept; `Casein Kinase` (1641); `Catenin` (1789); `Cathepsin` (1798); `Cathepsin D` (1799); `Cathepsin H` (1800); `Cathepsin K` (1801); `Cathepsin L` (1802); `Cathepsins B` (1805); `Caveolins` (1888) — generic protein/enzyme; `Casein` (1639); `Catechin` (1743); `Cellulose` (2181) — generic chemical/material; `Caudal Vein` (1855); `Caudate Nucleus` (1856); `Cautery Device` (1886); `Caveola` (1887) — generic anatomic
- `chapters/med_terms_b.tex`: `Bleeding During Cancer Treatment` (2207); `Bleeding Into The Skin` (2225) — generic clinical topic
- `chapters/med_terms_d.tex`: `Dirt - Swallowing` (2444); `Drainpipe Cleaners` (3178) — generic clinical term; `Disseminated Sclerosis` (2636) — generic body-structure template

## Previously reported weak definitions

The earlier eight context-free entries remain in scope and are documented with individual rationale in `medical_accuracy_audit.md`: `Bombe`, `Event`, `Homophile`, `Low-Incision`, `Lyonnaise`, `Parentectomy`, `Puna`, and `Urocele`.

The same report also documents higher-impact terminology issues involving `Rabies (Hydrophobia)`, `Paget's Disease`, and `Hydrophobia`, plus source-integrity defects involving eight leading `+` signs.

## Methodology and limitations

- Parsed all primary `\\medterm` records in `chapters/med_terms_*.tex`; the current-tree count is **27,468**.
- Continued definitions across source lines until the next `\\medterm` or `\\synonyms` command.
- Matched exact boilerplate starts and self-referential constructions case-insensitively.
- Excluded reference-only redirects from the new count.
- The scan identifies strong rewrite candidates; it does not determine whether a headword should ultimately be retained, renamed, redirected, or removed.
- Line numbers must be refreshed after source edits.

## Validation

- Primary entry count: 27,468.
- Initial high-confidence boilerplate/context-free findings: 161.
- Fresh generic-template and misclassification findings: 175.
- Existing report findings cross-referenced: 8.
- Dictionary source entries changed during remediation: yes; changes are limited to the identified weak entries.
