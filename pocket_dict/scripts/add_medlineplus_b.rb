#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'B and T cell screen' => 'B and T cell screen uses immunophenotyping to measure and characterize circulating B lymphocytes and T lymphocytes, supporting evaluation of immune deficiency, leukemia, and lymphoma.',
    'B-cell leukemia/lymphoma panel' => 'B-cell leukemia/lymphoma panel uses flow cytometry and antibody markers to identify abnormal B-cell populations in blood, marrow, or tissue.',
    'Babinski reflex' => 'Babinski reflex is extension of the great toe and fanning of the other toes after stroking the sole; it is expected in infants but may indicate corticospinal-tract disease in adults.',
    'Bacterial gastroenteritis' => 'Bacterial gastroenteritis is inflammation of the stomach or intestines caused by bacteria, producing diarrhea, abdominal cramps, fever, nausea, or vomiting.',
    'BAER - brainstem auditory evoked response' => 'BAER records electrical responses from the auditory nerve and brainstem after sound stimulation, helping assess hearing pathways when behavioral testing is difficult.',
    'Baker cyst' => 'Baker cyst is a fluid-filled enlargement of the popliteal bursa behind the knee, usually related to arthritis, meniscal injury, or another source of joint inflammation.',
    'Balanitis' => 'Balanitis is inflammation of the glans penis, often associated with infection, irritation, poor drainage, diabetes, or an inflammatory skin disorder.',
    'Barrett esophagus' => 'Barrett esophagus is replacement of the normal lower-esophageal lining by intestinal-type epithelium after chronic gastroesophageal reflux, with increased risk of adenocarcinoma.',
    'Bartholin cyst or abscess' => 'Bartholin cyst is a blocked gland duct near the vaginal opening; infection can produce a painful abscess requiring drainage and sometimes antibiotics.',
    'Bartter syndrome' => 'Bartter syndrome is an inherited renal salt-wasting disorder causing hypokalemic metabolic alkalosis, increased renin and aldosterone, and often growth or urinary-concentration abnormalities.',
    'Basal cell skin cancer' => 'Basal cell skin cancer is a usually slow-growing skin malignancy arising from basal keratinocytes; it rarely metastasizes but can destroy nearby tissue if untreated.',
    'Bassen-Kornzweig syndrome' => 'Bassen-Kornzweig syndrome, or abetalipoproteinemia, is an inherited disorder of lipoprotein assembly causing fat malabsorption, acanthocytosis, vitamin E deficiency, and neurologic disease.',
    'Becker muscular dystrophy' => 'Becker muscular dystrophy is an X-linked dystrophinopathy with progressive skeletal-muscle weakness that is generally milder and later in onset than Duchenne muscular dystrophy.',
    'Beckwith-Wiedemann syndrome' => 'Beckwith-Wiedemann syndrome is an imprinting disorder causing overgrowth, macroglossia, abdominal-wall defects, neonatal hypoglycemia, and increased risk of selected embryonal tumors.',
    'Bedwetting' => 'Bedwetting is involuntary nighttime urination after the age at which nighttime bladder control is expected; evaluation considers constipation, sleep, urinary symptoms, stress, and medical causes.',
    'Bell palsy' => 'Bell palsy is acute peripheral facial-nerve weakness, usually unilateral, that may impair eye closure and taste; most cases improve, but urgent assessment excludes stroke and other causes.',
    'Benign positional vertigo - aftercare' => 'Benign positional vertigo aftercare covers activity, fall prevention, recurrence, and vestibular exercises after treatment for brief vertigo caused by displaced inner-ear otoconia.',
    'Beriberi' => 'Beriberi is thiamine deficiency causing dry or wet cardiac disease, peripheral neuropathy, weakness, confusion, or Wernicke encephalopathy.',
    'Bilateral hydronephrosis' => 'Bilateral hydronephrosis is enlargement of both renal collecting systems from impaired urine drainage, with causes including obstruction, reflux, stones, or bladder dysfunction.',
    'Biliary atresia' => 'Biliary atresia is progressive obliteration of the extrahepatic bile ducts in infancy, causing cholestatic jaundice and requiring prompt surgical evaluation.',
    'Bilirubin encephalopathy' => 'Bilirubin encephalopathy is neurologic injury from severe unconjugated hyperbilirubinemia, ranging from acute lethargy and abnormal tone to permanent kernicterus.',
    'Binge eating disorder' => 'Binge eating disorder involves recurrent episodes of consuming unusually large amounts of food with loss of control and marked distress, without regular compensatory behaviors.',
    'Biofeedback' => 'Biofeedback uses real-time information about physiologic signals such as muscle activity, heart rate, or breathing to help a person learn voluntary regulation.',
    'Bipolar disorder' => 'Bipolar disorder causes recurrent episodes of mania or hypomania and depression, with changes in mood, energy, activity, sleep, judgment, and functioning.',
    'Bladder exstrophy repair' => 'Bladder exstrophy repair reconstructs the exposed bladder and lower abdominal and genital structures present in this congenital defect, often through staged surgery.',
    'Blastomycosis' => 'Blastomycosis is a systemic fungal infection caused by Blastomyces, usually acquired by inhalation and affecting the lungs, skin, bone, or genitourinary tract.',
    'Bleeding disorders' => 'Bleeding disorders impair formation or stability of blood clots because of platelet, coagulation-factor, vessel-wall, or fibrinolytic abnormalities.',
    'Blepharitis' => 'Blepharitis is chronic inflammation of the eyelid margins, often causing crusting, burning, irritation, fluctuating vision, and tear-film dysfunction.',
    'Bloodborne pathogens' => 'Bloodborne pathogens are infectious agents transmitted through blood or certain body fluids, including HIV, hepatitis B virus, and hepatitis C virus.',
    'Blount disease' => 'Blount disease is a growth-plate disorder causing progressive bowing of the legs, especially the tibia, in young children or adolescents.',
    'Body mass index' => 'Body mass index is weight in kilograms divided by height in meters squared; it is a population screening measure rather than a direct measure of body fat or individual health.',
    'Botulism' => 'Botulism is paralysis caused by botulinum neurotoxin, usually after contaminated food, wound infection, or infant intestinal colonization; respiratory failure is a medical emergency.',
    'Brachial plexopathy' => 'Brachial plexopathy is dysfunction of the nerve network supplying the arm, causing pain, weakness, sensory loss, or reflex changes from trauma, tumor, radiation, or inflammation.',
    'Brain abscess' => 'Brain abscess is a localized collection of infected material within brain tissue, producing headache, fever, seizures, focal deficits, or increased intracranial pressure.',
    'Brain herniation' => 'Brain herniation is displacement of brain tissue through rigid intracranial compartments because of dangerous pressure elevation, threatening blood flow and brainstem function.',
    'Branchial cleft cyst' => 'Branchial cleft cyst is a congenital epithelial-lined cyst along the side of the neck that may enlarge or become infected.',
    'Bronchiectasis' => 'Bronchiectasis is permanent widening and distortion of bronchi caused by chronic infection or inflammation, leading to daily cough, sputum production, and recurrent exacerbations.',
    'Bronchiolitis' => 'Bronchiolitis is acute viral inflammation and obstruction of the small airways in infants and young children, commonly causing cough, wheezing, tachypnea, and feeding difficulty.',
    'Bronchoscopic culture' => 'Bronchoscopic culture examines respiratory specimens collected through bronchoscopy for bacteria, fungi, or mycobacteria when ordinary samples are inadequate.',
    'Bronchoscopy - aftercare' => 'Bronchoscopy aftercare includes observation for breathing difficulty, bleeding, fever, chest pain, and swallowing recovery after an airway examination or sampling procedure.',
    'Brucellosis' => 'Brucellosis is a zoonotic infection caused by Brucella species, acquired from infected animals or unpasteurized products and associated with fever, sweats, joint pain, and relapsing illness.',
    'Bursitis of the heel' => 'Heel bursitis is inflammation of a fluid-filled bursa near the heel, producing localized tenderness and pain with pressure or walking.',
    'Byssinosis' => 'Byssinosis is an occupational airway disease caused by inhalation of cotton, flax, or hemp dust, classically producing chest tightness and airflow limitation at the start of the workweek.',
  }
  return specific[name] if specific.key?(name)
  if lower =~ /overdose|poisoning|toxic|battery/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and antidote availability guide the clinical response."
  elsif lower =~ /blood test|test$|testing|assay|titer|panel|culture|smear|scan|x-ray|mri|ultrasound|biopsy|pet scan|measurement|screening|baer/
    "#{name} evaluates #{lower}; interpretation uses the method, specimen or body region, reference range, and clinical question."
  elsif lower =~ /repair|removal|surgery|reconstruction|replacement|transplant|injection|arthroscopy|procedure|graft|transfusion|delivery|pumping/
    "#{name} treats or supports #{lower}; indication, preparation, complications, and recovery depend on the procedure and patient."
  elsif lower =~ /aftercare|discharge|self-care/
    "#{name} addresses recovery from #{lower}, including activity, medicines, warning signs, and follow-up."
  elsif lower =~ /resources|what to ask/
    "#{name} summarizes care planning for #{lower}, including options, safety, support, and questions for a clinician."
  elsif lower =~ /safety|first aid/
    "#{name} focuses on preventing or responding to #{lower}, including risk reduction and signs requiring urgent help."
  elsif lower =~ /bathing|bedtime habits|breastfeeding|pumping|storing|formula feeding|bonding/
    "#{name} addresses practical care for #{lower}, including safe technique, common concerns, and when to seek advice."
  elsif lower =~ /active|benefits|safe drinking|pain relief/
    "#{name} discusses guidance for #{lower}, balancing expected benefits, personal limits, and professional advice."
  elsif lower =~ /pain|swollen|lump|bleeding|discoloration|odor|difficulty|breathing|spell|rash|bowel|incontinence|bedwetting|appetite|enlargement|tenderness|burns|boils|bunion|bruise|stool|semen/
    "#{name} is the presentation described by #{lower}; onset, severity, associated findings, causes, and need for care guide assessment."
  else
    "#{name} concerns #{lower}; defining findings, causes, severity, and management depend on the affected system and patient."
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
