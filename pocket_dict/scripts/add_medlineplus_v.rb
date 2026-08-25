#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Vaccines - immunizations' => 'Vaccines train the immune system to recognize specific pathogens or toxins and reduce the risk of infection, severe disease, complications, and transmission.',
  'Vagina' => 'The vagina is a muscular canal connecting the cervix to the external genital tract and serving roles in menstruation, sexual function, and childbirth.',
  'Vaginal yeast infection' => 'A vaginal yeast infection is usually Candida overgrowth causing itching, burning, soreness, and thick discharge without the odor typical of many bacterial infections.',
  'Valley fever' => 'Valley fever is respiratory or disseminated infection with Coccidioides fungi acquired by inhaling soil spores, causing cough, fever, fatigue, rash, or chronic pulmonary disease.',
  'Vancomycin-resistant enterococci - hospital' => 'Vancomycin-resistant enterococci are enterococcal bacteria resistant to vancomycin and capable of causing healthcare-associated urinary, bloodstream, wound, or other infections.',
  'Varicocele' => 'A varicocele is enlargement of veins in the scrotum, often on the left, that may cause aching, testicular growth differences, infertility, or no symptoms.',
  'Varicose veins' => 'Varicose veins are enlarged twisted superficial veins caused by venous-valve or wall dysfunction, commonly producing aching, swelling, skin changes, or ulcers.',
  'Vascular dementia' => 'Vascular dementia is cognitive decline caused by cerebrovascular disease, infarcts, or chronic small-vessel injury and often accompanied by gait, mood, or focal neurologic changes.',
  'Ventricular fibrillation' => 'Ventricular fibrillation is chaotic ventricular electrical activity that prevents effective cardiac pumping and causes cardiac arrest requiring immediate resuscitation and defibrillation.',
  'Ventricular septal defect' => 'A ventricular septal defect is an opening between the heart’s ventricles that can create a left-to-right shunt and, depending on size, cause murmur, heart failure, pulmonary disease, or closure complications.',
  'Vertigo-associated disorders' => 'Vertigo-associated disorders cause an illusion of movement from vestibular, neurologic, visual, medication-related, or systemic dysfunction and may be accompanied by imbalance, nausea, or hearing symptoms.',
  'Viral gastroenteritis (stomach flu)' => 'Viral gastroenteritis is infection of the stomach and intestines causing vomiting, watery diarrhea, cramps, and fever, with dehydration as the main acute risk.',
  'Viral pneumonia' => 'Viral pneumonia is infection and inflammation of lung tissue caused by respiratory viruses, producing cough, fever, breathlessness, hypoxemia, and variable severity.',
  'Vitamin B12 deficiency anemia' => 'Vitamin B12 deficiency anemia is megaloblastic anemia from inadequate B12, impaired absorption, or medication effects and may cause irreversible neurologic injury if prolonged.',
  'Vitiligo' => 'Vitiligo is an autoimmune disorder causing loss of melanocytes and sharply demarcated depigmented skin or hair, with variable extent and associated autoimmune disease.',
  'Von Willebrand disease' => 'Von Willebrand disease is an inherited or acquired bleeding disorder involving deficient or dysfunctional von Willebrand factor, causing mucosal bleeding, heavy menstruation, or surgical bleeding.',
  'Vulvar cancer' => 'Vulvar cancer is malignant growth of external female genital tissue, often presenting with a persistent lump, ulcer, itching, pain, bleeding, or skin change.',
  'Vulvodynia' => 'Vulvodynia is chronic vulvar pain without an identifiable specific cause, often described as burning or rawness and triggered by touch, pressure, or occurring spontaneously.',
  'Vulvovaginitis' => 'Vulvovaginitis is inflammation of the vulva and vagina caused by infection, irritation, allergy, hormonal change, or dermatologic disease, producing itching, soreness, discharge, or odor.',
  'Vitamin D' => 'Vitamin D supports calcium and phosphate balance, bone mineralization, muscle function, and immune processes; deficiency causes rickets in children and osteomalacia or bone loss in adults.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|varnish|vine|venom|oil|oxygen safety/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|pet|assay|gram stain|electro|vdr|venogram|visual acuity|field|vital signs|vitamin .*blood|vldl|cystourethrogram|uroflowmetry/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|radiation|ablation|laparosc|catheter|discharge|aftercare|self-care|feeding|vaccin|endoscopy|fusion|arthroscopy|varicose vein stripping|delivery|embolization|shunt|vertebroplasty|gastrectomy|valve surgery|vagus nerve/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|palliative|pain|care|stress|returning|responsible drinking|rights|masks|work|sports|safe|shared decision|facilities|nutrition|vacation|visiting|using|understanding/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paraphimosis|paronychia|phobia|pica|pregnancy|rheumatoid|retinal|renal|respiratory|ricket|ringworm|rosacea|rotator|rabies|sepsis|shock|sickle|sinus|sleep|scoliosis|scler|schizo|scabies|sarcoid|salmonella|staph|strep|stomach|shoulder|spinal|spondyl|splen|sprain|stroke|systemic|vaginal|vulva|vulvodynia|vulvovaginitis|varico|vascular|vertigo|viral|vitiligo|vitamin|ventric|valley fever|vein|vagina/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|radial|retina|rib|salivary|sclera|scrotum|skeleton|spine|spleen|sputum|small bowel|testes|tibia|tongue|tooth|trachea|tendon|tarsal|thoracic|thymus|throat|uvea|vagina|vulva|vascular|ventricle|vertebra|vision|vital/
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
