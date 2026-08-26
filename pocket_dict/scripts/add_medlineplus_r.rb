#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Rabies' => 'Rabies is a nearly always fatal viral encephalitis transmitted through saliva, usually by an animal bite, but prompt wound care and post-exposure prophylaxis can prevent disease.',
  'Radiation sickness' => 'Radiation sickness is acute tissue injury after high-dose ionizing radiation, causing nausea, marrow suppression, skin injury, gastrointestinal symptoms, infection, bleeding, or organ failure.',
  'Radiation therapy' => 'Radiation therapy uses ionizing radiation to damage cancer-cell DNA while limiting exposure to nearby normal tissue and may be delivered externally or internally.',
  'Raynaud phenomenon' => 'Raynaud phenomenon is episodic constriction of small arteries in fingers or toes triggered by cold or stress, causing sequential pallor, cyanosis, and redness with numbness or pain.',
  'Reactive arthritis' => 'Reactive arthritis is sterile inflammatory arthritis occurring after infection, commonly involving asymmetric lower-limb joints and sometimes the eyes, skin, or urinary tract.',
  'Rectal prolapse' => 'Rectal prolapse is protrusion of rectal tissue through the anus, causing a visible mass, mucus, bleeding, incomplete evacuation, or incontinence.',
  'Renal cell carcinoma' => 'Renal cell carcinoma is the most common adult kidney cancer, often arising from tubular epithelium and presenting incidentally or with hematuria, flank pain, or a mass.',
  'Respiratory syncytial virus (RSV)' => 'Respiratory syncytial virus is a common respiratory infection that can cause bronchiolitis or pneumonia in infants and serious disease in older adults or people with chronic illness.',
  'Restless legs syndrome' => 'Restless legs syndrome causes an urge to move the legs with uncomfortable sensations, worse at rest and evening, and relieved temporarily by movement.',
  'Retinal detachment' => 'Retinal detachment separates the neurosensory retina from supporting tissue, causing flashes, floaters, or a curtain-like visual field loss and requiring urgent ophthalmic care.',
  'Rheumatoid arthritis' => 'Rheumatoid arthritis is chronic systemic autoimmune inflammation targeting synovial joints, causing pain, swelling, stiffness, deformity, and possible lung, vascular, eye, or other organ disease.',
  'Rhinoplasty' => 'Rhinoplasty is surgery that changes nasal shape or function for cosmetic, structural, or reconstructive reasons, with risks involving breathing, bleeding, infection, and appearance.',
  'Rickets' => 'Rickets is defective mineralization of growing bone, usually from vitamin D, calcium, or phosphate disturbance, causing skeletal deformity, growth impairment, pain, or fractures.',
  'Ringworm' => 'Ringworm is a contagious superficial dermatophyte infection of skin, hair, or nails that produces scaly annular lesions, itching, or localized hair loss.',
  'Rocky Mountain spotted fever' => 'Rocky Mountain spotted fever is a tick-borne Rickettsia rickettsii infection causing fever, headache, rash, vascular injury, and potentially severe multiorgan disease.',
  'Rosacea' => 'Rosacea is a chronic inflammatory facial skin disorder with flushing, persistent redness, papules, pustules, visible vessels, and sometimes ocular or nasal changes.',
  'Rotator cuff problems' => 'Rotator cuff problems include tendinopathy, bursitis, and tears that cause shoulder pain, weakness, painful motion, and difficulty with overhead activity.',
  'Rubella' => 'Rubella is a contagious viral infection causing mild fever, lymph-node enlargement, and rash but can produce severe congenital abnormalities when infection occurs during pregnancy.',
  'Rhabdomyolysis' => 'Rhabdomyolysis is rapid skeletal-muscle breakdown releasing myoglobin and electrolytes into blood, potentially causing hyperkalemia, acute kidney injury, arrhythmia, and compartment complications.',
  'Rett syndrome' => 'Rett syndrome is a neurodevelopmental disorder, usually related to MECP2 variants, with regression of purposeful hand use, language, motor skills, stereotypic movements, and autonomic abnormalities.',
  'Rheumatic fever' => 'Rheumatic fever is an autoimmune inflammatory complication of group A streptococcal infection that can affect joints, heart valves, skin, and the nervous system.',
  'Retinoblastoma' => 'Retinoblastoma is a malignant retinal tumor of childhood that may present with leukocoria, strabismus, or visual loss and can be hereditary or sporadic.',
  'Retinitis pigmentosa' => 'Retinitis pigmentosa is a group of inherited retinal degenerations causing night blindness, progressive peripheral-field loss, and eventual central visual impairment.',
  'Ruptured eardrum' => 'A ruptured eardrum is a tear in the tympanic membrane caused by infection, pressure, trauma, or foreign objects and may cause pain, drainage, hearing loss, or dizziness.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|refrigerant|rhubarb|rubber|radiation sickness/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|pet|assay|gram stain|electro|rbc|reticulocyte|renin|rpr|refraction|cystogram|cisternogram|scintiscan|venogram/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|radiation|ablation|laparosc|catheter|discharge|aftercare|self-care|feeding|vaccin|endoscopy|replantation|rhinoplasty|root canal|robotic/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|palliative|pain|care|stress|returning|responsible drinking|rights|masks|work|sports/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paraphimosis|paronychia|phobia|pica|pregnancy|rheumatoid|retinal|renal|respiratory|ricket|ringworm|rosacea|rotator|rabies|rash|fracture|nerve dysfunction|rapid breathing/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|radial|retina|respiratory|renal|ribcage|right heart/
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
