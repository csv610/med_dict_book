#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'Galactosemia' => 'Galactosemia is an inherited inability to metabolize galactose, causing neonatal feeding problems, jaundice, liver injury, infection risk, and developmental complications without dietary treatment.',
    'Gallstones' => 'Gallstones are solid deposits in the gallbladder that may be asymptomatic or obstruct bile flow, causing biliary colic, cholecystitis, pancreatitis, or jaundice.',
    'Gangrene' => 'Gangrene is tissue death caused by loss of blood supply, infection, or both; it can progress to systemic toxicity and requires urgent assessment of circulation and infection.',
    'Gastritis' => 'Gastritis is inflammation or injury of the stomach lining caused by infection, medications, alcohol, autoimmune disease, stress-related illness, or other factors.',
    'Gastroesophageal reflux disease' => 'Gastroesophageal reflux disease occurs when reflux of stomach contents causes troublesome symptoms or esophageal complications such as inflammation, stricture, or Barrett esophagus.',
    'Gastrointestinal bleeding' => 'Gastrointestinal bleeding is blood loss from any part of the digestive tract, presenting as vomiting blood, black stool, maroon stool, or occult anemia and sometimes causing shock.',
    'Gastroparesis' => 'Gastroparesis is delayed stomach emptying without mechanical obstruction, causing early satiety, nausea, vomiting, bloating, and poor glucose or nutritional control.',
    'Gaucher disease' => 'Gaucher disease is an inherited lysosomal storage disorder caused by deficient glucocerebrosidase, leading to accumulation in macrophages and variable spleen, liver, bone, blood, and neurologic disease.',
    'General anesthesia' => 'General anesthesia produces reversible unconsciousness, amnesia, analgesia, and immobility through administered medicines while breathing and circulation are monitored and supported.',
    'Generalized anxiety disorder' => 'Generalized anxiety disorder is excessive, difficult-to-control worry across multiple areas of life with symptoms such as restlessness, muscle tension, irritability, and sleep disturbance.',
    'Genital herpes' => 'Genital herpes is a sexually transmitted infection caused mainly by herpes simplex virus type 2 or type 1, producing recurrent painful vesicles or ulcers and asymptomatic shedding.',
    'Gestational diabetes' => 'Gestational diabetes is glucose intolerance first recognized during pregnancy, increasing risks of fetal overgrowth, birth complications, hypertensive disease, and later type 2 diabetes.',
    'Giant cell arteritis' => 'Giant cell arteritis is granulomatous inflammation of medium and large arteries, often causing new headache, scalp tenderness, jaw claudication, and vision-threatening ischemia.',
    'Giardia infection' => 'Giardiasis is intestinal infection by Giardia parasites, causing foul-smelling diarrhea, bloating, cramps, weight loss, and malabsorption after contaminated water, food, or contact exposure.',
    'Glaucoma' => 'Glaucoma is progressive optic-nerve damage often associated with elevated or dysregulated intraocular pressure, leading to irreversible visual-field loss if untreated.',
    'Glomerulonephritis' => 'Glomerulonephritis is inflammatory injury of the kidney glomeruli, producing hematuria, proteinuria, edema, hypertension, and variable decline in filtration.',
    'Glucose-6-phosphate dehydrogenase deficiency' => 'Glucose-6-phosphate dehydrogenase deficiency is an inherited red-cell enzyme disorder in which oxidative stress can trigger hemolytic anemia after selected infections, foods, or medicines.',
    'Gonorrhea' => 'Gonorrhea is a sexually transmitted infection caused by Neisseria gonorrhoeae, producing urethritis, cervicitis, pelvic inflammatory disease, rectal or pharyngeal infection, and neonatal disease.',
    'Gout' => 'Gout is inflammatory arthritis caused by monosodium urate crystal deposition, classically causing abrupt severe pain and swelling in a joint and potentially forming tophi or kidney stones.',
    'Graft-versus-host disease' => 'Graft-versus-host disease occurs when donor immune cells attack recipient tissues after allogeneic transplantation, commonly affecting skin, liver, and gastrointestinal tract.',
    'Graves disease' => 'Graves disease is autoimmune hyperthyroidism caused by antibodies that stimulate the thyroid-stimulating hormone receptor, sometimes accompanied by eye or skin disease.',
    'Guillain-Barre syndrome' => 'Guillain-Barre syndrome is acute immune-mediated peripheral nerve disease causing progressive weakness, sensory symptoms, and reduced reflexes, with possible respiratory or autonomic failure.',
    'Guttate psoriasis' => 'Guttate psoriasis is an eruption of numerous small scaly lesions, often appearing after streptococcal infection and sometimes evolving into plaque psoriasis.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /poisoning|toxic|overdose|bite|sting|gasoline|glaze|killer/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|screen|ultrasound|culture|biopsy|stain|analysis|count|rate|grading|sampling|radionuclide|filtration|echo|monitor/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|removal|repair|insertion|feeding|anesthesia|injection|transfusion|dialysis|procedure|care program|aftercare|discharge|self-care/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|nutrition|management|prevention|support|exercise|healthy|prescription|home|getting|going home|lifestyle|safety|care|habits/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|gastro|genetic|gene|glucose|growth|granulocyte/
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
