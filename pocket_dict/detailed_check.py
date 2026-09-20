import re
import string

def check_missing_detailed():
    with open("appendices/common_diseases.tex", "r", encoding="utf-8") as f:
        content = f.read()

    raw_categories = re.findall(r"\\item\[(.*?)\](.*?)(?=\\item\[|\\end\{description\}|\Z)", content, re.DOTALL)

    diseases = []
    for cat_name, cat_body in raw_categories:
        items = re.split(r"[;\n]", cat_body)
        for it in items:
            it = it.strip()
            it = re.sub(r"%.*", "", it).strip()
            # strip trailing period
            if it.endswith("."):
                it = it[:-1].strip()
            if it:
                diseases.append((cat_name.strip(), it))

    headwords = set()
    headword_dict = {}
    
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
            headword_dict[m_clean.lower()] = (m_clean, letter.upper())
            no_paren = re.sub(r"\(.*?\)", "", m_clean).strip().lower()
            if no_paren:
                headword_dict[no_paren] = (m_clean, letter.upper())
            p_match = re.search(r"\((.*?)\)", m_clean)
            if p_match:
                headword_dict[p_match.group(1).strip().lower()] = (m_clean, letter.upper())

    missing = []
    found = []

    for cat, dis in diseases:
        clean_dis = dis.strip().lower()
        clean_dis_no_paren = re.sub(r"\(.*?\)", "", clean_dis).strip()
        paren_match = re.search(r"\((.*?)\)", clean_dis)
        paren_dis = paren_match.group(1).strip() if paren_match else ""

        match_found = None
        for cand in [clean_dis, clean_dis_no_paren, paren_dis]:
            if cand and cand in headword_dict:
                match_found = headword_dict[cand]
                break

        if not match_found:
            # check typography / dashes / en-dash / plural variations
            variations = [
                clean_dis.replace("–", "-"),
                clean_dis.replace("-", " "),
                clean_dis.replace("–", " "),
                clean_dis.replace("’s", "'s"),
                clean_dis.replace("'s", ""),
                clean_dis.replace("’s", ""),
                clean_dis.replace("disease", "").strip(),
                clean_dis.rstrip("s"),
            ]
            for v in variations:
                if v in headword_dict:
                    match_found = headword_dict[v]
                    break

        if match_found:
            found.append((cat, dis, match_found))
        else:
            missing.append((cat, dis))

    print(f"Verified Results:")
    print(f"Total listed: {len(diseases)}")
    print(f"Matched in dictionary: {len(found)}")
    print(f"Actually Missing: {len(missing)}\n")

    current_cat = ""
    for cat, dis in missing:
        if cat != current_cat:
            print(f"\n[{cat}]")
            current_cat = cat
        print(f"  - {dis}")

if __name__ == "__main__":
    check_missing_detailed()
