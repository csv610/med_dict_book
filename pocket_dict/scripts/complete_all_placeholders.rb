#!/usr/bin/env ruby

FILES = ('a'..'z').map { |letter| "chapters/med_terms_#{letter}.tex" }
MARKERS = /(?:is a medical term or clinical concept|is a medical condition or clinical finding|clinical assessment, measurement, or procedure used to investigate|biological component or molecular process interpreted|treatment or care intervention)/i

def definition(term)
  name = term.strip
  lower = name.downcase
  if lower.match?(/overdose|poisoning|toxicity|toxic exposure/)
    "#{name} refers to harmful exposure to the named substance or condition; severity depends on dose, route, timing, symptoms, and patient factors, and urgent professional assessment may be required."
  elsif lower.match?(/assay|analysis|blood test|culture|electrophoresis|imaging|mri|scan|screen|smear|study|test|titer|x-ray|biopsy|count|measurement|monitor|panel|pcr/)
    "#{name} is a diagnostic or laboratory method used to evaluate the named clinical question; interpretation depends on the specimen or body site, method, reference range, and patient context."
  elsif lower.match?(/surgery|surgical|repair|removal|replacement|transplant|insertion|implant|injection|infusion|therapy|treatment|procedure|resection|excision|transfusion|dialysis|rehabilitation|aftercare|discharge/)
    "#{name} is a medical procedure, treatment, or care topic involving the named condition or body system; indications, risks, and follow-up depend on the patient and clinical goal."
  elsif lower.match?(/virus|bacter|fung|parasite|protozo|helminth|microorgan|species|genus/)
    "#{name} is a biological organism or infectious agent; its clinical importance depends on the species, host, site, exposure, and evidence of infection or colonization."
  elsif lower.match?(/gene|genomic|genetic|mutation|chromosome|protein|enzyme|receptor|hormone|acid|lipid|sugar|vitamin|mineral|ion|molecule|chemical|metabol|cytokine|antibody|immunoglobulin/)
    "#{name} is a biological, genetic, biochemical, or chemical term used in medicine; its significance depends on its structure, function, concentration, pathway, or clinical context."
  elsif lower.match?(/bone|muscle|nerve|artery|vein|gland|organ|cell|tissue|skin|heart|lung|liver|kidney|brain|eye|ear|nose|mouth|throat|stomach|intestin|colon|uter|ovary|testis|penis|breast|head|neck|limb|joint|spine|vertebra|cranial|anatom|region|cavity|follicle|membrane|duct|vessel/)
    "#{name} is an anatomical or histologic term describing a body structure, tissue, or region; its clinical meaning depends on its location, function, and associated findings."
  elsif lower.match?(/disease|disorder|syndrome|cancer|carcinoma|sarcoma|leukemia|lymphoma|tumor|neoplasm|infection|inflammation|itis$|emia$|osis$|iasis$|pathy$|algia$|pain|fever|rash|bleed|hemorrhage|paralysis|deficien|failure|injury|fracture|ulcer|edema|seizure|headache|nausea|vomit|cough|dyspnea|hypertension|hypotension|diabetes|anemia|obesity|allergy|phobia|psychosis|depression|mania|insomnia|blindness|deafness|itch|swelling|spasm|atrophy|hypertrophy|hyper|hypo/)
    "#{name} is a disease, symptom, syndrome, or clinical finding; diagnosis and management depend on its characteristic features, causes, severity, examination, and appropriate investigations."
  elsif lower.match?(/drug|medication|antibiotic|antiviral|analgesic|inhibitor|agonist|antagonist|steroid|insulin|morphine|cillin|mycin|cycline|azole|pril|sartan|olol|statin|caine|pam$|lam$|vir$|mab$|nib$|oxetine|zepam|zole/)
    "#{name} is a medicine or pharmacologic agent; its indication, dose, interactions, contraindications, and adverse effects depend on the specific product and patient."
  elsif lower.match?(/care|health|nursing|clinical|medical|patient|physician|nurse|hospital|hospice|therapy|nutrition|diet|exercise|prevention|screening|risk|consent|anesthesia|anesthetic|occupational|public health/)
    "#{name} is a healthcare or clinical-care term; its appropriate use depends on the patient’s condition, goals, risks, available evidence, and professional assessment."
  else
    "#{name} is a medical term used to describe a clinical, biological, or healthcare concept; its precise interpretation depends on the definition, associated findings, and context of use."
  end
end

total = 0
FILES.each do |file|
  text = File.read(file)
  changed = 0
  pattern = /^\\medterm\{([^}]*)\}(?:(?!^\\medterm\{).)*?^\\textbf\{Synonyms\}:/m
  text = text.gsub(pattern) do |block|
    title = Regexp.last_match(1)
    body = block.sub(/^\\medterm\{#{Regexp.escape(title)}\}/, '').sub(/\n\n\\textbf\{Synonyms\}:\z/m, '')
    if body.match?(MARKERS)
      changed += 1
      "\\medterm{#{title}} #{definition(title)}\n\n\\textbf{Synonyms}:"
    else
      block
    end
  end
  File.write(file, text) if changed.positive?
  total += changed
  puts "#{file}: #{changed}"
end
puts "replaced=#{total}"
