#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'Fainting' => 'Fainting is a brief loss of consciousness from transient inadequate brain perfusion, often caused by reflex, orthostatic, or cardiac mechanisms; cardiac warning features require urgent evaluation.',
    'Familial hypercholesterolemia' => 'Familial hypercholesterolemia is an inherited disorder of markedly elevated low-density lipoprotein cholesterol that accelerates atherosclerosis and premature coronary disease.',
    'Fanconi anemia' => 'Fanconi anemia is an inherited DNA-repair disorder causing bone-marrow failure, congenital differences, cancer susceptibility, and variable organ abnormalities.',
    'Fatigue' => 'Fatigue is a persistent sense of low energy or reduced capacity that may result from sleep problems, anemia, infection, endocrine disease, medication, mood disorder, or systemic illness.',
    'Febrile seizures' => 'Febrile seizures are seizures associated with fever in young children without evidence of central nervous system infection or prior unprovoked seizures.',
    'Fecal impaction' => 'Fecal impaction is a hard mass of stool retained in the rectum or colon, causing constipation, abdominal discomfort, overflow leakage, and sometimes obstruction.',
    'Fecal microbiota transplant' => 'Fecal microbiota transplantation transfers processed stool from a screened donor to restore intestinal microbial communities, particularly for recurrent Clostridioides difficile infection.',
    'Fetal alcohol syndrome' => 'Fetal alcohol syndrome is a severe fetal alcohol spectrum disorder with characteristic facial features, growth impairment, and central nervous system effects from prenatal alcohol exposure.',
    'Fever' => 'Fever is a regulated rise in body temperature caused by altered hypothalamic set point, commonly in response to infection or inflammation; age, duration, and associated signs determine concern.',
    'Fibromyalgia' => 'Fibromyalgia is a chronic pain-amplification disorder with widespread pain, fatigue, unrefreshing sleep, and cognitive symptoms without a single defining tissue lesion.',
    'Fibrous dysplasia' => 'Fibrous dysplasia is a mosaic bone disorder in which normal bone is replaced by fibro-osseous tissue, causing fractures, deformity, pain, or incidental imaging findings.',
    'Fifth disease' => 'Fifth disease is parvovirus B19 infection, often causing mild fever and a slapped-cheek rash; pregnancy, hemolytic anemia, and immunosuppression alter its risks.',
    'Fistula' => 'A fistula is an abnormal connection between two epithelialized surfaces, such as bowel and skin or two organs, caused by inflammation, infection, surgery, trauma, or congenital development.',
    'Flu' => 'Influenza is an acute respiratory infection caused by influenza viruses, producing fever, cough, myalgia, headache, and fatigue with potential pulmonary or systemic complications.',
    'Fluid imbalance' => 'Fluid imbalance occurs when water or electrolytes are excessive or deficient relative to body compartments, affecting circulation, cells, kidney function, and neurologic status.',
    'Focal seizure' => 'A focal seizure begins in a network limited to one cerebral hemisphere and may cause altered awareness, sensory or motor symptoms, autonomic changes, or progression to bilateral convulsions.',
    'Folate deficiency' => 'Folate deficiency impairs DNA synthesis and red-cell production, commonly causing megaloblastic anemia and, during pregnancy, increased risk of neural-tube defects.',
    'Food allergy' => 'Food allergy is an reproducible immune-mediated reaction to a food protein, ranging from hives and gastrointestinal symptoms to life-threatening anaphylaxis.',
    'Food poisoning' => 'Food poisoning is illness caused by contaminated food or drink, with symptoms such as vomiting, diarrhea, abdominal cramps, fever, or neurologic findings depending on the agent.',
    'Foot drop' => 'Foot drop is weakness of ankle dorsiflexion that causes a high-stepping gait and may result from peroneal neuropathy, radiculopathy, motor-neuron disease, or muscle disorders.',
    'Frostbite' => 'Frostbite is freezing injury to tissue, causing numbness, pallor, waxy skin, blistering, and possible tissue necrosis; rewarming and assessment are urgent.',
    'Frozen shoulder' => 'Frozen shoulder, or adhesive capsulitis, causes painful progressive restriction of active and passive shoulder motion through inflammatory and fibrotic capsular changes.',
    'Functional neurological disorder' => 'Functional neurological disorder causes genuine neurologic symptoms that are not explained by structural disease and reflect altered nervous-system functioning, diagnosed by positive clinical features.',
    'Fungal arthritis' => 'Fungal arthritis is infection of a joint by a fungus, usually producing persistent pain, swelling, and limited motion and requiring prolonged targeted therapy.',
    'Fungal nail infection' => 'Fungal nail infection is invasion of the nail plate or nail bed by fungi, causing thickening, discoloration, brittleness, separation, or subungual debris.',
    'Friedreich ataxia' => 'Friedreich ataxia is an inherited neurodegenerative disorder caused by reduced frataxin, producing progressive gait and limb ataxia, neuropathy, dysarthria, cardiomyopathy, and sometimes diabetes.',
    'Frontotemporal dementia' => 'Frontotemporal dementia is neurodegeneration of frontal and temporal lobes causing early changes in behavior, personality, executive function, language, or social conduct.',
    'Fuchs dystrophy' => 'Fuchs endothelial corneal dystrophy is progressive loss of corneal endothelial cells, leading to corneal swelling, glare, blurred vision, and painful epithelial bullae in advanced disease.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /overdose|poisoning|toxic|bite|sting|oil|swallow|inhaled|foreign object/
    "#{name} involves exposure or injury from #{lower}; dose, route, timing, symptoms, and tissue involvement determine the urgency and treatment approach."
  elsif lower =~ /test|screen|scan|mri|ct|ultrasound|exam|culture|analysis|count|sampling|angiograph|pH|assay|stain|ecg|echo|fetal/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|repair|replacement|transplant|insertion|injection|ablation|therapy|intubation|removal|resection|lift|release|maneuver|transfusion|amputation|foraminotomy|fusion/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /discharge|aftercare|self-care|resources|what to ask|diet|nutrition|safety|care|management|prevention|exercise|lifestyle|support|tips|habits|feeding|activity|cost/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|cardiomyopathy|pregnancy|cyst|tumor|asthma|seizure|anemia|fracture|swelling|paralysis|fatigue|farsightedness/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|epithelium|gland|esophagus|elbow|finger|foot|femur|factor|folate|fiber/
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
