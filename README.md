# Medical Dictionary by Specialty

A comprehensive medical dictionary organised by 43 medical specialties, not alphabetically. **5,507 entries** across **968 pages**, built with LaTeX.

![Frontpage](frontpage.png)

## Structure

| # | Specialty | Entries | # | Specialty | Entries |
|---|-----------|---:|---|-----------|---:|
| 1 | Anatomy | 281 | 23 | Nephrology | 141 |
| 2 | Anesthesiology | 107 | 24 | Neurology | 169 |
| 3 | Biochemistry | 44 | 25 | Nuclear Medicine | 50 |
| 4 | Cardiology | 280 | 26 | Obstetrics & Gynecology | 436 |
| 5 | Clinical Nutrition | 52 | 27 | Oncology | 91 |
| 6 | Dentistry | 51 | 28 | Ophthalmology | 131 |
| 7 | Dermatology | 179 | 29 | Orthopedics | 126 |
| 8 | ENT | 123 | 30 | Pathology | 136 |
| 9 | Emergency Medicine | 44 | 31 | Pediatrics | 222 |
| 10 | Endocrinology | 197 | 32 | Pharmacology | 310 |
| 11 | Forensic Medicine | 52 | 33 | Physiology | 101 |
| 12 | Gastroenterology | 276 | 34 | Psychiatry | 186 |
| 13 | General | 4 | 35 | Public Health | 86 |
| 14 | Genetics | 43 | 36 | Pulmonology | 299 |
| 15 | Geriatrics | 51 | 37 | Radiology | 69 |
| 16 | Hematology | 109 | 38 | Rehabilitation | 50 |
| 17 | Immunology | 66 | 39 | Rheumatology | 60 |
| 18 | Infectious Disease | 166 | 40 | Surgery | 103 |
| 19 | Medical Implants | 38 | 41 | Toxicology | 50 |
| 20 | Medical Instruments | 82 | 42 | Urology | 59 |
| 21 | Medical Tests | 184 | 43 | Vascular Surgery | 51 |
| 22 | Microbiology | 152 | | **Total** | **5,507** |

## Build

```bash
pdflatex medical_dictionary.tex
makeindex medical_dictionary.idx
pdflatex medical_dictionary.tex
```

## Author

Chaman Singh Verma
