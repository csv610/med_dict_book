import re

def list_all_ch16_syns():
    filepath = "chapters/med_terms_p.tex"
    with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()

    entries = re.findall(r"\\medterm\{([^}]+)\}(.*?)(?=\\medterm|\Z)", text, re.DOTALL)
    
    for i, (term, body) in enumerate(entries):
        syn_match = re.search(r"\\synonyms\n(.*?)(?=\n\s*\n|\n\\medterm|\Z)", body, re.DOTALL)
        if syn_match:
            syns = syn_match.group(1).strip()
            print(f"[{i+1}] {term} ::: {syns}")

if __name__ == "__main__":
    list_all_ch16_syns()
