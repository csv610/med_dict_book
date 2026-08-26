#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'H influenzae meningitis' => 'H. influenzae meningitis is bacterial infection of the meninges caused by Haemophilus influenzae, potentially producing brain injury, hearing loss, seizures, or death.',
    'H1N1 influenza (Swine flu)' => 'H1N1 influenza is a strain of influenza A virus that causes an acute respiratory illness with fever, cough, myalgia, and variable pulmonary complications.',
    'H2 blockers' => 'H2 blockers reduce gastric acid secretion by antagonizing histamine H2 receptors on parietal cells and are used for reflux, dyspepsia, ulcers, and selected hypersecretory states.',
    'Hair loss' => 'Hair loss, or alopecia, may result from genetic patterning, autoimmune disease, hormonal or nutritional disorders, medications, infection, inflammation, or physical stress.',
    'Hallucinations' => 'Hallucinations are perceptions without an external sensory stimulus and can arise from psychiatric illness, neurologic disease, delirium, substances, medications, sensory loss, or sleep transitions.',
    'Hand-foot-mouth disease' => 'Hand-foot-mouth disease is a contagious enterovirus infection causing oral ulcers and a vesicular rash on the hands and feet, usually in young children.',
    'Hantavirus' => 'Hantavirus infection is acquired from exposure to infected rodent excreta and can cause hemorrhagic fever with renal syndrome or severe cardiopulmonary syndrome.',
    'Headache' => 'Headache is pain in the head or upper neck; onset, pattern, associated neurologic findings, fever, trauma, and systemic symptoms distinguish primary from secondary causes.',
    'Heart attack' => 'A heart attack, or myocardial infarction, occurs when prolonged coronary blood-flow interruption injures heart muscle and requires urgent reperfusion and medical treatment.',
    'Heart failure' => 'Heart failure is a clinical syndrome in which cardiac output or filling pressures are inadequate for body needs, causing breathlessness, fatigue, congestion, and exercise intolerance.',
    'Heart block' => 'Heart block is impaired electrical conduction from the atria to the ventricles, ranging from delayed conduction to complete dissociation and possible need for pacing.',
    'Heartburn' => 'Heartburn is a burning retrosternal sensation caused by reflux of gastric contents; frequent or complicated symptoms may indicate gastroesophageal reflux disease.',
    'Heat emergencies' => 'Heat emergencies range from heat cramps and exhaustion to heat stroke, in which dangerous core-temperature elevation causes central nervous system dysfunction and organ injury.',
    'Helicobacter pylori infection' => 'Helicobacter pylori infection colonizes the stomach and contributes to gastritis, peptic ulcer disease, gastric adenocarcinoma, and gastric MALT lymphoma.',
    'HELLP syndrome' => 'HELLP syndrome is a pregnancy-related emergency marked by hemolysis, elevated liver enzymes, and low platelets, often associated with preeclampsia and requiring urgent management.',
    'Hemochromatosis' => 'Hemochromatosis is excessive iron accumulation that can injure the liver, pancreas, heart, joints, skin, and endocrine organs; inherited and acquired forms exist.',
    'Hemoglobin' => 'Hemoglobin is the iron-containing protein in red blood cells that carries oxygen and carbon dioxide; its concentration and structure help evaluate anemia and hemoglobin disorders.',
    'Hemolytic anemia' => 'Hemolytic anemia occurs when red blood cells are destroyed faster than marrow replacement, causing anemia with variable jaundice, reticulocytosis, elevated LDH, or splenomegaly.',
    'Hemophilia' => 'Hemophilia is an inherited coagulation-factor deficiency, usually factor VIII or IX, causing prolonged bleeding into joints, muscles, and tissues after injury or spontaneously.',
    'Hepatitis' => 'Hepatitis is inflammation of the liver caused by viruses, alcohol, medications, toxins, metabolic disease, or autoimmunity and may be acute or chronic.',
    'Hepatitis A' => 'Hepatitis A is an acute fecal-oral viral liver infection that usually resolves without chronic disease but can cause severe cholestatic or fulminant hepatitis.',
    'Hepatitis B' => 'Hepatitis B is a blood- and body-fluid-borne viral liver infection that may become chronic and lead to cirrhosis, liver failure, or hepatocellular carcinoma.',
    'Hepatitis C' => 'Hepatitis C is a blood-borne viral infection that frequently becomes chronic and can cause progressive fibrosis, cirrhosis, liver failure, or liver cancer.',
    'Hernia' => 'A hernia is protrusion of tissue through a weakness or opening in the surrounding muscle or connective tissue and may become incarcerated or strangulated.',
    'Herniated disk' => 'A herniated disk occurs when spinal disk material extends through a fissure and may compress a nerve root, producing back pain, radiating pain, numbness, or weakness.',
    'Herpes - oral' => 'Oral herpes is usually caused by herpes simplex virus type 1 and produces recurrent grouped blisters or ulcers around the lips or mouth, with asymptomatic viral shedding.',
    'Hiatal hernia' => 'A hiatal hernia occurs when part of the stomach moves through the diaphragm into the chest, potentially worsening reflux, regurgitation, chest discomfort, or swallowing symptoms.',
    'High blood pressure - hypertension' => 'High blood pressure, or hypertension, is sustained elevation of arterial pressure that increases risk of stroke, coronary disease, heart failure, kidney disease, and retinopathy.',
    'Hives' => 'Hives, or urticaria, are transient raised itchy wheals caused by dermal edema, commonly from allergy, infection, medications, physical triggers, or spontaneous mast-cell activation.',
    'Hodgkin lymphoma' => 'Hodgkin lymphoma is a lymphoid cancer characterized by Hodgkin and Reed-Sternberg cells in an inflammatory background, commonly presenting with painless lymph-node enlargement and systemic symptoms.',
    'Horner syndrome' => 'Horner syndrome results from interruption of sympathetic pathways to the eye and face, causing ptosis, miosis, and reduced facial sweating on the affected side.',
    'Hysterectomy' => 'Hysterectomy is surgical removal of the uterus, sometimes with the cervix, tubes, or ovaries, performed for conditions such as cancer, fibroids, bleeding, or prolapse.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /poisoning|toxic|overdose|bite|sting|swallow|inhaled|foreign object|bleach|dye|spray|straightener|tonic|glue/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|screen|scan|mri|ct|ultrasound|exam|culture|analysis|count|sampling|angiograph|monitor|x-ray|electro|biopsy|hcg|hormone|histocompatibility|holter|hysterosalpingography|hysteroscopy/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|repair|replacement|insertion|feeding|anesthesia|injection|transfusion|dialysis|procedure|care program|aftercare|discharge|self-care|transplant|ablation|intubation|removal|resection|lift|bypass|arthroscopy|hysterectomy/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|nutrition|management|prevention|support|exercise|healthy|prescription|home|getting|going home|lifestyle|safety|care|habits|screening|stress|cost|education/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|hepat|lymphoma|meningitis|folliculitis|pneumonia|hyper|hypo/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|gastro|genetic|gene|glucose|growth|granulocyte|hemoglobin|hormone|hip|hand|head/
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
