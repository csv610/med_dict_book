import re
import string

def global_audit():
    total_entries = 0
    total_syn_blocks = 0
    all_issues = []

    for letter in string.ascii_lowercase:
        filepath = f"chapters/med_terms_{letter}.tex"
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                text = f.read()
        except FileNotFoundError:
            continue

        entries = re.findall(r"\\medterm\{([^}]+)\}.*?(?:\\synonyms\n(.*?))?(?=\n\s*\\medterm|\Z)", text, re.DOTALL)
        total_entries += len(entries)

        for term, syns in entries:
            if not syns:
                continue
            total_syn_blocks += 1
            syn_list = [s.strip() for s in re.split(r"[;\n]", syns) if s.strip()]

            clean_t = re.sub(r"\(.*?\)", "", term).strip().lower()
            paren_match = re.search(r"\((.*?)\)", term)
            paren_t = paren_match.group(1).strip().lower() if paren_match else ""

            for s in syn_list:
                clean_s = re.sub(r"\(.*?\)", "", s).strip().lower()

                # Check circular
                if clean_s == clean_t or (paren_t and clean_s == paren_t):
                    all_issues.append((letter.upper(), term, f"Circular: {s}"))

                # Check nested self-reference e.g. "X (X)"
                if "(" in s:
                    in_p = re.findall(r"\((.*?)\)", s)
                    for p in in_p:
                        if p.strip().lower() == clean_t or p.strip().lower() == clean_s:
                            all_issues.append((letter.upper(), term, f"Nested self-ref: {s}"))

                # Check inverted commas e.g. "Cancer, Lung"
                if "," in s and not any(w in s for w in ["and", "&", "Type", "Syndrome", "4p-", "47,XXX", "Smith-Modified", "Camper"]):
                    parts = [p.strip() for p in s.split(",")]
                    if len(parts) == 2 and len(parts[1].split()) <= 2 and len(parts[0].split()) <= 2:
                        all_issues.append((letter.upper(), term, f"Inverted comma: {s}"))

                # Check permutation
                t_words = set(clean_t.split())
                s_words = set(clean_s.split())
                if len(t_words) > 1 and t_words == s_words and clean_t != clean_s:
                    all_issues.append((letter.upper(), term, f"Permutation: {s}"))

                # Check trailing period
                if s.endswith("."):
                    all_issues.append((letter.upper(), term, f"Trailing period: {s}"))

    print(f"==================================================")
    print(f"FULL DICTIONARY COMPREHENSIVE AUDIT (A to Z)")
    print(f"Total entries scanned: {total_entries}")
    print(f"Total synonym blocks: {total_syn_blocks}")
    print(f"Total residual issues found across all 26 chapters: {len(all_issues)}")
    print(f"==================================================")
    for ch, t, issue in all_issues:
        print(f"[{ch}] [{t}]: {issue}")

if __name__ == "__main__":
    global_audit()
