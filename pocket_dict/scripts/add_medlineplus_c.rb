#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'C-reactive protein' => 'C-reactive protein is an acute-phase protein made by the liver; its blood concentration rises with inflammation but does not identify the cause by itself.',
    'C-section' => 'A C-section, or cesarean birth, delivers a baby through surgical incisions in the abdomen and uterus when vaginal birth is unsafe or not feasible.',
    'Caffeine overdose' => 'Caffeine overdose can cause agitation, tremor, vomiting, rapid heartbeat, abnormal rhythm, seizures, and dangerous metabolic disturbances.',
    'Calcification' => 'Calcification is abnormal deposition of calcium salts in tissue; its significance depends on the site, pattern, underlying injury, and associated disease.',
    'Calcium pyrophosphate arthritis' => 'Calcium pyrophosphate arthritis results from calcium pyrophosphate crystal deposition in joints, causing acute pseudogout or chronic inflammatory and degenerative arthritis.',
    'Campylobacter infection' => 'Campylobacter infection commonly causes inflammatory diarrhea, abdominal cramps, fever, and sometimes bloody stool after contaminated food, water, or animal exposure.',
    'Canavan disease' => 'Canavan disease is an inherited leukodystrophy caused by deficient aspartoacylase activity, leading to progressive white-matter injury and severe neurologic impairment.',
    'Cancer' => 'Cancer is uncontrolled growth of abnormal cells that can invade nearby tissue and spread to distant organs; behavior and treatment depend on its tissue of origin and molecular features.',
    'Candida auris infection' => 'Candida auris infection is an invasive or colonizing yeast infection notable for healthcare transmission and frequent resistance to antifungal medicines.',
    'Cardiac arrest' => 'Cardiac arrest is the abrupt loss of effective heart pumping, causing unresponsiveness and absent or abnormal breathing; immediate CPR and defibrillation when indicated are essential.',
    'Cardiac tamponade' => 'Cardiac tamponade occurs when fluid or blood under pressure around the heart restricts filling, reducing cardiac output and potentially causing obstructive shock.',
    'Cardiomyopathy' => 'Cardiomyopathy is disease of the heart muscle that can impair contraction, relaxation, rhythm, or valve function and may lead to heart failure or sudden death.',
    'Carpal tunnel syndrome' => 'Carpal tunnel syndrome is median-nerve compression at the wrist, producing numbness, tingling, pain, and sometimes weakness in the thumb, index, middle, and radial ring fingers.',
    'Cataract - adult' => 'An adult cataract is clouding of the eye lens that progressively reduces visual acuity, contrast, or glare tolerance; definitive treatment is lens-replacement surgery when function is impaired.',
    'Celiac disease - sprue' => 'Celiac disease is an immune-mediated reaction to gluten that damages small-intestinal villi and can cause malabsorption, anemia, diarrhea, weight loss, or extraintestinal disease.',
    'Cellulitis' => 'Cellulitis is a bacterial infection of the deeper skin and subcutaneous tissue, causing expanding redness, warmth, swelling, and tenderness with possible systemic illness.',
    'Cerebral palsy' => 'Cerebral palsy is a group of permanent disorders of movement and posture caused by injury or abnormal development of the developing brain, often accompanied by sensory or communication difficulties.',
    'Cervical cancer' => 'Cervical cancer is a malignant tumor of the cervix, most often related to persistent high-risk human papillomavirus infection and preventable through vaccination and screening.',
    'Chagas disease' => 'Chagas disease is infection with Trypanosoma cruzi, transmitted mainly by triatomine insects or contaminated blood and food, and capable of causing chronic cardiac or digestive disease.',
    'Chickenpox' => 'Chickenpox is a contagious varicella-zoster virus infection characterized by an itchy vesicular rash; complications are more likely in adults, pregnancy, immunosuppression, and some infants.',
    'Chikungunya virus' => 'Chikungunya virus is a mosquito-borne alphavirus that causes abrupt fever and severe joint pain, with arthralgia sometimes persisting for months.',
    'Chronic kidney disease' => 'Chronic kidney disease is persistent abnormal kidney structure or function lasting at least 3 months, with risks including anemia, mineral-bone disease, cardiovascular disease, and kidney failure.',
    'Chronic obstructive pulmonary disease (COPD)' => 'Chronic obstructive pulmonary disease is persistent airflow limitation from airway and alveolar injury, commonly causing exertional breathlessness, cough, sputum, and exacerbations.',
    'Cirrhosis' => 'Cirrhosis is advanced liver scarring with regenerative nodules that distorts blood flow and liver function, potentially causing portal hypertension, jaundice, ascites, and liver failure.',
    'Colorectal cancer' => 'Colorectal cancer is a malignant tumor of the colon or rectum, often developing from adenomatous or serrated polyps and presenting with altered bowel habits, bleeding, anemia, or weight loss.',
    'Common cold' => 'The common cold is an acute viral upper-respiratory infection causing nasal congestion, rhinorrhea, sore throat, cough, and mild systemic symptoms.',
    'Coronary heart disease' => 'Coronary heart disease results from atherosclerotic narrowing or blockage of coronary arteries, limiting myocardial blood flow and causing angina, infarction, heart failure, or arrhythmia.',
    'Coronavirus disease 2019 (COVID-19)' => 'Coronavirus disease 2019 is an infection caused by SARS-CoV-2, ranging from asymptomatic illness to pneumonia, respiratory failure, thrombosis, and persistent post-infectious symptoms.',
    'Cough' => 'Cough is a protective reflex that clears the airways; its duration, triggers, sputum, associated symptoms, and examination findings help distinguish infectious, inflammatory, cardiac, and other causes.',
    'Crohn disease' => 'Crohn disease is chronic immune-mediated inflammation that can affect any part of the gastrointestinal tract, often with transmural lesions, diarrhea, abdominal pain, strictures, fistulas, or weight loss.',
    'Cystic fibrosis' => 'Cystic fibrosis is an inherited CFTR-related disorder causing thick secretions, chronic sinopulmonary infection, pancreatic insufficiency, intestinal obstruction, and abnormal sweat chloride.',
    'Cytomegalovirus (CMV) infection' => 'Cytomegalovirus infection is caused by a herpesvirus that is often mild in healthy people but can cause congenital disease or severe organ infection in immunocompromised patients.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /overdose|poisoning|toxic/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and antidote availability determine the urgency and treatment approach."
  elsif lower =~ /test|screen|scan|mri|ct|ultrasound|biopsy|culture|analysis|count|sampling|angiograph|endoscop|duplex|refill|stain/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /repair|surgery|replacement|transplant|insertion|injection|reduction|release|ablation|circumcision|cryotherapy|procedure/
    "#{name} is a procedure for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and treatment goal."
  elsif lower =~ /discharge|aftercare|self-care|resources|what to ask|tips|management|prevention|lifestyle|diet|nutrition|safety|caregiving/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /virus|infection|disease|syndrome|cancer|carcinoma|leukemia|lymphoma|pneumonia|arthritis|disorder|deficien|injury|fracture|pain|cyst|colitis|itis|opathy|emia|osis/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|cervix|colon|cell|protein|calcium|chromosome|complement/
    "#{name} concerns #{lower}, a body structure, substance, or physiologic concept whose clinical meaning depends on location, function, and patient context."
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
