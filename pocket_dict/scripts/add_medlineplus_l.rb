#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Labyrinthitis' => 'Labyrinthitis is inflammation of the inner ear balance and hearing structures, causing acute vertigo, imbalance, nausea, and sometimes hearing loss.',
  'Lactic acidosis' => 'Lactic acidosis is clinically significant accumulation of lactate with metabolic acidosis, usually from impaired oxygen delivery, mitochondrial dysfunction, seizures, medications, or severe systemic illness.',
  'Lactose intolerance' => 'Lactose intolerance results from insufficient lactase activity, causing bloating, abdominal pain, gas, or diarrhea after consuming lactose.',
  'Lambert-Eaton myasthenic syndrome' => 'Lambert-Eaton myasthenic syndrome is an autoimmune disorder of presynaptic neuromuscular transmission causing proximal weakness, reduced reflexes, autonomic symptoms, and sometimes association with small-cell lung cancer.',
  'Laminectomy' => 'Laminectomy removes part of a vertebral lamina to decompress the spinal canal or nerve roots, often for stenosis, tumor, or selected disk disease.',
  'Laryngitis' => 'Laryngitis is inflammation of the larynx causing hoarseness or voice loss, commonly from viral infection, vocal overuse, irritation, reflux, or less often structural disease.',
  'Lead poisoning' => 'Lead poisoning is toxic accumulation of lead that can damage the nervous system, blood, kidneys, gastrointestinal tract, and developing child, with effects depending on dose and duration.',
  'Legionnaires disease' => 'Legionnaires disease is severe pneumonia caused by Legionella bacteria, usually acquired by inhaling contaminated water aerosols and potentially complicated by respiratory failure or systemic illness.',
  'Leishmaniasis' => 'Leishmaniasis is infection by Leishmania parasites transmitted by sandflies, producing cutaneous, mucosal, or visceral disease depending on species and host response.',
  'Leprosy' => 'Leprosy is chronic infection with Mycobacterium leprae or M. lepromatosis, affecting skin and peripheral nerves and potentially causing sensory loss, weakness, and deformity.',
  'Leptospirosis' => 'Leptospirosis is zoonotic infection with Leptospira bacteria acquired from water or soil contaminated by animal urine, ranging from fever and myalgia to kidney and liver failure.',
  'Leukemia' => 'Leukemia is cancer of blood-forming cells that disrupts normal marrow production and may cause anemia, infection, bleeding, abnormal blood counts, and organ infiltration.',
  'Leukoplakia' => 'Leukoplakia is a persistent white patch on mucosa that cannot be scraped away and may reflect irritation, infection, or premalignant epithelial change requiring evaluation.',
  'Lichen planus' => 'Lichen planus is an immune-mediated inflammatory disorder affecting skin, mouth, genital mucosa, nails, or scalp and often producing itchy purple polygonal papules or erosions.',
  'Limb-girdle muscular dystrophies' => 'Limb-girdle muscular dystrophies are inherited muscle diseases causing progressive weakness predominantly around the hips and shoulders, with variable cardiac and respiratory involvement.',
  'Lipase test' => 'A lipase test measures a pancreatic digestive enzyme in blood and supports evaluation of acute pancreatitis and selected pancreatic or gastrointestinal disorders.',
  'Listeriosis' => 'Listeriosis is infection with Listeria monocytogenes, causing febrile gastroenteritis or invasive disease such as meningitis, especially in pregnancy, newborns, older adults, and immunocompromised people.',
  'Lithium toxicity' => 'Lithium toxicity causes gastrointestinal, neurologic, renal, and cardiac effects when blood concentrations rise from overdose, dehydration, interactions, or impaired clearance.',
  'Lithotripsy' => 'Lithotripsy breaks urinary stones into smaller fragments using externally delivered shock waves or an endoscopic energy source so they can pass or be removed.',
  'Liver disease' => 'Liver disease includes inflammatory, infectious, metabolic, toxic, vascular, and malignant disorders that can impair detoxification, protein synthesis, bile flow, and portal circulation.',
  'Liver transplant' => 'Liver transplantation replaces a failing or severely diseased liver with a donor organ and requires evaluation, immunosuppression, rejection surveillance, and infection prevention.',
  'Long COVID' => 'Long COVID is a condition of persistent or newly developing symptoms after SARS-CoV-2 infection, potentially involving fatigue, exertional intolerance, cognition, breathing, autonomic function, or multiple organs.',
  'Low blood sugar' => 'Low blood sugar, or hypoglycemia, occurs when circulating glucose is insufficient for normal brain and body function, causing sweating, tremor, confusion, seizures, or loss of consciousness.',
  'Lung cancer' => 'Lung cancer is malignant growth arising in lung or airway tissue, commonly presenting with cough, breathlessness, chest pain, hemoptysis, or systemic symptoms and classified by histology and stage.',
  'Lupus nephritis' => 'Lupus nephritis is immune-complex kidney inflammation caused by systemic lupus erythematosus, producing proteinuria, hematuria, hypertension, and variable loss of renal function.',
  'Lyme disease' => 'Lyme disease is a tick-borne infection caused by Borrelia bacteria, with early skin and flu-like findings and possible later neurologic, cardiac, or joint involvement.',
  'Lymphedema - self-care' => 'Lymphedema self-care focuses on skin protection, exercise, compression when appropriate, limb elevation, infection prevention, and monitoring for worsening swelling or cellulitis.',
  'Lymphadenitis' => 'Lymphadenitis is inflammation or infection of lymph nodes, causing localized tenderness and enlargement from bacterial, viral, mycobacterial, cat-scratch, or other disease.',
  'Lymphogranuloma venereum' => 'Lymphogranuloma venereum is a sexually transmitted infection caused by invasive Chlamydia trachomatis strains, often producing a small lesion followed by painful regional lymphadenopathy or proctitis.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|lithium|lead|lacquer|lanolin|lighter|lily|incense|fluid/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|diffusion|pet|assay|response|pyelogram|scope|stain|level/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|amputation|repair|insertion|therapy|laser|laparoscop|laminectomy|lithotripsy|catheter|discharge|aftercare|self-care|bandage|dressing|feeding|ventilator/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|nutrition|management|prevention|support|exercise|healthy|home|living|learn|care|habits|stress|feelings|discharge|choices|gluten|low-fiber|low-salt|weight-loss/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|lordosis|back pain|pressure|potassium|sodium|calcium|sugar|cholesterol/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|iron|lead|lower|long bone|lateral/
    "#{name} concerns #{lower}, a body structure, substance, or clinical concept whose meaning depends on location, function, and patient context."
  else
    "#{name} concerns #{lower}; its medical significance is established from the defining features, setting, associated findings, and clinical question."
  end
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
existing = File.read(output).scan(/\\medterm\{([^}]*)\}/).flatten.map { |x| normalize(x) }
known = existing.to_h { |x| [x, true] }
terms = File.readlines(input, chomp: true).reject(&:empty?)
additions = terms.reject { |term| known[normalize(term)] }
text = File.read(output)
terms.each do |term|
  escaped = Regexp.escape(term.strip)
  text.gsub!(/^\\medterm\{#{escaped}\s*\}.*$/, "\\medterm{#{term.strip}} #{definition(term)}")
end
File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term.strip}} #{definition(term)}"
    file.puts
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
