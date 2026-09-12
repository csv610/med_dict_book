#!/usr/bin/env python3
"""Generate deterministic clinical-relevance scores for the LaTeX dictionary."""

from __future__ import annotations

import json
import re
from collections import defaultdict
from datetime import date
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CHAPTER_GLOB = "chapters/med_terms_*.tex"
OUTPUT = ROOT / "clinical_scores.json"


def latex_text(value: str) -> str:
    value = value.replace("\\&", "&").replace("--", "-").replace("~", " ")
    value = re.sub(r"\\text(?:it|bf|rm|sc)\{([^{}]*)\}", r"\1", value)
    value = re.sub(r"\\[a-zA-Z]+", "", value)
    value = value.replace("{", "").replace("}", "")
    return re.sub(r"\s+", " ", value).strip()


def is_reference_only(definition: str) -> bool:
    """Return true for entries that redirect to a primary term or name an alias."""
    return bool(
        re.match(
            r"^(see|alternate name|alternate index label|another name|alternate label)\b",
            definition.casefold(),
        )
    )


def extract_terms() -> dict[str, dict[str, object]]:
    found: dict[str, dict[str, object]] = {}
    pattern = re.compile(r"^\\medterm\{([^}]*)\}(?:\s*(.*))?$")
    for path in sorted(ROOT.glob(CHAPTER_GLOB)):
        lines = path.read_text(encoding="utf-8").splitlines()
        for index, line in enumerate(lines):
            match = pattern.match(line)
            if not match:
                continue
            term = latex_text(match.group(1))
            description = [match.group(2) or ""]
            for continuation in lines[index + 1 :]:
                if continuation.startswith("\\medterm{") or continuation.startswith("\\synonyms"):
                    break
                description.append(continuation)
            text = latex_text(" ".join(description))
            candidate = {
                "term": term,
                "definition": text,
                "chapter": str(path.relative_to(ROOT)),
            }
            # Duplicate labels are represented once; retain the most informative definition.
            previous = found.get(term.casefold())
            if previous is None:
                found[term.casefold()] = candidate
                continue
            previous_definition = str(previous["definition"])
            candidate_primary = not is_reference_only(text)
            previous_primary = not is_reference_only(previous_definition)
            if (candidate_primary and not previous_primary) or (
                candidate_primary == previous_primary
                and len(text) > len(previous_definition)
            ):
                found[term.casefold()] = candidate
    return found


def load_categories() -> dict[str, str]:
    data = json.loads((ROOT / "med_terms.json").read_text(encoding="utf-8"))
    categories: dict[str, str] = {}
    for record in data.get("terms", []):
        term = str(record.get("term", "")).strip().casefold()
        values = [str(value).strip().casefold() for value in record.get("category", [])]
        if term and values:
            categories[term] = values[0]
    drugs_path = ROOT / "chapters/drugs.tex"
    if drugs_path.exists():
        for match in re.finditer(r"^\\medterm\{([^}]*)\}", drugs_path.read_text(encoding="utf-8"), re.MULTILINE):
            categories[latex_text(match.group(1)).casefold()] = "medication"
    return categories


def infer_category(term: str, definition: str, known: dict[str, str]) -> str:
    key = term.casefold()
    if key in known:
        return known[key]
    term_text = term.casefold()
    text = f"{term} {definition}".casefold()
    if re.search(
        r"\b(angina|anoca|anomaly|azotaemia|balance disorder|barrett|blackhead|blephar|bromodosis|bronchocele|birth defect|burn|cancer|carcinoma|canker|cardiac allograft vasculopathy|choroideremia|clavus|colorectal|constipation|contracture|coronary|cyst|defect|depression|dermatitis|dermatophyte|dementia|disease|disorder|dysplasia|ectopion|ectropion|eczema|emphysema|embolism|encephalopathy|erythema|failure|fasciitis|fracture|hearing loss|hyalosis|hypomelanosis|inoca|infectious|infection|infarction|ischemia|leukemia|lichen|malformation|microsomia|neoplasm|neuropathy|neuralgia|nodule|orthorexia|pancreatitis|palsy|paralysis|parakeratosis|phthiriasis|poisoning|polyp|preleuk\w*|pseudodementia|schizophrenia|sclerosis|seizure|syndrom\w*|thrombosis|tox(a|e)emia|toxidrome|tumou?r|ulcer|vasculitis|verruc\w*|hyperplasia|adenoma|condyloma|allergy|bather.s itch|breathlessness|blushing|burping)\b",
        term_text,
    ):
        return "condition"
    if re.search(
        r"\b(ache|acidosis|acromegaly|adactyly|adiposity|alopecia|amenorrhea|anemia|anaemia|anaphylaxis|anorexia|apnea|arrhythmia|arthritis|asthma|ataxia|autism|bleeding|colitis|coma|cough|diabetes|edema|oedema|epilepsy|fever|glaucoma|hepatitis|hypertension|hypotension|hypoxaemia|migraine|obesity|pain|pneumonia|rash|seizure|shock|spondyl|stomatitis|syncope|vomiting)\b",
        term_text,
    ):
        return "condition"
    if re.search(
        r"\b(test|assay|analysis|biopsy|cytology|diagnostic\w*|echography|fundoscopy|hcg|imaging|manometry|radiograph|scan|screening|smear|specimen|spirometry|ultrasound|urinalysis)\b",
        term_text,
    ):
        return "test"
    if re.search(
        r"\b(angioplasty|banking|bridge|catheter|circumcision|crown|curettage|dialysis|donation|drainage|dentures|extraction|filling|graft|implant|insemination|injection|intubation|mastectomy|pacemaker|plasty|resection|surgery|traction|transplant|vaccination|ventilation)\b",
        term_text,
    ):
        return "procedure"
    if re.search(
        r"(?:olol|pril|sartan|statin|azole|cillin|cycline|mycin|mab|vir|caine|prazole|dipine|setron|pam|lam|parin|xaban|glitazone|formin|tide|gliptin|floxacin|profen|fenac|oxetine|ipramine|zepam|zolid|taxel|rubicin|mustine)$",
        term_text,
    ) or re.search(
        r"\b(a|an) (drug|medicine|medication|antibiotic|antiviral|antidepressant|anticoagulant|blocker|inhibitor|agonist|antagonist)\b",
        text,
    ) or re.search(
        r"\b(inhibits?|blocks?|agonist|antagonist|receptor blocker)\b.*\bused (for|to treat)\b",
        text,
    ) or re.search(
        r"\b(is|are) (a|an) [^.;]{0,80}\b(agonist|antagonist|blocker|inhibitor)\b",
        text,
    ):
        return "medication"
    if re.search(
        r"\b(artery|bone|brain|bronch|cervix|gland|heart|intestine|kidney|liver|lung|muscle|nerve|organ|ovary|pancreas|retina|skin|spleen|stomach|testis|tissue|tooth|teeth|uterus|vein)\b",
        term_text,
    ):
        return "anatomy"
    if re.search(
        r"\b(antibacterial|antimicrobial|antipsychotic|barbiturate|calcium-channel blocker|diuretic|gold compound|antihistamine|antibiotic|drug|medicine|medication|progestogen|quinolone|retinoid|stimulates .* receptors)\b",
        text,
    ):
        return "medication"
    if re.search(
        r"\b(measured in (blood|urine)|detect pregnancy|laboratory|conditions that|abnormalit(?:y|ies) present at birth)\b",
        text,
    ):
        return "test" if re.search(r"\b(measured in (blood|urine)|detect pregnancy|laboratory)\b", text) else "condition"
    if "virtual reality" in term_text:
        return "professional"
    if re.search(r"\b(test|assay|screen|scan|imaging|radiograph|ultrasound|tomograph|biopsy|smear|monitoring|breathalyzer|clinistix|diffusion capacity|barium meal)\b", text):
        return "test"
    if re.search(r"\b(surgery|surgical|procedure|operation|resection|therapy|transplant|injection|repair|excision)\b", text):
        return "procedure"
    if re.search(r"\b(drug|medicine|medication|inhibitor|antibiotic|antiviral|antidepressant|vaccine)\b", text):
        return "medication"
    if re.search(r"\b(pain|ache|fever|nausea|vomiting|symptom|fatigue|weakness|swelling|bleeding)\b", text):
        return "symptom"
    if re.search(r"\b(syndrome|disease|disorder|cancer|tumor|infection|deficiency|inflammation|injury|failure|necrosis)\b", text):
        return "condition"
    if re.search(r"\b(muscle|nerve|bone|organ|gland|artery|vein|cell|tissue|anatom)\b", text):
        return "anatomy"
    if re.search(r"\b(enzyme|protein|gene|chromosome|molecule|bacter|virus|immune|receptor|metabolism)\b", text):
        return "biology"
    return "general"


def score_for(term: str, definition: str, category: str) -> tuple[int, str]:
    text = f"{term} {definition}".casefold()
    urgent = re.search(
        r"\b(arrest|anaphylaxis|aneurysm|cancer|carcinoma|coma|embol|hemorrhage|infarct|leukemia|meningitis|poisoning|sepsis|shock|stroke|suicide|trauma)\b",
        text,
    )
    if urgent and category in {"condition", "disease", "symptom", "test", "laboratory test", "procedure", "medication", "treatment"}:
        return 5, "High clinical relevance: directly affects major diagnosis, treatment, prognosis, or patient safety."
    if category in {"condition", "disease", "symptom", "test", "laboratory test", "procedure", "medication", "treatment", "device", "toxicology"}:
        return 4, "Directly relevant to clinical diagnosis, management, monitoring, prevention, or patient counseling."
    if category in {"anatomy", "finding", "mental health", "cardiology", "ophthalmology", "preventive care", "specialty"}:
        return 3, "Clinically useful supporting knowledge for assessment, communication, or care planning."
    if category in {"biology", "biochemistry", "physiology", "histology", "nutrition", "professional"}:
        return 2, "Relevant medical background or specialized knowledge with indirect clinical application."
    return 1, "Primarily educational, general, or peripheral terminology rather than a direct clinical decision term."


def main() -> None:
    extracted = extract_terms()
    known_categories = load_categories()
    records: dict[str, dict[str, object]] = {}
    for key in sorted(extracted, key=lambda value: value.casefold()):
        item = extracted[key]
        term = str(item["term"])
        definition = str(item["definition"])
        if is_reference_only(definition):
            continue
        category = infer_category(term, definition, known_categories)
        score, rationale = score_for(term, definition, category)
        records[term] = {
            "score": score,
            "rationale": rationale,
            "category": category,
        }

    payload = {
        "schema_version": "1.0",
        "score_definition": "Clinical relevance on a 1-5 scale for primary dictionary terms; higher scores indicate more direct usefulness in clinical care. Reference-only and alias entries are excluded.",
        "source": "chapters/med_terms_*.tex",
        "generated_on": date.today().isoformat(),
        "term_count": len(records),
        "terms": records,
    }
    OUTPUT.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {len(records)} terms to {OUTPUT}")


if __name__ == "__main__":
    main()
