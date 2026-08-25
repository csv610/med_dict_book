#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  "Calcific Bursitis" => "Calcific bursitis occurs when calcium deposits form in or around a bursa, often near the shoulder, causing pain and restricted movement. Treatment may include activity modification, anti-inflammatory care, physical therapy, aspiration, injection, or removal of deposits.",
  "Canalith Repositioning Maneuvers" => "Canalith repositioning maneuvers move displaced inner-ear crystals from a semicircular canal back to the utricle. They are used for benign paroxysmal positional vertigo, with the maneuver selected according to the affected canal and side.",
  "Cancer Causes" => "Cancer develops when genetic and epigenetic changes allow cells to grow, survive, and invade abnormally. Causes and risks include inherited susceptibility, tobacco, alcohol, infections, radiation, ultraviolet exposure, carcinogens, chronic inflammation, and chance changes during cell division.",
  "Canker Sores" => "Canker sores are painful, shallow ulcers on the moist lining of the mouth and are not contagious. Minor trauma, stress, nutritional deficiency, immune disease, medicines, or other triggers may contribute; persistent, severe, or recurrent ulcers need evaluation.",
  "Causes Symptoms of Hormonal Imbalances Women" => "Hormonal imbalance in women can reflect thyroid disease, polycystic ovary syndrome, menopause, pregnancy, adrenal or pituitary disorders, medicines, or changes in body weight. Symptoms may include irregular bleeding, acne, hair changes, infertility, hot flashes, fatigue, or mood changes.",
  "Cavities" => "A cavity is tooth decay caused by acids produced when oral bacteria metabolize dietary carbohydrates. The process can progress from enamel demineralization to dentin and pulp infection; fluoride, oral hygiene, diet, dental sealants, fillings, or root-canal treatment may be needed.",
  "Central Precocious Puberty" => "Central precocious puberty begins when the hypothalamus and pituitary activate the normal puberty pathway unusually early. It causes early secondary sexual characteristics and accelerated bone maturation; evaluation identifies causes and treatment may delay progression when appropriate.",
  "chemotherapy treatment" => "Chemotherapy uses medicines that damage or inhibit rapidly dividing cancer cells. It may be given before or after local treatment, for advanced disease, or for symptom control; effects and monitoring depend on the drugs, cancer, treatment goal, and organ function.",
  "Chest Pain on the Left Side Above a Female Breast" => "Left-sided chest or breast-area pain can arise from muscle or rib injury, breast tissue, reflux, lung disease, anxiety, or heart disease. Pressure, exertional pain, shortness of breath, sweating, faintness, or pain spreading to the arm or jaw requires emergency assessment.",
  "Chikungunya Virus Infection" => "Chikungunya is a mosquito-borne viral infection that usually causes abrupt fever and severe joint pain, sometimes with rash, headache, or conjunctivitis. Joint symptoms can persist; care is supportive, mosquito exposure should be reduced, and severe illness requires assessment.",
  "Child Abuse Facts" => "Child abuse includes physical or emotional harm, sexual abuse, exploitation, or neglect by a caregiver or other person. Possible signs include unexplained injuries, developmental change, fear, poor hygiene, or inconsistent explanations; suspected abuse should be reported through local protection services or emergency channels.",
  "Children's Cough Causes and Treatments" => "Children cough with viral infection, asthma, allergies, reflux, airway irritation, or an inhaled object. Treatment depends on cause and age; breathing difficulty, stridor, blue color, dehydration, sudden onset, or a cough lasting beyond expected recovery needs medical evaluation.",
  "Children's Health" => "Children's health includes growth, development, nutrition, immunization, sleep, mental health, injury prevention, and management of acute or chronic illness. Care is guided by developmental stage, family context, preventive visits, and early recognition of concerning changes.",
  "Chlamydia in Women Overview" => "Chlamydia is a sexually transmitted infection caused by Chlamydia trachomatis and may cause no symptoms. Untreated infection can lead to cervicitis, pelvic inflammatory disease, infertility, ectopic pregnancy, or infection in a newborn; testing and treatment of partners are important.",
  "Choledochal Cysts" => "Choledochal cysts are congenital or acquired dilations of the bile ducts that can cause abdominal pain, jaundice, pancreatitis, cholangitis, or stones. Imaging establishes the anatomy, and surgical removal is often recommended because of recurrent complications and cancer risk.",
  "Cholesterol Management" => "Cholesterol management combines cardiovascular-risk assessment with dietary pattern, physical activity, tobacco avoidance, weight care, and medicines when indicated. Statins and other agents lower atherogenic lipoproteins, with intensity chosen according to prior cardiovascular disease and overall risk.",
  "Ciguatera Poisoning" => "Ciguatera poisoning follows eating reef fish containing ciguatoxins. Gastrointestinal symptoms may be followed by neurologic sensations such as temperature reversal, tingling, itching, weakness, or abnormal heart rate; treatment is supportive and prevention depends on avoiding high-risk fish.",
  "Cleft Palate and Cleft Lip" => "Cleft lip and cleft palate are congenital openings caused by incomplete fusion of facial structures during development. They can affect feeding, speech, hearing, teeth, and breathing and are managed by coordinated surgical, dental, speech, hearing, and nutritional care.",
  "Clostridium Difficile Colitis" => "Clostridioides difficile colitis is antibiotic-associated inflammation of the colon caused by toxin-producing bacteria. It causes watery diarrhea, abdominal pain, fever, and sometimes severe colitis; diagnosis and treatment depend on symptoms, testing, recurrence, and severity.",
  "Club Drugs List and Side Effects" => "Club drugs include substances such as MDMA, ketamine, GHB, and others used recreationally in social settings. Effects may include agitation, hallucinations, seizures, dangerous temperature elevation, respiratory depression, cardiovascular toxicity, impaired consent, and overdose.",
  "Cluster Headaches" => "Cluster headache causes repeated attacks of severe one-sided orbital or temporal pain with tearing, nasal symptoms, eyelid drooping, or restlessness. Attacks occur in bouts and require targeted acute and preventive treatment; a first sudden severe headache needs urgent evaluation.",
  "Cocaine and Crack Abuse" => "Cocaine and crack use can cause dependence, agitation, paranoia, seizures, stroke, heart attack, dangerous arrhythmias, pregnancy complications, and nasal or lung injury. Treatment combines safety assessment, management of intoxication or withdrawal, behavioral care, and support for substance-use disorder.",
  "Cold and Cough Medicine for Infants and Children" => "Many nonprescription cold and cough medicines are unsafe or ineffective for young children and can cause sedation, agitation, abnormal heart rate, overdose, or breathing problems. Age-appropriate fluids, saline, humidification, and clinician-guided treatment are safer approaches.",
  "Cold, Flu, Allergy" => "Colds, influenza, and allergies can all cause nasal symptoms and cough but differ in cause, fever pattern, duration, and contagiousness. Viral illness usually improves with supportive care, while allergies respond to trigger reduction and appropriate antihistamine or nasal treatment.",
  "Colon Cancer Prevention" => "Colorectal-cancer risk can be reduced through recommended screening, physical activity, healthy weight, limiting alcohol, avoiding tobacco, and a diet rich in fiber-containing plant foods. Screening can detect precancerous polyps and early cancer before symptoms develop.",
  "Common Cold Stages and Timeline of Symptoms" => "The common cold often begins with sore throat, sneezing, or fatigue, followed by nasal congestion, runny nose, and cough. Symptoms usually peak within several days and improve over one to two weeks, although cough and fatigue may last longer.",
  "Common Early Symptoms of Myasthenia Gravis" => "Early myasthenia gravis commonly causes fluctuating, fatigable weakness of the eyelids, eye movements, facial muscles, chewing, swallowing, speech, neck, or limbs. Symptoms worsen with use and improve with rest; breathing or swallowing difficulty is an emergency.",
  "Common Medical Abbreviations and Terms" => "Medical abbreviations and terms summarize diagnoses, tests, medicines, anatomy, and treatment instructions. Because abbreviations can be ambiguous or unsafe, patients should ask clinicians or pharmacists to explain unfamiliar wording rather than infer its meaning.",
  "Conditions Caused by Deletion Mutations" => "Deletion mutations remove DNA segments and can disrupt one gene or several neighboring genes. The clinical effect depends on size, location, inheritance, and whether the remaining copy compensates; genetic counseling and testing may clarify diagnosis and recurrence risk.",
  "COPD vs. Asthma Differences and Similarities" => "Asthma usually has variable, reversible airway narrowing, while chronic obstructive pulmonary disease causes persistent airflow limitation associated most often with smoking or long-term irritant exposure. Both can cause cough and wheeze, but testing, course, and treatment differ.",
  "COPD vs. Emphysema Differences Similarities" => "Emphysema is structural destruction of alveoli and one component of chronic obstructive pulmonary disease. COPD may also include chronic bronchitis and small-airway disease; symptoms, spirometry, imaging, exposure history, and exacerbations guide distinction and care.",
  "Corneal Disease" => "Corneal disease affects the transparent front surface of the eye through infection, inflammation, trauma, dystrophy, degeneration, dryness, or abnormal shape. Pain, redness, light sensitivity, discharge, or reduced vision can signal urgent disease because scarring may impair sight.",
  "Corns" => "A corn is a localized thickening of skin caused by repeated pressure or friction, commonly on toes or other weight-bearing areas. Proper footwear, pressure relief, and treatment of the underlying deformity help; diabetes or poor circulation makes self-removal risky.",
  "Correct Code for Diagnostic Dilation and Curettage" => "Dilation and curettage is a procedure that opens the cervix and removes tissue from the uterus for diagnosis or treatment. Coding depends on the indication, setting, technique, pregnancy status, and tissue findings and should be assigned from the documented procedure.",
  "Cosmetic Allergies" => "Cosmetic products can cause irritant dermatitis or allergic contact dermatitis, producing itching, redness, swelling, scaling, or blistering where applied. Stopping the suspected product and medical assessment, sometimes with patch testing, help identify the responsible ingredient.",
  "Costochondritis and Tietze Syndrome" => "Costochondritis is inflammation or irritation at the junction of ribs and the breastbone, causing reproducible chest-wall pain. Tietze syndrome is a less common related condition with visible swelling at one or a few joints; heart and lung emergencies must still be excluded.",
  "Could a Stiff Neck Be a Sign of Something Serious" => "Neck stiffness commonly follows muscle strain, but stiffness with fever, severe headache, light sensitivity, confusion, rash, weakness, trauma, or neurologic change can signal meningitis, bleeding, spinal injury, or another emergency.",
  "COVID-19 Prevention Tips" => "COVID-19 prevention combines staying current with recommended vaccination, improving indoor ventilation, avoiding close exposure when ill, testing when indicated, masking in higher-risk settings, and hand or respiratory hygiene. Recommendations change with local transmission and individual risk.",
  "COVID-19 vs. Allergies" => "COVID-19 may cause fever, sore throat, cough, fatigue, body aches, or loss of smell, while allergies more often cause itching, sneezing, watery eyes, and recurrent symptoms without fever. Testing and exposure history help distinguish them.",
  "COVID-19 vs. Flu vs. Cold" => "COVID-19, influenza, and common colds overlap in respiratory symptoms and cannot always be distinguished by symptoms alone. Testing, exposure, season, severity, and risk factors guide diagnosis; breathing difficulty, chest pain, confusion, or dehydration requires urgent care.",
  "CPT Code for Foreign Body Removal From the Ear" => "Removal of an ear foreign body is coded according to the documented method, location, anesthesia, complications, and whether a separate evaluation was performed. Objects causing pain, bleeding, hearing loss, or suspected eardrum injury should be removed by a trained clinician.",
  "cramps but no period" => "Pelvic cramps without menstruation can result from ovulation, pregnancy, implantation, constipation, urinary disease, infection, endometriosis, cysts, or other pelvic conditions. Severe one-sided pain, faintness, fever, vomiting, or possible pregnancy requires urgent assessment.",
  "CRE Infection" => "Carbapenem-resistant Enterobacterales are bacteria resistant to important antibiotics and can cause urinary, bloodstream, abdominal, wound, or lung infections. Infection-control precautions, culture-based treatment, and specialist advice are important because therapeutic options may be limited.",
  "Critical Limb Ischemia vs. Acute Limb Ischemia" => "Chronic limb-threatening ischemia develops gradually from severe arterial disease and causes rest pain, nonhealing wounds, or tissue loss. Acute limb ischemia occurs suddenly with pain, pallor, pulselessness, numbness, weakness, or coldness and requires emergency revascularization assessment.",
  "Crohns Disease vs Ulcerative Colitis UC" => "Crohn disease can affect any part of the gastrointestinal tract and often involves patchy, full-thickness inflammation, while ulcerative colitis affects the colon continuously from the rectum with superficial mucosal inflammation. Symptoms overlap, but imaging, endoscopy, and biopsy help distinguish them.",
  "Crohn’s Disease Cause Dark Circles Around Eyes" => "Crohn disease does not directly cause dark circles in every patient, but anemia, fatigue, dehydration, poor sleep, nutritional deficiency, steroid effects, or atopic skin may contribute. Persistent pallor, fatigue, weight loss, bleeding, or active bowel symptoms deserve clinical review.",
  "Cuts, Scrapes and Puncture Wounds" => "Cuts, scrapes, and puncture wounds damage the skin to varying depths and can introduce bacteria or foreign material. Clean minor wounds with running water, control bleeding, cover them, and seek care for deep or contaminated wounds, bites, impaired circulation, infection, or uncertain tetanus protection.",
  "Cystic Acne" => "Cystic acne is severe inflammatory acne with deep painful nodules or cyst-like lesions that can scar. Treatment may require prescription retinoids, antimicrobial or hormonal therapy, or isotretinoin under specialist monitoring; squeezing lesions increases scarring.",
  "Cystitis (Bladder Infection)" => "Cystitis is inflammation of the bladder, most often from a bacterial urinary-tract infection. It causes burning urination, frequency, urgency, and lower-abdominal discomfort; fever, flank pain, vomiting, pregnancy, or recurrent infection requires prompt assessment."
}.freeze

def latex_escape(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

def excluded_title?(term)
  term.start_with?('Can ', 'Can’t ') ||
    term =~ /^(Cacao Nibs|Cochlear Implant Success Rate|Common Causes of Pregnancy Discomforts|Common Phrases Used by Covert Narcissists|Concern About|Conditions Can Be Mistaken|Causes House Gnats|Causes of |Characteristics and Symptoms|Chances of |Cigarette Smoking vs|Circumcised vs|Cloth Diapers vs|Cold vs Flu|Canker Sores Last|Can’t Sleep|Coping|Foods|Good for|Health|How|Is |What|Why|When)/
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
text = File.read(output)
existing_titles = text.scan(/^\\medterm\{([^}]*)\}/).flatten
existing = existing_titles.to_h { |title| [normalize(title), true] }
terms = File.readlines(input, chomp: true).reject { |term| excluded_title?(term) }
additions = []

terms.each do |term|
  next if existing[normalize(term)]
  definition = DEFINITIONS[term]
  unless definition
    opening = term.index('(')
    definition = "Alternate index label for #{latex_escape(term[(opening + 1)...-1])}." if opening
  end
  raise "No specific definition for #{term}" unless definition
  additions << [term, definition]
end

File.open(output, 'a') do |file|
  additions.each do |term, definition|
    file.puts
    file.puts "\\medterm{#{term}} #{definition}"
    file.puts
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
