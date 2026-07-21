# Medical Dictionary by Specialty

A comprehensive medical dictionary organised by 31 medical specialties, not alphabetically. **5,137 entries** across **781 pages**, built with LaTeX.

![Frontpage](frontpage.png)

## Structure

| # | Specialty | Entries | # | Specialty | Entries |
|---|-----------|---:|---|-----------|---:|
| 1 | Anatomy | 290 | 17 | Microbiology | 152 |
| 2 | Anesthesiology | 110 | 18 | Nephrology | 152 |
| 3 | Biochemistry | 34 | 19 | Neurology | 179 |
| 4 | Cardiology | 286 | 20 | Obstetrics & Gynecology | 432 |
| 5 | Dermatology | 172 | 21 | Oncology | 82 |
| 6 | Emergency Medicine | 37 | 22 | Ophthalmology | 126 |
| 7 | Endocrinology | 193 | 23 | Orthopedics | 126 |
| 8 | ENT | 123 | 24 | Pathology | 134 |
| 9 | Gastroenterology | 275 | 25 | Pediatrics | 221 |
| 10 | General | 78 | 26 | Pharmacology | 302 |
| 11 | Genetics | 28 | 27 | Physiology | 98 |
| 12 | Hematology | 96 | 28 | Psychiatry | 182 |
| 13 | Immunology | 56 | 29 | Public Health | 83 |
| 14 | Infectious Disease | 163 | 30 | Pulmonology | 300 |
| 15 | Medical Implants^ | 39 | 31 | Radiology | 64 |
| 16 | Medical Instruments^ | 81 | 32 | Rheumatology | 58 |
| 17 | Medical Tests^ | 184 | 33 | Surgery | 115 |
| 18 | Dentistry^ | 51 | | **Total** | **5,137** |

^ Not yet included in the main build — candidate chapters.

## Build

```bash
pdflatex medical_dictionary.tex
makeindex medical_dictionary.idx
pdflatex medical_dictionary.tex
```

## Author

Chaman Singh Verma
