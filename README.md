# Medical Dictionary by Specialty

A comprehensive medical dictionary organised by 35 medical specialties, not alphabetically. ~5,600+ entries across 772 pages, built with LaTeX.

![Frontpage](frontpage.png)

## Structure

Each chapter covers one specialty:

| # | Specialty | # | Specialty |
|---|-----------|---|-----------|
| 1 | Anatomy | 19 | Microbiology |
| 2 | Anesthesiology | 20 | Nephrology |
| 3 | Biochemistry | 21 | Neurology |
| 4 | Cardiology | 22 | Obstetrics & Gynecology |
| 5 | Dentistry | 23 | Oncology |
| 6 | Dermatology | 24 | Ophthalmology |
| 7 | Emergency Medicine | 25 | Orthopedics |
| 8 | Endocrinology | 26 | Pathology |
| 9 | ENT | 27 | Pediatrics |
| 10 | Gastroenterology | 28 | Pharmacology |
| 11 | General | 29 | Physiology |
| 12 | Genetics | 30 | Psychiatry |
| 13 | Hematology | 31 | Public Health |
| 14 | Immunology | 32 | Pulmonology |
| 15 | Infectious Disease | 33 | Radiology |
| 16 | Medical Implants | 34 | Rheumatology |
| 17 | Medical Instruments | 35 | Surgery |
| 18 | Medical Tests |

## Build

```bash
pdflatex medical_dictionary.tex
makeindex medical_dictionary.idx
pdflatex medical_dictionary.tex
```

## Author

Chaman Singh Verma
