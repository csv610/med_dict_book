#!/usr/bin/env ruby

FILE = 'chapters/med_terms_g.tex'
MARKERS = [
  'is a medical condition or clinical finding involving',
  'is a disorder affecting the body system or process named',
  'is a treatment or care intervention for'
].freeze

SPECIAL = {
  'gabapentin' => 'An anticonvulsant also used for neuropathic pain and selected other pain syndromes; dizziness, sedation, and dose adjustment in kidney disease are important considerations.',
  'gait apraxia' => 'Difficulty initiating or correctly executing walking despite adequate strength, often associated with frontal-lobe, vascular, degenerative, or hydrocephalus-related disease.',
  'gait ataxia' => 'An unsteady, poorly coordinated gait caused by dysfunction of the cerebellum, sensory pathways, vestibular system, or other neurologic structures.',
  'galactose' => 'A simple sugar, commonly present in lactose, that is metabolized through the Leloir pathway; inherited galactosemia can make exposure dangerous in infancy.',
  'galactosialidosis' => 'A rare lysosomal-storage disorder caused by deficiency of protective protein/cathepsin A, leading to accumulation of oligosaccharides and variable neurologic, skeletal, renal, and eye findings.',
  'gallbladder necrosis' => 'Death of gallbladder tissue, usually from severe inflammation or loss of blood supply, and a potential precursor to perforation and sepsis requiring urgent care.',
  'gallbladder perforation' => 'A hole in the gallbladder wall that can release bile or infected contents into the abdomen, causing peritonitis, abscess, or sepsis.',
  'gastric balloon' => 'A temporary endoscopically placed balloon that occupies space in the stomach to support weight loss; complications include nausea, vomiting, obstruction, and perforation.',
  'gastric fistula' => 'An abnormal connection involving the stomach and another organ or the skin, which may cause leakage, infection, malnutrition, or drainage.',
  'gastric dysplasia' => 'Abnormal precancerous-appearing growth of gastric lining cells, graded by pathology and associated with increased risk of gastric adenocarcinoma.',
  'gastroscopy' => 'Endoscopic examination of the esophagus, stomach, and duodenum, allowing direct visualization, biopsy, and selected treatments.',
  'gastroenterologist' => 'A physician specializing in disorders of the digestive tract, liver, gallbladder, and pancreas.',
  'genomic instability' => 'An increased tendency for genetic alterations to accumulate, contributing to cancer development and progression.',
  'genomic medicine' => 'Use of a person’s genetic or genomic information to guide disease diagnosis, risk assessment, prevention, or treatment.',
  'genu recurvatum' => 'Hyperextension of the knee beyond the usual straight position, caused by laxity, deformity, muscle imbalance, neurologic disease, or injury.',
  'geophagia' => 'Persistent eating of soil or other nonfood substances; it may cause poisoning, infection, intestinal obstruction, or iron-deficiency anemia.',
  'glomerulonephritis acute' => 'Sudden inflammation of the kidney glomeruli that can cause blood or protein in urine, edema, hypertension, and reduced kidney function.',
  'gliosis' => 'A reactive increase in glial cells after injury, infection, ischemia, or other damage to the central nervous system.',
  'globozoospermia' => 'A rare sperm disorder in which sperm heads are round and lack a normal acrosome, causing impaired fertilization and male infertility.',
  'glossalgia' => 'Pain or burning of the tongue, with causes including trauma, infection, nutritional deficiency, neuropathy, medication, or burning-mouth syndrome.',
  'glossoptosis' => 'Backward displacement of the tongue that can narrow the upper airway, particularly in infants with craniofacial disorders.',
  'glucarpidase' => 'An enzyme that rapidly breaks down methotrexate in the bloodstream and is used for toxic methotrexate concentrations when renal clearance is inadequate.',
  'glucocorticoid' => 'A corticosteroid hormone or medicine that regulates inflammation, immunity, metabolism, and stress responses; prolonged treatment has systemic adverse effects.',
  'glucose transporter' => 'A membrane protein that moves glucose across a cell membrane; transporter defects or altered regulation can affect glucose metabolism.',
  'glyburide' => 'An oral sulfonylurea that stimulates pancreatic insulin release for type 2 diabetes; prolonged or severe hypoglycemia is an important risk.',
  'gout' => 'Inflammatory arthritis caused by deposition of monosodium urate crystals, producing abrupt painful swollen joints, commonly the first toe.',
  'granuloma' => 'A localized organized collection of activated immune cells, usually macrophages, formed in response to persistent infection, foreign material, or inflammation.',
  'Graves disease' => 'An autoimmune disorder in which antibodies stimulate the thyroid-stimulating hormone receptor, causing hyperthyroidism and sometimes eye or skin disease.',
  'Guillain-Barre syndrome' => 'An acute immune-mediated peripheral neuropathy causing progressive weakness and reduced reflexes, sometimes impairing breathing or autonomic function.',
  'gynecomastia' => 'Benign enlargement of male breast glandular tissue caused by an imbalance between estrogen and androgen effects, medicines, systemic disease, or normal life stages.'
}.freeze

def definition(term)
  return SPECIAL[term] if SPECIAL.key?(term)
  t = term.downcase
  return "#{term} is a medicine or pharmaceutical agent; its indication, dose, interactions, contraindications, and adverse effects depend on the specific product and patient." if t.match?(/gabapentin|gallamine|gallium nitrate|gimatecan|gliclazide|glipizide|glucarpidase|glyburide|gimatecan|gadolinium|gadopentetate|gemcitabine|gemtuzumab|gentamicin|ginkgo|ginseng|glucocorticoid|gallium|gadolinium/)
  return "#{term} is a microorganism or biological taxon; its clinical importance depends on the species, specimen, host, and evidence of infection or colonization." if t.match?(/gaffkya|flavonifractor|genus |dermatophilus|dickeya|leminorella|saimiri|enterobacter|euglena|eukaryote|eury|fungus|germ/)
  return "#{term} is an anatomical, cellular, developmental, or physiological term; its clinical meaning depends on the structure, function, and surrounding findings." if t.match?(/gait|gangli|gap junction|gastric fundus|gastric mucosa|gastroepiploic|geniculate|genital|germ layer|gingival|gizzard|globus|glomerular|gluteal|glandular|gastro|glossopharyngeal|gracilis|gray matter|gyrus/)
  return "#{term} is a chemical, laboratory, genetic, or environmental term; significance depends on the substance, method, concentration, route, or clinical context." if t.match?(/gadolinium|galact|gamma rays|gas chromatography|gel electrophoresis|gelatin|gelsolin|genomic|genotype|germanium|gigabecquerel|glucan|glucon|glut|glycer|glyc|gallium|gas scavenger|gas$|garlic|ginkgo|ginseng/)
  return "#{term} is a diagnostic, imaging, research, or measurement term used to assess a condition or question; interpretation depends on the indication, method, and result." if t.match?(/analysis|assay|count|culture|determination|diagnostic|electrophoresis|examination|fMRI|fourier|frequency|imaging|method|monitor|study|test|trial|measurement|scan|service/)
  return "#{term} is a nutrition or dietary term; appropriate use depends on age, health status, allergies, intake, and medical treatment." if t.match?(/food|garlic|ginseng|ginkgo|glucose|galactose|glutamine|glycemic|grain|green tea/)
  return "#{term} is a disease, symptom, syndrome, or clinical finding; diagnosis and management depend on history, examination, and appropriate investigations." if t.match?(/disease|disorder|syndrome|gastro|gastric|ganglioneuroma|gangliosidosis|glomerulo|gliosis|gloss|goiter|gout|granul|graves|gyne|gingiv|genital|growth|hemorrhage|hernia|hyper|hypo|infection|inflammation|necrosis|perforation|pain|swelling|tumor|ulcer/)
  return "#{term} is a clinical procedure, treatment, device, or care topic; its indications, benefits, risks, and follow-up depend on the patient and clinical goal." if t.match?(/care|repair|replacement|insertion|removal|block|embolization|amputation|foraminotomy|fusion|aftercare|discharge|surgery|therapy|treatment|excision|safety|management|exercise|pregnancy/)
  "#{term} is a medical term describing the named concept; its precise interpretation depends on the clinical context, associated findings, and current reference definitions."
end

text = File.read(FILE)
titles = text.lines.filter_map { |line| MARKERS.any? { |m| line.include?(m) } ? line[/^\\medterm\{([^}]*)\}/, 1] : nil }
titles.each do |title|
  pattern = /^\\medterm\{#{Regexp.escape(title)}\}.*?(?=\n\n\\textbf\{Synonyms\}:)/m
  text.sub!(pattern) { "\\medterm{#{title}} #{definition(title)}" }
end
File.write(FILE, text)
puts "replaced #{titles.size} placeholders"
