import re
import string

def check_missing_in_dictionary():
    # 1. Parse common_diseases.tex
    with open("appendices/common_diseases.tex", "r", encoding="utf-8") as f:
        content = f.read()

    # Find all items in the description list
    raw_categories = re.findall(r"\\item\[(.*?)\](.*?)(?=\\item\[|\\end\{description\}|\Z)", content, re.DOTALL)

    diseases = []
    for cat_name, cat_body in raw_categories:
        # Split by semicolon or newline
        items = re.split(r"[;\n]", cat_body)
        for it in items:
            it = it.strip()
            # Clean comments, trailing periods, empty entries
            it = re.sub(r"%.*", "", it).strip()
            if it:
                diseases.append((cat_name.strip(), it))

    # 2. Extract all headwords from dictionary chapters (med_terms_a.tex to med_terms_z.tex)
    headwords = set()
    raw_headwords = []
    
    for letter in string.ascii_lowercase:
        ch_file = f"chapters/med_terms_{letter}.tex"
        try:
            with open(ch_file, "r", encoding="utf-8") as f:
                ch_text = f.read()
        except FileNotFoundError:
            continue

        matches = re.findall(r"\\medterm\{([^}]+)\}", ch_text)
        for m in matches:
            m_clean = m.strip()
            raw_headwords.append(m_clean)
            headwords.add(m_clean.lower())
            # also add version without parenthetical e.g. "Term (Qualifier)" -> "Term"
            no_paren = re.sub(r"\(.*?\)", "", m_clean).strip().lower()
            if no_paren:
                headwords.add(no_paren)
            # also add parenthetical itself e.g. "Paracetamol" from "Acetaminophen (Paracetamol)"
            p_match = re.search(r"\((.*?)\)", m_clean)
            if p_match:
                headwords.add(p_match.group(1).strip().lower())

    # 3. Check which diseases are missing
    missing = []
    found = []

    for cat, dis in diseases:
        # Normalize disease string
        clean_dis = dis.strip().lower()
        clean_dis_no_paren = re.sub(r"\(.*?\)", "", clean_dis).strip()
        paren_match = re.search(r"\((.*?)\)", clean_dis)
        paren_dis = paren_match.group(1).strip() if paren_match else ""

        # Check exact or normalized match
        is_defined = False
        if clean_dis in headwords:
            is_defined = True
        elif clean_dis_no_paren and clean_dis_no_paren in headwords:
            is_defined = True
        elif paren_dis and paren_dis in headwords:
            is_defined = True
        else:
            # Check partial or variations like British/US spellings or with/without "disease"
            # e.g., "Parkinson Disease" vs "Parkinson's Disease"
            alt_forms = [
                clean_dis.replace("disease", "").strip(),
                clean_dis.replace("’s", "").replace("'s", "").strip(),
                clean_dis.replace("’s disease", "").replace("'s disease", "").strip(),
                clean_dis.replace("syndrome", "").strip(),
                clean_dis.replace("haemo", "hemo"),
                clean_dis.replace("hemo", "haemo"),
                clean_dis.replace("anaemia", "anemia"),
                clean_dis.replace("anemia", "anaemia"),
                clean_dis.replace("-", " "),
                clean_dis.replace(" ", "-"),
            ]
            for alt in alt_forms:
                if alt in headwords:
                    is_defined = True
                    break

        if is_defined:
            found.append((cat, dis))
        else:
            missing.append((cat, dis))

    print(f"Total diseases listed in common_diseases.tex: {len(diseases)}")
    print(f"Total defined in dictionary: {len(found)}")
    print(f"Total missing / undefined: {len(missing)}\n")

    current_cat = ""
    for cat, dis in missing:
        if cat != current_cat:
            print(f"\n[{cat}]")
            current_cat = cat
        print(f"  - {dis}")

if __name__ == "__main__":
    check_missing_in_dictionary()
