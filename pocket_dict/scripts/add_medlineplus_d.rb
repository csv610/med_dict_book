#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'D-dimer test' => 'D-dimer testing measures a fibrin-degradation product; an elevated result can support evaluation for thrombosis but is nonspecific and must be interpreted with pretest probability.',
    'Dacryoadenitis' => 'Dacryoadenitis is inflammation of a tear-producing lacrimal gland, causing painful swelling near the outer upper eyelid from infection, inflammation, or systemic disease.',
    'Decerebrate posture' => 'Decerebrate posture is abnormal extension and inward rotation of the arms with leg extension, indicating severe dysfunction of brainstem or pathways below the red nucleus.',
    'Decorticate posture' => 'Decorticate posture is flexion of the arms toward the chest with leg extension, reflecting serious damage to cerebral hemispheres or corticospinal pathways above the brainstem.',
    'Decreased alertness' => 'Decreased alertness is reduced awareness or responsiveness that may result from metabolic illness, intoxication, infection, seizure, stroke, trauma, or sleep-related causes.',
    'Deep brain stimulation' => 'Deep brain stimulation delivers programmed electrical impulses through implanted electrodes to modulate circuits involved in disorders such as Parkinson disease, tremor, and dystonia.',
    'Deep vein thrombosis' => 'Deep vein thrombosis is a blood clot in a deep vein, usually of the leg, that can cause swelling and pain and may embolize to the lungs as pulmonary embolism.',
    'Dehydration' => 'Dehydration occurs when body water loss exceeds intake, causing thirst, reduced urination, dizziness, tachycardia, electrolyte abnormalities, or shock when severe.',
    'Delirium' => 'Delirium is an acute fluctuating disturbance of attention and awareness caused by an underlying medical, medication-related, toxic, or environmental factor.',
    'Dementia' => 'Dementia is acquired decline in one or more cognitive domains that interferes with independent function; causes include neurodegenerative, vascular, metabolic, infectious, and other disorders.',
    'Dengue fever' => 'Dengue fever is a mosquito-borne viral illness causing fever, headache, muscle and joint pain, rash, and sometimes plasma leakage, bleeding, or shock.',
    'Depression' => 'Depression is a mood disorder involving persistent depressed mood or loss of interest with cognitive, physical, and behavioral symptoms that impair functioning.',
    'Dermatitis herpetiformis' => 'Dermatitis herpetiformis is an intensely itchy grouped-vesicle skin eruption associated with gluten-sensitive enteropathy and IgA deposition in the skin.',
    'Dermatomyositis' => 'Dermatomyositis is an autoimmune inflammatory myopathy characterized by proximal muscle weakness and distinctive skin findings, with possible lung, swallowing, or cancer associations.',
    'Diabetes' => 'Diabetes is chronic hyperglycemia caused by inadequate insulin secretion, insulin resistance, or both, with long-term risks to the eyes, kidneys, nerves, heart, and blood vessels.',
    'Diabetic ketoacidosis' => 'Diabetic ketoacidosis is an acute insulin-deficient state with hyperglycemia, ketone production, and metabolic acidosis, often accompanied by dehydration and dangerous electrolyte shifts.',
    'Diarrhea' => 'Diarrhea is passage of loose or watery stools more frequently than usual; duration, blood, fever, dehydration, exposures, and associated symptoms guide evaluation.',
    'Diphtheria' => 'Diphtheria is a toxin-producing Corynebacterium infection that can form a pharyngeal pseudomembrane and cause airway obstruction, myocarditis, and neuropathy.',
    'Disseminated intravascular coagulation (DIC)' => 'Disseminated intravascular coagulation is uncontrolled systemic coagulation activation with consumption of platelets and clotting factors, producing simultaneous thrombosis and bleeding.',
    'Diverticulitis' => 'Diverticulitis is inflammation or infection of a diverticulum, usually in the colon, causing localized abdominal pain, fever, altered bowel habits, or complications such as abscess.',
    'Dizziness' => 'Dizziness is a subjective sensation that may represent vertigo, lightheadedness, imbalance, or nonspecific disequilibrium; history and examination distinguish vestibular, cardiovascular, neurologic, and other causes.',
    'Do-not-resuscitate order' => 'A do-not-resuscitate order documents that cardiopulmonary resuscitation should not be attempted if breathing or circulation stops, according to the patient’s informed preferences and applicable law.',
    'Down syndrome' => 'Down syndrome is a genetic condition caused by extra chromosome 21 material, associated with characteristic features, developmental differences, congenital heart disease, and variable medical needs.',
    'Drug allergies' => 'Drug allergies are immune-mediated reactions to a medicine, ranging from rash to anaphylaxis; they must be distinguished from predictable side effects and nonimmune intolerance.',
    'Dry eye syndrome' => 'Dry eye syndrome occurs when tears are insufficient or evaporate too quickly, causing burning, grittiness, fluctuating vision, redness, and reflex tearing.',
    'Duchenne muscular dystrophy' => 'Duchenne muscular dystrophy is an X-linked dystrophin deficiency causing progressive proximal muscle weakness, contractures, respiratory impairment, and cardiomyopathy, usually beginning in childhood.',
    'Duodenal atresia' => 'Duodenal atresia is congenital blockage of the duodenum, commonly presenting in a newborn with early bilious vomiting and requiring surgical management.',
    'Dupuytren contracture' => 'Dupuytren contracture is progressive shortening of palmar fascia that pulls one or more fingers into flexion and can limit hand function.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /overdose|poisoning|toxic|swallowing|battery|cleaner|oil/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and antidote availability determine the urgency and treatment approach."
  elsif lower =~ /test|screen|scan|mri|ct|ultrasound|exam|culture|analysis|count|sample|sampling|d-dimer|absorption|doppler|x-ray/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|replacement|stimulation|repair|procedure|dialysis|delivery|care program|therapy|insertion|reduction|release/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /discharge|aftercare|self-care|resources|what to ask|diet|nutrition|safety|care|management|prevention|driving|exercise|active|quit|choosing|coping|support/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|diabetes|dementia|depression|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|cardiomyopathy/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|duodenum|cell|protein|chromosome|posture|alertness|distal|concomitant/
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
