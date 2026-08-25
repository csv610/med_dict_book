#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Malaria' => 'Malaria is a mosquito-borne infection caused by Plasmodium parasites, producing fever and hemolysis and potentially progressing to cerebral disease, severe anemia, organ failure, or death.',
  'Malabsorption' => 'Malabsorption is impaired digestion or absorption of nutrients in the gastrointestinal tract, causing diarrhea, weight loss, anemia, vitamin deficiency, or bone disease.',
  'Malignant hypertension' => 'Malignant hypertension is a severe blood-pressure elevation with acute target-organ injury, such as encephalopathy, retinal damage, kidney failure, or heart failure.',
  'Malignant hyperthermia' => 'Malignant hyperthermia is a life-threatening inherited reaction to certain anesthetic agents, causing rapidly rising carbon dioxide, muscle rigidity, hyperthermia, acidosis, and rhabdomyolysis.',
  'Malnutrition' => 'Malnutrition includes inadequate, excessive, or imbalanced nutrient intake and can impair growth, immunity, wound healing, muscle function, and organ reserve.',
  'Mammogram' => 'A mammogram is a low-dose x-ray examination of breast tissue used for screening and evaluation of masses, asymmetry, calcifications, or other abnormalities.',
  'Maple syrup urine disease' => 'Maple syrup urine disease is an inherited inability to break down branched-chain amino acids, causing toxic metabolite accumulation, neurologic injury, and a characteristic sweet odor.',
  'Marfan syndrome' => 'Marfan syndrome is an inherited connective-tissue disorder associated with tall stature, aortic enlargement, lens dislocation, skeletal features, and variable heart and lung complications.',
  'Measles' => 'Measles is a highly contagious measles-virus infection causing fever, cough, conjunctivitis, and a spreading maculopapular rash, with possible pneumonia, encephalitis, or other complications.',
  'Meningitis' => 'Meningitis is inflammation of the membranes around the brain and spinal cord, caused by infection or noninfectious inflammation and presenting with headache, fever, neck stiffness, or altered mental status.',
  'Menopause' => 'Menopause is the permanent end of menstrual periods after loss of ovarian follicular activity, accompanied by hormonal changes and possible vasomotor, genitourinary, sleep, and bone effects.',
  'Metabolic acidosis' => 'Metabolic acidosis is reduction in blood bicarbonate or pH from added acid, impaired acid excretion, or bicarbonate loss, with respiratory compensation and variable systemic effects.',
  'Metabolic syndrome' => 'Metabolic syndrome is a cluster of central adiposity, elevated blood pressure, dysglycemia, high triglycerides, and low HDL cholesterol that increases cardiovascular and diabetes risk.',
  'Metastasis' => 'Metastasis is spread of malignant cells from a primary tumor to noncontiguous tissues through lymphatic, blood, or body-cavity routes, forming secondary tumors.',
  'Migraine' => 'Migraine is a neurologic disorder causing recurrent attacks of moderate or severe headache with nausea, light or sound sensitivity, and sometimes aura or focal neurologic symptoms.',
  'Miscarriage' => 'Miscarriage is spontaneous loss of a pregnancy before fetal viability, with symptoms ranging from bleeding and cramping to passage of tissue or no symptoms on ultrasound.',
  'Multiple sclerosis' => 'Multiple sclerosis is an immune-mediated central nervous system disease with episodes or progression of demyelinating neurologic dysfunction affecting vision, sensation, strength, coordination, or cognition.',
  'Mumps' => 'Mumps is a contagious paramyxovirus infection causing painful salivary-gland swelling and fever, with possible meningitis, orchitis, pancreatitis, or hearing complications.',
  'Myasthenia gravis' => 'Myasthenia gravis is an autoimmune disorder of neuromuscular transmission causing fluctuating fatigable weakness, commonly affecting eye, facial, swallowing, limb, or respiratory muscles.',
  'Myocarditis' => 'Myocarditis is inflammation of heart muscle, often infectious or immune-mediated, that can cause chest pain, arrhythmias, heart failure, or sudden cardiac dysfunction.',
  'Myocardial infarction' => 'Myocardial infarction is irreversible heart-muscle injury from prolonged inadequate coronary blood flow and requires urgent evaluation and reperfusion-oriented treatment.',
  'Myelofibrosis' => 'Myelofibrosis is a myeloproliferative neoplasm in which abnormal marrow signaling causes fibrosis, disordered blood production, anemia, enlarged spleen, and variable constitutional symptoms.',
  'Myelomeningocele' => 'Myelomeningocele is an open neural-tube defect in which spinal cord and meninges protrude through a vertebral opening, causing variable paralysis, sensory loss, bladder dysfunction, and hydrocephalus.',
  'Myositis' => 'Myositis is inflammation or immune-mediated injury of skeletal muscle, producing weakness, pain, elevated muscle enzymes, and sometimes swallowing, lung, or skin involvement.',
  'Mpox' => 'Mpox is a zoonotic infection caused by monkeypox virus, producing fever, lymph-node enlargement, and a characteristic rash or lesions that can occur on skin, mouth, or genital areas.',
  'Multiple myeloma' => 'Multiple myeloma is a plasma-cell cancer causing monoclonal protein production and possible bone lesions, anemia, kidney injury, hypercalcemia, and recurrent infection.',
  'Mucormycosis' => 'Mucormycosis is an invasive infection by Mucorales fungi, typically affecting immunocompromised people and causing rapidly destructive sinus, orbital, pulmonary, cutaneous, or disseminated disease.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|oil|cleaner|polish|mercur|methanol|methadone|morphine|mouthwash|methyl|marijuana|millipede/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|diffusion|pet|assay|response|electrophoresis|monitor|imaging|mammogram|stain|screening|scintiscan/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|amputation|repair|insertion|therapy|laser|laparoscop|mastectomy|mastoidectomy|ventilator|catheter|discharge|aftercare|self-care|feeding|injection|treatment|vaccin|endoscopy|arthroscopy/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|nutrition|management|prevention|support|exercise|healthy|home|living|learn|care|habits|stress|feelings|discharge|choices|weight|organize|safety|monitoring|education|medicines/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|lordosis|back pain|pressure|potassium|sodium|calcium|sugar|cholesterol|migraine|myel|mucopolysacchar|mucosa|muscle|myopathy|menopause|mastoiditis|malabsorption/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|iron|lead|lower|long bone|lateral|macrophage|mucosa|metabol|melanin|medial/
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
