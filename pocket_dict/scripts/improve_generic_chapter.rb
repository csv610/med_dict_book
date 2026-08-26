#!/usr/bin/env ruby

MARKER = /(?:medical term used to describe a clinical, biological, or healthcare concept|medical term describing the named concept|is a disease, symptom, syndrome, or clinical finding|is a medical procedure, treatment, or care topic|is a healthcare or clinical-care term|is a biological, genetic, biochemical, or chemical term used in medicine|is a diagnostic or laboratory method used to evaluate|is a biological organism or infectious agent|concerns [^;]+; clinical use depends on|concerns [^;]+; its medical significance)/i

def definition(term)
  name = term.strip
  t = name.downcase
  return "#{name} is a medication or pharmacologic agent; its indication, dose, interactions, contraindications, and adverse effects depend on the specific product and patient." if t.match?(/cillin|mycin|cycline|azole|pril|sartan|olol|statin|caine|mab|nib|vir|zepam|zole|drug|insulin|morphine|baclofen|ibuprofen|ketamine|lacosamide|levothyroxine/)
  return "#{name} is a diagnostic or laboratory method used to evaluate a clinical question; interpretation depends on the specimen or body site, method, reference range, and patient context." if t.match?(/test|assay|analysis|culture|screen|scan|mri|x-ray|biopsy|count|measurement|monitor|panel|pcr|electrophoresis|titer|stain|imaging/)
  return "#{name} is a medical procedure, treatment, device, or care topic; indications, benefits, risks, and follow-up depend on the patient and clinical goal." if t.match?(/surgery|surgical|repair|removal|replacement|transplant|insertion|implant|injection|infusion|therapy|treatment|procedure|resection|excision|transfusion|dialysis|rehabilitation|aftercare|discharge|care|management|exercise/)
  return "#{name} is a biological organism or infectious agent; its clinical importance depends on the species, host, site, exposure, and evidence of infection or colonization." if t.match?(/virus|bacter|fung|parasite|protozo|helminth|microorgan|species|genus|coccus|mycota/)
  return "#{name} is a biological, genetic, biochemical, or chemical term used in medicine; its significance depends on its structure, function, concentration, pathway, or clinical context." if t.match?(/gene|genomic|genetic|mutation|chromosome|protein|enzyme|receptor|hormone|acid|lipid|vitamin|mineral|ion|molecule|chemical|metabol|cytokine|antibody|immunoglobulin|cell|tissue|molecular/)
  return "#{name} is an anatomical or physiologic term describing a body structure or function; its clinical meaning depends on its location, role, and associated findings." if t.match?(/bone|muscle|nerve|artery|vein|gland|organ|cell|tissue|skin|heart|lung|liver|kidney|brain|eye|ear|nose|mouth|throat|stomach|intestin|colon|uter|ovary|testis|breast|head|neck|limb|joint|spine|vertebra|cranial|anatom|region|cavity|membrane|duct|vessel/)
  return "#{name} is a disease, symptom, syndrome, or clinical finding; diagnosis and management depend on its characteristic features, causes, severity, examination, and appropriate investigations." if t.match?(/disease|disorder|syndrome|cancer|carcinoma|sarcoma|leukemia|lymphoma|tumor|neoplasm|infection|inflammation|itis$|emia$|osis$|iasis$|pathy$|algia$|pain|fever|rash|bleed|hemorrhage|paralysis|deficien|failure|injury|fracture|ulcer|edema|seizure|headache|nausea|cough|diabetes|anemia|obesity|allergy|phobia|psychosis|depression|mania|insomnia|blindness|itch|swelling|spasm|atrophy|hypertrophy|hyper|hypo/)
  return "#{name} is a healthcare or clinical-care term; its appropriate use depends on the patient’s condition, goals, risks, available evidence, and professional assessment." if t.match?(/health|medical|patient|physician|nurse|hospital|hospice|nutrition|diet|prevention|risk|consent|anesthesia|occupational|public/)
  "#{name} is a medical term describing the named concept; its precise interpretation depends on its defining features, associated findings, and clinical context."
end

file = ARGV.fetch(0)
text = File.read(file)
pattern = /^\\medterm\{([^}]*)\}(?:(?!^\\medterm\{).)*?^\\textbf\{Synonyms\}:/m
changed = 0
text = text.gsub(pattern) do |block|
  title = Regexp.last_match(1)
  if block.match?(MARKER)
    changed += 1
    "\\medterm{#{title}} #{definition(title)}\n\n\\textbf{Synonyms}:"
  else
    block
  end
end
File.write(file, text)
puts "#{file}: replaced=#{changed}"
