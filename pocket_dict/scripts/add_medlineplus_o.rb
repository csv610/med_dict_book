#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Obesity' => 'Obesity is excess adipose tissue that impairs health, influenced by genetic, metabolic, environmental, behavioral, and social factors and associated with cardiometabolic, respiratory, musculoskeletal, and other disease.',
  'Obesity hypoventilation syndrome (OHS)' => 'Obesity hypoventilation syndrome is awake alveolar hypoventilation in a person with obesity after other causes are excluded, commonly accompanied by obstructive sleep apnea and pulmonary hypertension.',
  'Obsessive-compulsive disorder' => 'Obsessive-compulsive disorder causes intrusive unwanted thoughts or images and repetitive behaviors or mental acts performed to reduce distress, with significant time or functional impact.',
  'Obstructive sleep apnea - adults' => 'Obstructive sleep apnea is repeated upper-airway collapse during sleep, causing pauses in breathing, oxygen fluctuation, snoring, fragmented sleep, and daytime impairment.',
  'Occupational asthma' => 'Occupational asthma is variable airway obstruction caused or worsened by workplace exposures such as chemicals, dusts, proteins, or irritants.',
  'Omphalocele' => 'Omphalocele is a congenital abdominal-wall defect in which abdominal organs protrude into a membrane-covered sac at the umbilicus and may coexist with chromosomal or structural anomalies.',
  'Opiate and opioid withdrawal' => 'Opioid withdrawal is a predictable syndrome after reducing or stopping opioid exposure, producing anxiety, sweating, muscle aches, diarrhea, abdominal cramps, nausea, and autonomic symptoms.',
  'Opioid intoxication' => 'Opioid intoxication can cause euphoria, drowsiness, slowed breathing, pinpoint pupils, impaired coordination, coma, and death; respiratory depression requires immediate emergency treatment.',
  'Oral cancer' => 'Oral cancer is malignant growth of the lips, mouth, tongue, gums, or oropharynx, often presenting with a persistent ulcer, lump, pain, bleeding, or swallowing difficulty.',
  'Orbital cellulitis' => 'Orbital cellulitis is infection of tissues behind the orbital septum, causing painful eye movement, eyelid swelling, fever, impaired vision, and risk of intracranial spread.',
  'Osteoarthritis' => 'Osteoarthritis is a degenerative joint disorder involving cartilage loss, subchondral bone change, pain, stiffness, and functional limitation, influenced by age, injury, and joint loading.',
  'Osteogenesis imperfecta' => 'Osteogenesis imperfecta is an inherited connective-tissue disorder, usually involving type I collagen, that causes bone fragility, fractures, short stature, dentin abnormalities, or hearing loss.',
  'Osteomyelitis' => 'Osteomyelitis is infection and inflammation of bone caused by bacteria, fungi, or other organisms, producing pain, fever, swelling, and possible bone destruction or chronic drainage.',
  'Osteoporosis' => 'Osteoporosis is reduced bone strength from low bone mass or impaired bone quality, increasing risk of fragility fractures of the spine, hip, wrist, and other bones.',
  'Osteosarcoma' => 'Osteosarcoma is an aggressive malignant bone tumor that produces osteoid, most often affecting the metaphysis of long bones in children and young adults.',
  'Ovarian cancer' => 'Ovarian cancer is malignant growth arising from ovarian, fallopian-tube, or related epithelial tissue, often presenting late with bloating, pelvic symptoms, early satiety, or abdominal fluid.',
  'Ovarian hyperstimulation syndrome' => 'Ovarian hyperstimulation syndrome is an excessive response to fertility treatment causing enlarged ovaries and fluid shifts, with possible abdominal pain, ascites, thrombosis, kidney injury, or breathing difficulty.',
  'Overdose' => 'An overdose is exposure to a medicine, drug, or substance in an amount capable of causing toxicity, with effects determined by dose, formulation, route, timing, and patient factors.',
  'Oxygen therapy in infants' => 'Oxygen therapy in infants supplements inspired oxygen when gas exchange is inadequate, while careful monitoring limits complications from both hypoxemia and excessive oxygen exposure.',
  'Ozena' => 'Ozena is a chronic form of atrophic rhinitis with widened nasal passages, crusting, foul odor, and impaired mucosal function.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|oil|oleander|oven|oxalic|oxazepam|opioid|opiate/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|ophthalmoscopy|osmolality|stress|ventriculograph|orbit/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|biopsy|procedure|discharge|aftercare|self-care|feeding|oxygen|catheter|arthroscopy|osteotomy|oculoplastic/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|breastfeeding|stress|job|medicine|pain reliever/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|oste|ovarian|obesity|oral|optic|otitis|orchitis|mucositis|hypoglycemia|hypoventilation|sleep apnea|hearing loss/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|oxygen|oral|optic|organ|ovary|overweight|orthopedic/
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
    file.puts '\\synonyms'
  end
end
puts "added #{additions.length} terms"
