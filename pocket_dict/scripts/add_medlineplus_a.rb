#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  lower = term.downcase
  specific = {
    'A1C test' => 'A1C test measures glycated hemoglobin, the fraction of hemoglobin with glucose attached, to estimate average blood glucose over roughly the preceding 2 to 3 months.',
    'Aase syndrome' => 'Aase syndrome is a rare inherited disorder characterized by congenital hypoplastic anemia and distinctive skeletal abnormalities.',
    'Absent pulmonary valve' => 'Absent pulmonary valve is a congenital heart defect in which the pulmonary valve is missing or severely underdeveloped, often causing pulmonary-artery enlargement and respiratory symptoms.',
    'ACE blood test' => 'ACE blood test measures angiotensin-converting enzyme in serum; it may support evaluation of sarcoidosis and selected granulomatous or liver disorders but is not diagnostic alone.',
    'ACE inhibitors' => 'ACE inhibitors block formation of angiotensin II and are used for hypertension, heart failure, diabetic kidney protection, and selected cardiovascular conditions.',
    'Acetylcholine receptor antibody' => 'Acetylcholine receptor antibody testing detects antibodies associated with autoimmune myasthenia gravis and is interpreted with the neurologic examination and other studies.',
    'Achilles tendon repair' => 'Achilles tendon repair reconnects a ruptured Achilles tendon, followed by immobilization and graduated rehabilitation to restore plantar-flexion strength.',
    'Acid-fast stain' => 'Acid-fast stain uses dyes that remain in the cell wall of mycobacteria and some related organisms, helping identify them in clinical specimens.',
    'Acute adrenal crisis' => 'Acute adrenal crisis is life-threatening cortisol deficiency causing hypotension, vomiting, abdominal pain, electrolyte disturbance, hypoglycemia, or shock; urgent glucocorticoid and fluid treatment is required.',
    'Acute arterial occlusion - kidney' => 'Acute arterial occlusion of the kidney abruptly reduces renal blood flow and may cause flank pain, hematuria, hypertension, or acute kidney injury.',
    'Acute lymphoblastic leukemia (ALL)' => 'Acute lymphoblastic leukemia is a rapidly progressive cancer of immature lymphoid precursor cells that crowds the bone marrow and can involve blood, lymph nodes, or the central nervous system.',
    'Acute myeloid leukemia (AML) - children' => 'Childhood acute myeloid leukemia is a marrow and blood cancer caused by uncontrolled proliferation of immature myeloid cells, producing anemia, infection, and bleeding risk.',
    'Acute myeloid leukemia - adult' => 'Adult acute myeloid leukemia is an aggressive malignancy of myeloid blood-cell precursors that impairs normal blood-cell production.',
    'Adrenal glands' => 'Adrenal glands sit above the kidneys and produce cortisol, aldosterone, adrenal androgens, and catecholamines that regulate stress, blood pressure, salt balance, and metabolism.',
    'Aflatoxin' => 'Aflatoxin is a toxin produced by certain Aspergillus molds in contaminated foods; chronic exposure can injure the liver and increase hepatocellular-carcinoma risk.',
    'Aicardi syndrome' => 'Aicardi syndrome is a rare developmental brain disorder classically involving agenesis of the corpus callosum, chorioretinal lacunae, and infantile seizures.',
    'Alcoholic liver disease' => 'Alcoholic liver disease includes steatosis, alcohol-associated hepatitis, and cirrhosis caused by sustained alcohol exposure.',
    'Alzheimer disease - resources' => 'Alzheimer disease resources provide education about progressive cognitive decline, caregiver support, safety, advance planning, and available treatment and services.',
    'Amino acids' => 'Amino acids are organic molecules that form proteins and also serve as precursors or fuels in human metabolism.',
    'Aminoaciduria' => 'Aminoaciduria is abnormal urinary loss of amino acids caused by renal tubular transport defects, inherited metabolic disease, or generalized tubular injury.',
    'Amniotic band sequence' => 'Amniotic band sequence results when fibrous amniotic strands entangle developing fetal parts, producing constriction rings, limb defects, or craniofacial and body-wall abnormalities.',
    'Anaphylaxis' => 'Anaphylaxis is a rapid, systemic hypersensitivity reaction that can cause airway swelling, breathing difficulty, hypotension, vomiting, or shock and requires immediate intramuscular epinephrine.',
    'Aneurysm in the brain' => 'A brain aneurysm is a focal weakness and ballooning of a cerebral-artery wall; rupture causes subarachnoid hemorrhage and sudden severe headache.',
    'Angina - when you have chest pain' => 'Angina with chest pain reflects transient myocardial ischemia; new, severe, prolonged, or rest pain may signal acute coronary syndrome and requires emergency assessment.',
    'Antiphospholipid syndrome - APS' => 'Antiphospholipid syndrome is an autoimmune thrombophilia associated with venous or arterial clots and pregnancy morbidity in the presence of persistent antiphospholipid antibodies.',
    'Aortic dissection' => 'Aortic dissection begins with a tear in the aortic wall that allows blood to split its layers, causing abrupt pain and possible malperfusion, rupture, or death.',
    'Aplastic anemia' => 'Aplastic anemia is bone-marrow failure with reduced production of red cells, white cells, and platelets, resulting in anemia, infection risk, and bleeding.',
    'Asthma' => 'Asthma is a chronic inflammatory airway disorder with variable bronchoconstriction and expiratory airflow limitation, causing episodic wheeze, cough, chest tightness, or breathlessness.',
    'Autoimmune diseases' => 'Autoimmune diseases arise when immune responses target the body’s own tissues, producing organ-specific or systemic inflammation and damage.',
    'Autosomal dominant' => 'Autosomal dominant inheritance occurs when one altered copy of a gene can produce a trait or disorder; an affected heterozygous parent may transmit it to about half of offspring.',
    'Autosomal recessive' => 'Autosomal recessive inheritance generally requires pathogenic variants in both copies of a gene; unaffected carrier parents can have an affected child.',
  }
  return specific[term.strip] if specific.key?(term.strip)
  if lower =~ /overdose|poisoning|toxic/
    "#{term} involves toxic exposure to the substance named in the title; the clinical response depends on dose, route, timing, symptoms, and whether an antidote is available."
  elsif lower =~ /blood test|test$|testing|assay|titer|panel|mri|ct scan|ultrasound|x-ray|radiation|angiography|arteriogram|manometry|anoscopy|audiometry|biopsy|electro|screening/
    "#{term} evaluates the body site, analyte, antibody, or physiologic function named in the title; results are interpreted with the method, reference range, and clinical question."
  elsif lower =~ /repair|removal|surgery|reconstruction|replacement|delivery|appendectomy|arthroscopy|procedure|resection|transplant/
    "#{term} describes treatment or perioperative care for the structure or condition named in the title, including indications, preparation, complications, and recovery considerations."
  elsif lower =~ /discharge|aftercare|self-care|what to ask|resources|guide|in the hospital|homecare|preparation|safe drinking|pain relief/
    "#{term} is a patient-care topic focused on the condition or situation named in the title, including practical management, warning signs, follow-up, and clinician questions."
  elsif lower =~ /pain|swollen|bloating|lump|bleeding|sweating|absence|spots|changes|development|labor|exercise|appetite|anxiety|agitation|hearing loss|dark or light skin/
    "#{term} describes the symptom, sign, or physiologic change named in the title; evaluation considers its onset, severity, associated findings, causes, and need for medical care."
  else
    "#{term} concerns the condition, exposure, finding, or health-care subject named in the title; clinical evaluation identifies its defining features, causes, severity, and management."
  end
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
existing = File.read(output).scan(/\\medterm\{([^}]*)\}/).flatten.map { |x| normalize(x) }
known = existing.to_h { |x| [x, true] }
additions = File.readlines(input, chomp: true).reject(&:empty?).reject { |term| known[normalize(term)] }
all_terms = File.readlines(input, chomp: true).reject(&:empty?)
text = File.read(output)
all_terms.each do |term|
  escaped = Regexp.escape(term)
  text.gsub!(/^\\medterm\{#{escaped}\}.*$/, "\\medterm{#{term}} #{definition(term)}")
end
File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term}} #{definition(term)}"
    file.puts
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
