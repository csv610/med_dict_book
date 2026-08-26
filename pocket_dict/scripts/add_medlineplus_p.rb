#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Paget disease of the bone' => 'Paget disease of bone is abnormal remodeling that produces enlarged, weakened, or deformed bone and may cause pain, fractures, hearing loss, or nerve compression.',
  'Pancreatic cancer' => 'Pancreatic cancer is malignant growth in pancreatic tissue, often presenting late with jaundice, abdominal or back pain, weight loss, or digestive symptoms.',
  'Pancreatitis - children' => 'Pancreatitis in children is inflammation of the pancreas causing abdominal pain, nausea, vomiting, and elevated pancreatic enzymes from structural, genetic, medication, infectious, or other causes.',
  'Panic disorder' => 'Panic disorder causes recurrent unexpected panic attacks and persistent concern or behavioral change related to further attacks, with episodes of intense fear and autonomic symptoms.',
  'Parkinson disease' => 'Parkinson disease is a progressive neurodegenerative disorder with bradykinesia and variable rest tremor, rigidity, gait dysfunction, nonmotor symptoms, and loss of dopaminergic neurons.',
  'Paronychia' => 'Paronychia is infection or inflammation of tissue around a fingernail or toenail, producing pain, redness, swelling, and sometimes a localized abscess.',
  'Paroxysmal supraventricular tachycardia (PSVT)' => 'Paroxysmal supraventricular tachycardia is an abrupt-onset and abrupt-ending rapid rhythm arising above the ventricles, causing palpitations, dizziness, chest discomfort, or syncope.',
  'Patent ductus arteriosus' => 'Patent ductus arteriosus is persistent fetal connection between the aorta and pulmonary artery, causing a left-to-right shunt with effects ranging from none to heart failure or pulmonary hypertension.',
  'Peptic ulcer disease - discharge' => 'Peptic ulcer disease discharge care addresses healing of a stomach or duodenal mucosal ulcer, medication adherence, bleeding warning signs, and avoidance of contributing irritants.',
  'Pelvic inflammatory disease (PID)' => 'Pelvic inflammatory disease is infection and inflammation of the upper female reproductive tract, often caused by sexually transmitted organisms and capable of causing infertility, ectopic pregnancy, or chronic pain.',
  'Pemphigus vulgaris' => 'Pemphigus vulgaris is an autoimmune blistering disorder in which antibodies disrupt epidermal cell adhesion, causing fragile blisters and painful erosions of skin and mucous membranes.',
  'Pericarditis' => 'Pericarditis is inflammation of the sac around the heart, causing sharp positional chest pain and sometimes pericardial effusion, tamponade, or constrictive disease.',
  'Peripheral artery disease - legs' => 'Peripheral artery disease of the legs is atherosclerotic reduction in arterial blood flow causing exertional claudication, diminished pulses, nonhealing wounds, or critical limb ischemia.',
  'Peripheral neuropathy' => 'Peripheral neuropathy is dysfunction or injury of peripheral nerves causing numbness, pain, burning, weakness, altered reflexes, or autonomic symptoms from metabolic, toxic, immune, hereditary, or other causes.',
  'Peritonitis' => 'Peritonitis is inflammation or infection of the peritoneum, often from perforation, surgery, ascites infection, or abdominal disease, and may cause severe pain, ileus, sepsis, and shock.',
  'Pernicious anemia' => 'Pernicious anemia is vitamin B12 deficiency caused by impaired intrinsic-factor-mediated absorption, producing megaloblastic anemia and possible neurologic injury.',
  'Pertussis' => 'Pertussis is a contagious Bordetella pertussis infection causing prolonged coughing fits, inspiratory whoop, vomiting, and dangerous apnea in infants.',
  'Phenylketonuria' => 'Phenylketonuria is an inherited inability to metabolize phenylalanine, allowing toxic accumulation that can impair brain development without early dietary treatment.',
  'Pheochromocytoma' => 'Pheochromocytoma is a catecholamine-producing tumor of chromaffin tissue, usually in the adrenal gland, causing episodic or sustained hypertension, headache, sweating, and palpitations.',
  'Pharyngitis - sore throat' => 'Pharyngitis is inflammation of the throat causing pain with swallowing, commonly from viral infection and sometimes from group A streptococcal infection or other causes.',
  'Pilonidal sinus disease' => 'Pilonidal sinus disease is a chronic tract or abscess in the natal cleft, often containing hair and causing pain, swelling, drainage, or recurrent infection.',
  'Pituitary apoplexy' => 'Pituitary apoplexy is sudden hemorrhage or infarction of a pituitary tumor, causing severe headache, visual loss, ophthalmoplegia, altered consciousness, and acute hormone deficiency.',
  'Placenta abruptio' => 'Placental abruption is premature separation of the placenta from the uterine wall, causing bleeding, abdominal pain, uterine tenderness, fetal compromise, or maternal shock.',
  'Placenta previa' => 'Placenta previa occurs when the placenta overlies or lies near the cervical opening, causing painless late-pregnancy bleeding and affecting delivery planning.',
  'Plague' => 'Plague is infection with Yersinia pestis, transmitted mainly by fleas or respiratory droplets and causing bubonic, septicemic, or pneumonic disease.',
  'Plantar fasciitis' => 'Plantar fasciitis is pain from overload and degeneration at the plantar fascia origin, classically worst with the first steps after rest and associated with prolonged standing or activity.',
  'Pleural effusion' => 'Pleural effusion is excess fluid between the lung and chest wall caused by heart failure, infection, malignancy, inflammation, or other systemic or local disease.',
  'Pneumocystis jirovecii pneumonia' => 'Pneumocystis jirovecii pneumonia is opportunistic fungal pneumonia, especially in advanced HIV or other immunosuppression, causing progressive breathlessness, dry cough, fever, and hypoxemia.',
  'Pneumonia' => 'Pneumonia is infection and inflammation of lung tissue, causing cough, fever, breathlessness, chest pain, and variable respiratory failure depending on organism and host.',
  'Polio' => 'Polio is infection with poliovirus, usually asymptomatic or mild but sometimes causing meningitis or irreversible asymmetric flaccid paralysis.',
  'Polycystic kidney disease' => 'Polycystic kidney disease is an inherited disorder with progressive renal cyst formation and possible hypertension, kidney failure, liver cysts, aneurysms, or other organ complications.',
  'Polycythemia vera' => 'Polycythemia vera is a myeloproliferative neoplasm causing excessive red-cell production and often elevated platelets or white cells, increasing risks of thrombosis, bleeding, and transformation.',
  'Polymyalgia rheumatica' => 'Polymyalgia rheumatica is an inflammatory disorder causing abrupt bilateral shoulder and hip girdle pain and stiffness in older adults, sometimes associated with giant cell arteritis.',
  'Post-traumatic stress disorder' => 'Post-traumatic stress disorder follows exposure to trauma and causes intrusive memories, avoidance, negative mood or cognition changes, hyperarousal, and functional impairment.',
  'Preeclampsia' => 'Preeclampsia is pregnancy-related hypertension with proteinuria or other maternal organ dysfunction after midpregnancy and can progress to seizures, stroke, liver injury, or placental complications.',
  'Psoriasis' => 'Psoriasis is a chronic immune-mediated inflammatory disease producing sharply demarcated scaly plaques and possible nail, joint, eye, or systemic involvement.',
  'Pulmonary embolism' => 'Pulmonary embolism is obstruction of a pulmonary artery, usually by venous thromboembolism, causing sudden breathlessness, chest pain, tachycardia, hypoxemia, or shock.',
  'Pyelonephritis' => 'Pyelonephritis is infection of the kidney and renal pelvis, usually ascending from the urinary tract, causing fever, flank pain, urinary symptoms, and possible sepsis.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|paint|lacquer|varnish|paraquat|pesticide|peppermint|phen|phencyclidine|piperonyl|piroxicam|plant|petroleum|pencil|poinsettia|poisoning/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|pet|assay|gram stain|electro|pap|platelet|polysomnograph|pbg|pylori|pH/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|radiation|brachy|laparosc|percutaneous|catheter|discharge|aftercare|self-care|feeding|injection|vaccin|endoscopy|arthroscopy|panniculectomy|pyloroplasty|amputation/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|palliative|pain|care|stress|emotions|nutrition|protective|occupational/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paleness|palatal|paraphimosis|paronychia|phobia|pica|petechia|pregnancy/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|pancreas/
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
