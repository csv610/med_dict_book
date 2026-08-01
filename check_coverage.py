#!/usr/bin/env python3
"""Check which terms from the user's list exist in the MedDict."""
import re, os, sys

CHAPTER_DIR = 'chapters'

# Build a set of all terms in the dictionary
all_terms = set()
for f in os.listdir(CHAPTER_DIR):
    if not f.endswith('.tex'): continue
    with open(os.path.join(CHAPTER_DIR, f)) as fp:
        content = fp.read()
    for term in re.findall(r'\\medterm\{([^}]+?)\}', content):
        all_terms.add(term.strip().lower())

# User's requested terms (grouped by category)
REQUESTED = [
    # 1. Position & Planes
    ("Anatomical Position", "1. Position & Planes"),
    ("Anatomical Planes", "1. Position & Planes"),
    ("Sagittal Plane", "1. Position & Planes"),
    ("Coronal Plane", "1. Position & Planes"),
    ("Transverse Plane", "1. Position & Planes"),
    ("Oblique Plane", "1. Position & Planes"),
    ("Anatomical Axis", "1. Position & Planes"),
    ("Median Plane", "1. Position & Planes"),
    ("Midclavicular Line", "1. Position & Planes"),
    ("Midaxillary Line", "1. Position & Planes"),
    # 2. Directional Terms
    ("Anterior", "2. Directional Terms"),
    ("Posterior", "2. Directional Terms"),
    ("Superior", "2. Directional Terms"),
    ("Inferior", "2. Directional Terms"),
    ("Medial", "2. Directional Terms"),
    ("Lateral", "2. Directional Terms"),
    ("Proximal", "2. Directional Terms"),
    ("Distal", "2. Directional Terms"),
    ("Superficial", "2. Directional Terms"),
    ("Deep", "2. Directional Terms"),
    ("Central", "2. Directional Terms"),
    ("Peripheral", "2. Directional Terms"),
    ("Ipsilateral", "2. Directional Terms"),
    ("Contralateral", "2. Directional Terms"),
    ("Rostral", "2. Directional Terms"),
    ("Caudal", "2. Directional Terms"),
    ("Ventral", "2. Directional Terms"),
    ("Dorsal", "2. Directional Terms"),
    # 3. Tissue-Level
    ("Tissue", "3. Tissue-Level"),
    ("Organ", "3. Tissue-Level"),
    ("Organ System", "3. Tissue-Level"),
    ("Cell", "3. Tissue-Level"),
    ("Extracellular Matrix", "3. Tissue-Level"),
    ("Basement Membrane", "3. Tissue-Level"),
    ("Connective Tissue", "3. Tissue-Level"),
    ("Epithelial Tissue", "3. Tissue-Level"),
    ("Muscle Tissue", "3. Tissue-Level"),
    ("Nervous Tissue", "3. Tissue-Level"),
    # 4. Body Cavities
    ("Cranial Cavity", "4. Body Cavities"),
    ("Vertebral Canal", "4. Body Cavities"),
    ("Thoracic Cavity", "4. Body Cavities"),
    ("Pleural Cavity", "4. Body Cavities"),
    ("Pericardial Cavity", "4. Body Cavities"),
    ("Mediastinum", "4. Body Cavities"),
    ("Abdominal Cavity", "4. Body Cavities"),
    ("Pelvic Cavity", "4. Body Cavities"),
    # 5. Nervous System
    ("Neuron", "5. Nervous System"),
    ("Axon", "5. Nervous System"),
    ("Dendrite", "5. Nervous System"),
    ("Synapse", "5. Nervous System"),
    ("Myelin", "5. Nervous System"),
    ("White Matter", "5. Nervous System"),
    ("Gray Matter", "5. Nervous System"),
    ("Ganglion", "5. Nervous System"),
    ("Nucleus", "5. Nervous System"),
    ("Plexus", "5. Nervous System"),
    # 12. Skull & CNS
    ("Cerebrum", "12. Skull & CNS"),
    ("Cerebellum", "12. Skull & CNS"),
    ("Brainstem", "12. Skull & CNS"),
    ("Midbrain", "12. Skull & CNS"),
    ("Pons", "12. Skull & CNS"),
    ("Medulla Oblongata", "12. Skull & CNS"),
    ("Spinal Cord", "12. Skull & CNS"),
    ("Meninges", "12. Skull & CNS"),
    ("Dura Mater", "12. Skull & CNS"),
    ("Arachnoid Mater", "12. Skull & CNS"),
    ("Pia Mater", "12. Skull & CNS"),
    ("Cerebrospinal Fluid", "12. Skull & CNS"),
    # 13. Cardiovascular
    ("Heart", "13. Cardiovascular"),
    ("Atrium", "13. Cardiovascular"),
    ("Ventricle", "13. Cardiovascular"),
    ("Coronary Artery", "13. Cardiovascular"),
    ("Coronary Sinus", "13. Cardiovascular"),
    ("Aorta", "13. Cardiovascular"),
    ("Pulmonary Artery", "13. Cardiovascular"),
    ("Pulmonary Vein", "13. Cardiovascular"),
    ("Superior Vena Cava", "13. Cardiovascular"),
    ("Inferior Vena Cava", "13. Cardiovascular"),
    # 14. Respiratory
    ("Nose", "14. Respiratory"),
    ("Nasal Cavity", "14. Respiratory"),
    ("Pharynx", "14. Respiratory"),
    ("Larynx", "14. Respiratory"),
    ("Trachea", "14. Respiratory"),
    ("Bronchus", "14. Respiratory"),
    ("Bronchiole", "14. Respiratory"),
    ("Alveolus", "14. Respiratory"),
    ("Lung", "14. Respiratory"),
    ("Pleura", "14. Respiratory"),
    # 15. Digestive
    ("Mouth", "15. Digestive"),
    ("Tongue", "15. Digestive"),
    ("Teeth", "15. Digestive"),
    ("Salivary Gland", "15. Digestive"),
    ("Esophagus", "15. Digestive"),
    ("Stomach", "15. Digestive"),
    ("Duodenum", "15. Digestive"),
    ("Jejunum", "15. Digestive"),
    ("Ileum", "15. Digestive"),
    ("Cecum", "15. Digestive"),
    ("Appendix", "15. Digestive"),
    ("Colon", "15. Digestive"),
    ("Rectum", "15. Digestive"),
    ("Anal Canal", "15. Digestive"),
    ("Liver", "15. Digestive"),
    ("Gallbladder", "15. Digestive"),
    ("Pancreas", "15. Digestive"),
    ("Spleen", "15. Digestive"),
    # 16. Urinary
    ("Kidney", "16. Urinary"),
    ("Nephron", "16. Urinary"),
    ("Renal Cortex", "16. Urinary"),
    ("Renal Medulla", "16. Urinary"),
    ("Ureter", "16. Urinary"),
    ("Urinary Bladder", "16. Urinary"),
    ("Urethra", "16. Urinary"),
    # 17. Reproductive
    ("Ovary", "17. Reproductive"),
    ("Uterus", "17. Reproductive"),
    ("Cervix", "17. Reproductive"),
    ("Vagina", "17. Reproductive"),
    ("Vulva", "17. Reproductive"),
    ("Testis", "17. Reproductive"),
    ("Epididymis", "17. Reproductive"),
    ("Vas Deferens", "17. Reproductive"),
    ("Seminal Vesicle", "17. Reproductive"),
    ("Prostate", "17. Reproductive"),
    ("Penis", "17. Reproductive"),
    # 18. Eye
    ("Cornea", "18. Eye"),
    ("Sclera", "18. Eye"),
    ("Iris", "18. Eye"),
    ("Lens", "18. Eye"),
    ("Retina", "18. Eye"),
    ("Macula", "18. Eye"),
    ("Fovea", "18. Eye"),
    ("Optic Disc", "18. Eye"),
    ("Optic Nerve", "18. Eye"),
    ("Vitreous Body", "18. Eye"),
    ("Aqueous Humor", "18. Eye"),
    # 19. Ear
    ("Auricle", "19. Ear"),
    ("External Auditory Canal", "19. Ear"),
    ("Tympanic Membrane", "19. Ear"),
    ("Ossicles", "19. Ear"),
    ("Cochlea", "19. Ear"),
    ("Vestibule", "19. Ear"),
    ("Semicircular Canals", "19. Ear"),
    ("Eustachian Tube", "19. Ear"),
    # 20. Skin
    ("Skin", "20. Skin"),
    ("Epidermis", "20. Skin"),
    ("Dermis", "20. Skin"),
    ("Hypodermis", "20. Skin"),
    ("Hair Follicle", "20. Skin"),
    ("Sebaceous Gland", "20. Skin"),
    ("Sweat Gland", "20. Skin"),
    ("Nail", "20. Skin"),
    # 21. Embryology
    ("Embryo", "21. Embryology"),
    ("Fetus", "21. Embryology"),
    ("Placenta", "21. Embryology"),
    ("Umbilical Cord", "21. Embryology"),
    ("Blastocyst", "21. Embryology"),
    ("Gastrulation", "21. Embryology"),
    ("Ectoderm", "21. Embryology"),
    ("Mesoderm", "21. Embryology"),
    ("Endoderm", "21. Embryology"),
]

present = 0
missing = 0
print("=" * 80)
print("MEDDICTIONARY TERM COVERAGE CHECK")
print("=" * 80)
for term, category in REQUESTED:
    found = False
    chapter = None
    for f in sorted(os.listdir(CHAPTER_DIR)):
        if not f.endswith('.tex'): continue
        with open(os.path.join(CHAPTER_DIR, f)) as fp:
            content = fp.read()
        if re.search(r'\\medterm\{' + re.escape(term) + r'\}', content):
            found = True
            chapter = f
            break
    if found:
        present += 1
        print(f"  [FOUND] {term:30s} -> {chapter}")
    else:
        missing += 1
        print(f"  [MISSING] {term:30s} - NOT IN DICTIONARY")

print()
print(f"RESULTS: {present}/{len(REQUESTED)} present, {missing}/{len(REQUESTED)} missing ({100*missing//len(REQUESTED)}% missing)")
