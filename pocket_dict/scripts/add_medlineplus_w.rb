#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Waardenburg syndrome' => 'Waardenburg syndrome is an inherited disorder affecting pigmentation and neural-crest development, associated with hearing loss, distinctive facial features, and pigment differences.',
  'Waldenstrom macroglobulinemia' => 'Waldenstrom macroglobulinemia is a lymphoplasmacytic cancer producing monoclonal IgM, which can cause anemia, hyperviscosity, neuropathy, lymphadenopathy, or organ effects.',
  'Wernicke-Korsakoff syndrome' => 'Wernicke-Korsakoff syndrome is neurologic injury from thiamine deficiency, with acute confusion, eye-movement abnormalities, ataxia, and possible persistent memory impairment.',
  'West Nile virus infection' => 'West Nile virus infection is a mosquito-borne illness ranging from fever and body aches to neuroinvasive meningitis, encephalitis, weakness, or paralysis.',
  'Whipple disease' => 'Whipple disease is systemic infection with Tropheryma whipplei, often causing malabsorption, weight loss, joint symptoms, abdominal complaints, lymphadenopathy, or neurologic disease.',
  'Williams syndrome' => 'Williams syndrome is a genetic developmental disorder associated with characteristic facial features, cardiovascular disease, distinctive behavior, developmental differences, and elevated calcium in some infants.',
  'Wilms tumor' => 'Wilms tumor is the most common kidney cancer of childhood, usually presenting as an abdominal mass and treated with surgery, chemotherapy, and sometimes radiation.',
  'Wilson disease' => 'Wilson disease is an inherited disorder of copper transport causing copper accumulation in liver, brain, eyes, and other tissues, with hepatic, neurologic, psychiatric, or movement symptoms.',
  'Wolff-Parkinson-White syndrome (WPW)' => 'Wolff-Parkinson-White syndrome is pre-excitation through an extra atrioventricular pathway that can cause episodes of supraventricular tachycardia and rarely dangerous ventricular rhythms.',
  'Warts' => 'Warts are benign epidermal growths caused by human papillomavirus, spreading by contact and varying in appearance by site and viral type.',
  'Weakness' => 'Weakness is reduced force generation that may reflect muscle, nerve, neuromuscular-junction, brain, spinal cord, metabolic, systemic, or functional disease.',
  'Wheezing' => 'Wheezing is a musical sound from narrowed lower airways, commonly caused by asthma, infection, chronic lung disease, allergy, or an inhaled foreign body.',
  'Weight loss - unintentional' => 'Unintentional weight loss is reduction in body weight without planned dietary or activity change and may result from malignancy, endocrine disease, infection, gastrointestinal disease, medication, or mood disorder.',
  'Wrist pain' => 'Wrist pain may arise from trauma, tendon or ligament injury, arthritis, nerve compression, inflammation, infection, or referred pain and is evaluated by location, motion, swelling, and neurologic findings.',
  'Waterhouse-Friderichsen syndrome' => 'Waterhouse-Friderichsen syndrome is adrenal hemorrhage and acute adrenal failure associated with overwhelming sepsis, classically meningococcal infection, causing shock and coagulopathy.',
  'Water safety and drowning' => 'Water safety and drowning prevention rely on supervision, barriers, life jackets, swimming skills, safe rescue practices, and rapid emergency response to respiratory arrest.',
  'Whole breast radiation therapy' => 'Whole breast radiation therapy treats remaining breast tissue after breast-conserving surgery to reduce local recurrence risk, with planned dosing and monitoring for skin and tissue effects.',
  'Wrist arthroscopy' => 'Wrist arthroscopy uses a small camera and instruments through portals to diagnose or treat cartilage, ligament, synovial, or other wrist problems.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|wart remover|watercolor|wax|window cleaner|wood stain|washer fluid|wasp sting/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|examination|lamp|wbc/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|radiation|arthroscopy|repair|replacement|transplant|dressing|aftercare|self-care|care center|visit|using|wearing|working|exercise|training|weight-loss|palliative|birth plan|delivery|emergency room/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|weight|bone loss|cancer|health|pregnancy|drinking|medicine|diarrhea|nausea|incontinence|fever|labor|personal trainer|heart disease/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paraphimosis|paronychia|phobia|pica|pregnancy|rheumatoid|retinal|renal|respiratory|ricket|ringworm|rosacea|rotator|rabies|sepsis|shock|sickle|sinus|sleep|scoliosis|scler|schizo|scabies|sarcoid|salmonella|staph|strep|stomach|shoulder|spinal|spondyl|splen|sprain|stroke|systemic|wernicke|west nile|whipple|wilms|wilson|williams|weakness|wheezing|watery eyes|wrinkle|wrist pain|walking abnormal|weight gain|weight loss/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|radial|retina|rib|salivary|sclera|scrotum|skeleton|spine|spleen|sputum|small bowel|testes|tibia|tongue|tooth|trachea|tendon|tarsal|thoracic|thymus|throat|white matter|wrist|water|weight/
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
