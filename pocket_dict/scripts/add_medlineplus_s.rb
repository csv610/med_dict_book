#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Salmonella enterocolitis' => 'Salmonella enterocolitis is intestinal infection causing diarrhea, fever, abdominal cramps, and sometimes bacteremia after contaminated food, water, or animal exposure.',
  'Sarcoidosis' => 'Sarcoidosis is multisystem granulomatous inflammation, commonly affecting lungs and lymph nodes but also skin, eyes, heart, nerves, and other organs.',
  'Scabies' => 'Scabies is infestation by Sarcoptes scabiei mites, causing intense nighttime itching and a characteristic rash or burrows, with spread through close contact.',
  'Scarlet fever' => 'Scarlet fever is toxin-mediated illness from group A Streptococcus, usually accompanying pharyngitis and causing fever, sore throat, and a fine rough-textured rash.',
  'Schizophrenia' => 'Schizophrenia is a chronic psychotic disorder involving delusions, hallucinations, disorganized thought or behavior, negative symptoms, and impaired functioning.',
  'Sciatica' => 'Sciatica is radiating leg pain or sensory symptoms along a lumbosacral nerve-root distribution, commonly from disk herniation or spinal narrowing.',
  'Scleroderma' => 'Scleroderma is an autoimmune connective-tissue disease causing skin thickening and variable fibrosis or vascular injury in the gastrointestinal tract, lungs, kidneys, or heart.',
  'Seizures' => 'Seizures are transient episodes of abnormal excessive brain electrical activity causing changes in awareness, movement, sensation, behavior, or autonomic function.',
  'Sepsis' => 'Sepsis is life-threatening organ dysfunction caused by a dysregulated response to infection, with possible shock, respiratory failure, kidney injury, coagulation abnormalities, or altered consciousness.',
  'Septic arthritis' => 'Septic arthritis is infection within a joint, usually bacterial, causing acute pain, swelling, warmth, restricted motion, fever, and possible rapid cartilage destruction.',
  'Serotonin syndrome' => 'Serotonin syndrome is toxic excess serotonergic activity caused by medicines or interactions, producing agitation, sweating, tremor, hyperreflexia, clonus, fever, and sometimes seizures or shock.',
  'Severe acute respiratory syndrome (SARS)' => 'Severe acute respiratory syndrome is a viral respiratory illness caused by SARS coronavirus, with fever and pneumonia that may progress to severe respiratory failure.',
  'Shingles' => 'Shingles is reactivation of varicella-zoster virus in a sensory nerve ganglion, producing painful grouped vesicles in a dermatomal pattern and possible persistent neuralgia.',
  'Shock' => 'Shock is inadequate tissue perfusion and oxygen delivery, caused by hypovolemia, pump failure, obstruction, or abnormal vascular tone and leading to cellular and organ injury.',
  'Sickle cell disease' => 'Sickle cell disease is an inherited hemoglobin disorder causing red-cell sickling, chronic hemolytic anemia, painful vaso-occlusion, acute chest syndrome, stroke, infection risk, and organ damage.',
  'Sinusitis' => 'Sinusitis is inflammation or infection of the paranasal sinuses causing congestion, facial pressure, nasal discharge, reduced smell, cough, or headache.',
  'Sjogren syndrome' => 'Sjogren syndrome is autoimmune destruction or dysfunction of exocrine glands causing dry eyes and mouth, with possible joint, lung, kidney, nerve, or lymphoproliferative disease.',
  'Sleep apnea' => 'Sleep apnea is repeated cessation or reduction of breathing during sleep, causing oxygen fluctuation, fragmented sleep, daytime sleepiness, cardiovascular risk, or developmental effects.',
  'Smallpox' => 'Smallpox was a severe contagious variola-virus disease with fever and a distinctive progressive pustular rash; global eradication was achieved through vaccination.',
  'Spinal cord injury' => 'Spinal cord injury damages neural tissue and can cause motor, sensory, autonomic, respiratory, and bladder or bowel dysfunction below the affected level.',
  'Spinal stenosis' => 'Spinal stenosis is narrowing of the spinal canal or neural foramina that can compress the cord or nerve roots, causing pain, claudication, weakness, numbness, or myelopathy.',
  'Sprains' => 'Sprains are ligament injuries caused by excessive stretching or tearing, producing pain, swelling, bruising, and variable joint instability.',
  'Stroke' => 'Stroke is sudden neurologic dysfunction from interrupted cerebral blood flow or bleeding, causing focal deficits and requiring urgent evaluation for reperfusion or hemorrhage management.',
  'Systemic lupus erythematosus' => 'Systemic lupus erythematosus is an autoimmune disease with variable inflammation and tissue injury involving skin, joints, kidneys, blood, nervous system, lungs, or heart.',
  'Tetanus' => 'Tetanus is toxin-mediated neurologic disease caused by Clostridium tetani entering a wound, producing painful muscle rigidity, spasms, autonomic instability, and respiratory failure.',
  'Tuberculosis' => 'Tuberculosis is infection with Mycobacterium tuberculosis, usually affecting lungs but potentially disseminating to lymph nodes, meninges, bones, kidneys, or other organs.',
  'Squamous cell skin cancer' => 'Squamous cell skin cancer is a malignant keratinocyte tumor often arising on sun-exposed skin and capable of local invasion or metastasis, especially when high risk.',
  'Stomach cancer' => 'Stomach cancer is malignant growth of gastric tissue, often presenting late with weight loss, early satiety, pain, anemia, nausea, or bleeding.',
  'Suicide prevention' => 'Suicide prevention involves recognizing warning signs, reducing access to lethal means, providing immediate support, and connecting a person at risk with emergency or crisis care.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|sachet|sassafras|secobarbital|shaving|shellac|sodium .*poisoning|solder|sports cream|starch|solvent|snake bite|scorpion|sting/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|pet|assay|gram stain|electro|rbc|reticulocyte|sialogram|sigmoidoscopy|slit-lamp|sputum|serology|screening|smear|exam|monitor/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|radiation|ablation|laparosc|catheter|discharge|aftercare|self-care|feeding|vaccin|endoscopy|fusion|arthroscopy|septoplasty|graft|amputation|splenectomy|stimulation/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|palliative|pain|care|stress|returning|responsible drinking|rights|masks|work|sports|safe|shared decision|facilities|nutrition|self exam|sleep/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paraphimosis|paronychia|phobia|pica|pregnancy|rheumatoid|retinal|renal|respiratory|ricket|ringworm|rosacea|rotator|rabies|sepsis|shock|sickle|sinus|sleep|scoliosis|scler|schizo|scabies|sarcoid|salmonella|staph|strep|stomach|shoulder|spinal|spondyl|splen|sprain|stroke|systemic|syringomyelia/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|radial|retina|rib|salivary|sclera|scrotum|skeleton|spine|spleen|sputum|skin|small bowel/
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
