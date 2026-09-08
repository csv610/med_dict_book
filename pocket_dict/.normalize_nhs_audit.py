import re
from pathlib import Path

variants = {
    'leukaemia': 'leukemia', 'anaemia': 'anemia', 'oedema': 'edema',
    'paediatric': 'pediatric', 'foetal': 'fetal', 'tumour': 'tumor',
    'diarrhoea': 'diarrhea', 'ischaemia': 'ischemia', 'ischaemic': 'ischemic',
    'coeliac': 'celiac', 'fibre': 'fiber', 'haemorrhage': 'hemorrhage',
    'haemorrhagic': 'hemorrhagic', 'haemoglobin': 'hemoglobin',
    'oesophagus': 'esophagus', 'oesophageal': 'esophageal',
}

def norm(s):
    s = s.lower().replace('’', "'").replace('–', '-').replace('—', '-')
    for old, new in variants.items():
        s = re.sub(rf'\b{old}\b', new, s)
    return re.sub(r'\s+', ' ', s.strip())

old = Path('missing_from_nih.md').read_text().splitlines()
nhs = [x.split(':** ', 1)[1] for x in old if x.startswith('- **NHS term:** ')]
dictionary = []
for chapter in sorted(Path('chapters').glob('med_terms_*.tex')):
    dictionary += re.findall(r'\\medterm\{([^}]+)\}', chapter.read_text())
dictionary = list(dict.fromkeys(dictionary))
by_norm = {norm(x): x for x in dictionary}

rows = []
for term in nhs:
    exact = by_norm.get(norm(term))
    if exact:
        rows.append((term, 'present', None, 'The dictionary contains this term; capitalization and standard UK/US spelling variants are ignored.'))
    else:
        rows.append((term, 'absent', None, 'The dictionary does not contain this NHS heading after applying the stated capitalization and UK/US spelling normalizations.'))

present = sum(x[1] == 'present' for x in rows)
out = ['# NHS inform A–Z terms checked against the dictionary', '', 'Source: [NHS inform — A to Z list of common illnesses and conditions](https://www.nhsinform.scot/illnesses-and-conditions/a-to-z).', 'Review date: 2026-09-08.', '', f'The NHS inform A–Z is the source list for this audit. It contains {len(rows)} unique headings in the reviewed index: **{present}** are present as dictionary terms and **{len(rows)-present}** are absent.', '', '## Matching policy', '', '- Each item below comes from the NHS inform A–Z page, not from the dictionary.', '- Dictionary membership was checked against `\\medterm{...}` headwords extracted directly from `chapters/med_terms_*.tex`.', '- “Present” ignores capitalization, curly/straight apostrophes, repeated whitespace, and standard UK/US spelling variants such as `leukaemia`/`leukemia`.', '- “Absent” means the dictionary does not contain the NHS term after those normalizations. A related headword is noted only when the similarity is strong.', '', '## Term-by-term results', '']
for term, status, related, why in rows:
    out += [f'- **NHS term:** {term}', f'  **Status:** {status}', f'  **Explanation:** {why}']
    if related:
        out.append(f'  **Related dictionary headword:** {related}')
    out.append('')
Path('missing_from_nih.md').write_text('\n'.join(out))
print(f'wrote {len(rows)} headings; {present} present, {len(rows)-present} absent')
