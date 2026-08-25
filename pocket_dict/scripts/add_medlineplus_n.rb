#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Narcolepsy' => 'Narcolepsy is a chronic sleep-wake disorder with excessive daytime sleepiness and, in some people, cataplexy, sleep paralysis, and hypnagogic hallucinations.',
  'Nasal polyps' => 'Nasal polyps are soft benign inflammatory growths from the nasal or sinus lining that can obstruct airflow, reduce smell, and worsen chronic rhinosinusitis.',
  'Nausea and vomiting – adults' => 'Nausea and vomiting in adults can result from gastrointestinal disease, infection, medication, pregnancy, metabolic illness, neurologic disease, or obstruction; dehydration and alarm features guide urgency.',
  'Nearsightedness' => 'Nearsightedness, or myopia, occurs when light focuses in front of the retina, causing distant blur that is corrected with lenses, contact lenses, or selected procedures.',
  'Necrotizing enterocolitis' => 'Necrotizing enterocolitis is an inflammatory and ischemic intestinal disease of newborns, especially premature infants, that can cause feeding intolerance, abdominal distention, perforation, and sepsis.',
  'Necrotizing soft tissue infection' => 'Necrotizing soft tissue infection is rapidly progressive infection of fascia and subcutaneous tissue causing severe pain, swelling, systemic toxicity, and tissue death that requires emergency surgery and antibiotics.',
  'Neonatal abstinence syndrome' => 'Neonatal abstinence syndrome is withdrawal in a newborn after prenatal exposure to opioids or other substances, causing irritability, tremor, feeding difficulty, vomiting, diarrhea, and autonomic symptoms.',
  'Neonatal sepsis' => 'Neonatal sepsis is systemic infection in a newborn, which may present subtly with temperature instability, poor feeding, respiratory distress, lethargy, or circulatory collapse.',
  'Nephrotic syndrome' => 'Nephrotic syndrome is heavy urinary protein loss with low serum albumin, edema, and altered lipids, caused by glomerular diseases or systemic disorders.',
  'Neuroblastoma' => 'Neuroblastoma is a childhood cancer of immature sympathetic nervous-system cells, commonly arising in the adrenal or paraspinal region and ranging from spontaneously resolving to aggressive disease.',
  'Neurofibromatosis 2' => 'Neurofibromatosis type 2 is an inherited tumor-predisposition disorder characterized especially by bilateral vestibular schwannomas and possible meningiomas, ependymomas, cataracts, or neuropathy.',
  'Neurofibromatosis-1' => 'Neurofibromatosis type 1 is an inherited condition featuring café-au-lait macules, neurofibromas, axillary freckling, optic pathway gliomas, bone lesions, and variable learning or vascular complications.',
  'Neuromyelitis optica spectrum disorder' => 'Neuromyelitis optica spectrum disorder is an autoimmune central nervous system disease causing attacks of optic neuritis, longitudinally extensive myelitis, or related brainstem and diencephalic syndromes.',
  'Newborn jaundice' => 'Newborn jaundice is yellow discoloration from elevated bilirubin; physiologic patterns are common, but early, severe, rapidly rising, or conjugated jaundice requires evaluation for serious disease.',
  'Niacin' => 'Niacin is vitamin B3 required for redox reactions and energy metabolism; deficiency causes pellagra, while high-dose supplements can cause flushing, liver injury, and glucose or uric-acid effects.',
  'Nicotine poisoning' => 'Nicotine poisoning causes early nausea, vomiting, salivation, dizziness, tachycardia, and agitation followed by weakness, bradycardia, seizures, or respiratory failure in severe exposure.',
  'Niemann-Pick disease' => 'Niemann-Pick disease comprises inherited lysosomal lipid-storage disorders causing variable liver, spleen, lung, blood, and neurologic disease.',
  'Non-Hodgkin lymphoma' => 'Non-Hodgkin lymphoma is a diverse group of lymphoid cancers that may present with lymph-node enlargement, extranodal masses, fever, night sweats, weight loss, or cytopenias.',
  'Non-small cell lung cancer' => 'Non-small cell lung cancer is the major group of lung carcinomas other than small-cell cancer, classified by histology and molecular features to guide stage-specific treatment.',
  'Nonalcoholic fatty liver disease' => 'Nonalcoholic fatty liver disease is excess hepatic fat not primarily caused by alcohol and can progress from steatosis to steatohepatitis, fibrosis, cirrhosis, or liver cancer.',
  'Noonan syndrome' => 'Noonan syndrome is a genetic developmental disorder associated with characteristic facial features, short stature, congenital heart disease, chest differences, and variable learning or bleeding problems.',
  'Normal pressure hydrocephalus' => 'Normal pressure hydrocephalus is impaired cerebrospinal-fluid circulation associated with gait disturbance, cognitive decline, and urinary symptoms despite intermittently or modestly elevated measured pressure.',
  'Nosebleed' => 'A nosebleed, or epistaxis, is bleeding from nasal blood vessels caused by dryness, trauma, inflammation, medications, hypertension, vascular disease, or less commonly a tumor or bleeding disorder.',
  'Nuclear stress test' => 'A nuclear stress test combines a radiotracer with exercise or medication stress to compare myocardial blood flow at rest and stress, helping assess ischemia and cardiac function.',
  'Numbness and tingling' => 'Numbness and tingling are altered sensations that may result from nerve compression, neuropathy, spinal disease, circulation problems, metabolic disorders, medications, or brain disease.',
  'Nummular eczema' => 'Nummular eczema is an inflammatory skin disorder producing intensely itchy coin-shaped patches, often worsened by dry skin, irritation, or barrier disruption.',
  'Nut allergies' => 'Nut allergy is an immune-mediated reaction to tree nuts or peanuts that can cause hives, gastrointestinal or respiratory symptoms, or life-threatening anaphylaxis.',
  'Nystagmus' => 'Nystagmus is involuntary rhythmic eye movement that can arise from vestibular disease, neurologic disorders, impaired vision, medication, or normal infant development.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|polish|naphthalene|naproxen|nicotine|nitric|nitroglycerin|insecticide/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|nuclear|screening|stain|electro|conduction|translucency|monitor/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|feeding|catheter|discharge|aftercare|self-care|care|spray|tube|vaccin|endoscopy|maneuver|infant|newborn|nutrition/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|staff|consultant|precautions|allerg|sleep|development/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|hydrocephalus|neuropathy|neuro|necrot|numbness|tingling|nausea|vomiting|jaundice|nail|nose|natal|nystagmus/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|lipid|iron|lead|nasal|neck|neonate|neuron|nutrition|nurse/
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
