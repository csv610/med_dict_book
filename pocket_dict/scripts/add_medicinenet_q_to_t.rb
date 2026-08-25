#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  "Reflex Sympathetic Dystrophy Syndrome" => "Reflex sympathetic dystrophy is the former name for complex regional pain syndrome, usually following injury or surgery. Disproportionate burning pain, swelling, temperature or color change, sweating, and stiffness can spread beyond the original site.",
  "Restless Leg Syndrome" => "Restless legs syndrome causes an urge to move the legs with uncomfortable sensations that worsen at rest and in the evening and improve temporarily with movement. Iron deficiency, kidney disease, medicines, pregnancy, and genetics may contribute.",
  "Rheumatoid Arthritis Cause Gastrointestinal Issues" => "Rheumatoid arthritis can affect the gastrointestinal system indirectly through inflammation, associated autoimmune disease, reduced mobility, or medicines such as nonsteroidal anti-inflammatory drugs. Abdominal pain, bleeding, persistent diarrhea, or weight loss needs evaluation rather than attribution to arthritis alone.",
  "Rheumatoid Arthritis Inflammation of the Brain" => "Direct brain inflammation is uncommon in rheumatoid arthritis, but vasculitis, medication effects, infection, stroke risk, or another autoimmune process can cause neurologic symptoms. New confusion, seizure, weakness, severe headache, or vision change requires urgent assessment.",
  "Rigid and Flexible Sigmoidoscopy" => "A sigmoidoscopy examines the rectum and lower colon with a flexible or rigid instrument. It can evaluate bleeding, pain, altered bowel habits, inflammation, polyps, or tumors; preparation, reach, comfort, and biopsy capability differ by technique.",
  "Ruptured Perforated Eardrum" => "A perforated eardrum is a tear in the tympanic membrane from infection, pressure change, trauma, or an inserted object. Pain, drainage, hearing loss, or ringing may occur; keeping the ear dry and avoiding unprescribed drops helps while healing or repair is assessed.",
  "Sacroiliac Joint Pain" => "Sacroiliac-joint pain arises near the junction of the lower spine and pelvis and may follow injury, pregnancy, arthritis, leg-length or gait changes, or inflammation. Pain can radiate to the buttock or thigh; examination distinguishes it from hip or spine disease.",
  "Scars" => "A scar is fibrous tissue formed during healing after injury, surgery, inflammation, or burns. Scars may be flat, depressed, raised, or contractured and can itch, hurt, restrict movement, or affect appearance; treatment depends on maturity and type.",
  "Sciatica: Causes, Treatment, and Symptoms" => "Sciatica is radiating pain, tingling, numbness, or weakness along the sciatic-nerve distribution, commonly from lumbar disc herniation or spinal narrowing. Most cases improve with conservative care, but saddle numbness, bowel or bladder dysfunction, or progressive weakness is urgent.",
  "Seborrhea" => "Seborrhea is excessive or altered oil production that contributes to greasy scale and inflammation, commonly in seborrheic dermatitis of the scalp, face, or chest. Gentle cleansing, medicated shampoos, and topical anti-inflammatory or antifungal treatment may help.",
  "Seizures Symptoms and Types" => "Seizures are episodes of abnormal electrical brain activity that may cause staring, altered awareness, unusual sensations, stiffening, rhythmic movements, loss of tone, or post-event confusion. First seizure, prolonged seizure, injury, pregnancy, or repeated events requires urgent care.",
  "semaglutide" => "Semaglutide is a glucagon-like peptide-1 receptor agonist used for selected patients with type 2 diabetes or chronic weight management. It slows gastric emptying and reduces appetite and glucose levels; nausea, gallbladder disease, pancreatitis risk, and contraindications require review.",
  "Sentinel Lymph Node Biopsy for Melanoma" => "Sentinel lymph-node biopsy identifies and removes the first draining lymph node or nodes from a melanoma site to detect microscopic spread. The result helps stage disease and guide further treatment; it does not remove all regional nodes routinely.",
  "Separation Anxiety" => "Separation anxiety is developmentally excessive fear or distress when apart from an attachment figure, causing avoidance, physical complaints, sleep problems, or impairment. Treatment may include gradual exposure, family-based support, cognitive behavioral therapy, and selected medication.",
  "Sexual Addiction" => "Compulsive sexual behavior involves persistent difficulty controlling sexual thoughts or behaviors despite distress or harm. It is not simply a high sex drive; assessment considers mood disorders, trauma, substance use, relationships, consent, and evidence-based behavioral treatment.",
  "Sexual Health Overview" => "Sexual health includes physical, emotional, mental, and social well-being in relation to sexuality and relationships. It includes consent, contraception, sexually transmitted infection prevention and testing, fertility, sexual function, safety, and respectful communication.",
  "Sharp Pains in Your Stomach During Pregnancy" => "Sharp abdominal pain in pregnancy may result from ligament stretching, gas, constipation, uterine contractions, urinary disease, ectopic pregnancy, placental complications, or other causes. Severe or persistent pain, bleeding, fever, faintness, vomiting, or reduced fetal movement needs urgent obstetric assessment.",
  "Shin Splints" => "Shin splints is common exertional pain along the inner border of the shin, often caused by increased training load, surface, footwear, or biomechanics. Rest from aggravating activity, gradual conditioning, and rehabilitation help; focal bone pain may indicate a stress injury.",
  "Shingles and Pregnancy" => "Shingles is reactivation of varicella-zoster virus and usually causes a painful one-sided blistering rash. It is not the same as primary chickenpox exposure, but pregnancy requires prompt clinical advice about treatment, pain, and contact with people at risk.",
  "Shoulder Bursitis" => "Shoulder bursitis is inflammation of a fluid-filled sac around the shoulder, often associated with rotator-cuff disease or repetitive overhead activity. Pain with elevation and lying on the affected side is common; activity modification, therapy, medicines, injection, or treatment of the underlying cause may help.",
  "Sick Building Syndrome" => "Sick building syndrome describes nonspecific symptoms such as headache, fatigue, eye or throat irritation, cough, dizziness, or nausea associated with time in a building and improving away from it. Ventilation, humidity, pollutants, mold, and other environmental factors should be assessed.",
  "Sickle Cell" => "Sickle-cell disease is an inherited hemoglobin disorder causing red cells to become rigid and sickle-shaped, leading to anemia, painful vaso-occlusive episodes, infection risk, stroke, acute chest syndrome, and organ damage. Comprehensive preventive and disease-modifying care is needed.",
  "Silent Sinus Syndrome" => "Silent sinus syndrome is painless inward collapse of the maxillary sinus and floor of the orbit, often causing facial asymmetry, enophthalmos, or a sunken eye. Imaging confirms the diagnosis, and endoscopic treatment restores sinus ventilation when indicated.",
  "Sinus Headache" => "Pain attributed to a sinus headache is often migraine, but sinus inflammation can cause facial pressure, congestion, reduced smell, and pain that worsens with bending. Fever, purulent discharge, persistent symptoms, or eye or neurologic signs guide evaluation.",
  "Skin Anatomy Picture Definition Function" => "Skin consists of epidermis, dermis, and subcutaneous tissue with appendages such as hair, nails, glands, nerves, vessels, and immune cells. It forms a barrier, regulates temperature, senses the environment, prevents fluid loss, and participates in immunity and vitamin D production.",
  "Skin Cancer Overview" => "Skin cancer includes basal-cell carcinoma, squamous-cell carcinoma, melanoma, and less common tumors. Ultraviolet exposure, immune suppression, genetic susceptibility, and certain lesions increase risk; a changing, bleeding, nonhealing, or unusual lesion needs examination.",
  "Skin Tag" => "A skin tag is a benign soft growth of connective tissue, commonly in body folds and associated with friction, age, pregnancy, obesity, or insulin resistance. Removal may be performed for irritation or appearance, but a changing or atypical lesion should be diagnosed first.",
  "Sleep and Sleep Disorders in Children and Teens" => "Children and teens need age-appropriate sleep, and disorders may involve insomnia, circadian delay, sleep apnea, parasomnias, restless legs, or insufficient opportunity. Snoring, pauses in breathing, unusual daytime sleepiness, mood change, or poor school performance warrants evaluation.",
  "Sleep Related Breathing Disorders" => "Sleep-related breathing disorders cause abnormal ventilation or oxygenation during sleep, including obstructive and central sleep apnea and sleep-related hypoventilation. Snoring, witnessed pauses, gasping, morning headache, or daytime sleepiness may prompt sleep testing and treatment.",
  "Smokeless Tobacco" => "Smokeless tobacco delivers nicotine and causes dependence, oral lesions, gum recession, tooth loss, cardiovascular risk, and cancers of the mouth, throat, and pancreas. Quitting reduces harm, and counseling plus approved medicines improve cessation success.",
  "Snake Bite" => "Snake bites can cause puncture wounds, tissue injury, bleeding, paralysis, or venom-related effects on clotting, nerves, muscles, kidneys, or the heart. Call emergency services, keep the person still, and do not cut, suck, ice, or tourniquet the wound.",
  "Social and Psychological Causes of Alcoholism" => "Alcohol-use disorder reflects interactions among genetics, brain reward pathways, stress, trauma, mental illness, social environment, and alcohol availability—not a moral failure. Treatment may include withdrawal care, counseling, peer support, and medicines that reduce drinking or relapse.",
  "Spinal Cord Injury: Treatments and Rehabilitation" => "Spinal-cord injury can cause temporary or permanent weakness, sensory loss, autonomic dysfunction, and bowel or bladder problems. Acute care protects the spine and treats complications; rehabilitation addresses mobility, skin, breathing, function, equipment, sexuality, and community participation.",
  "Sprained Ankle" => "An ankle sprain is stretching or tearing of ligaments, usually after rolling the ankle inward. Pain, swelling, bruising, and instability occur; protection, relative rest, compression, elevation, and progressive rehabilitation help, while inability to bear weight may require imaging.",
  "Still's Disease" => "Still disease is a systemic inflammatory disorder causing high spiking fever, arthritis, rash, and sometimes organ inflammation. Adult-onset and systemic juvenile forms can affect the heart, lungs, liver, or blood and require specialist anti-inflammatory or immunomodulatory treatment.",
  "Streptococcal Infections" => "Streptococcal bacteria can cause throat infection, scarlet fever, skin infection, pneumonia, invasive bloodstream disease, and post-infectious complications. Diagnosis and antibiotic choice depend on site and testing; severe pain, rapid spread, sepsis signs, or breathing difficulty is urgent.",
  "Stroke Symptoms and Treatment" => "Stroke is brain injury from blocked blood flow or bleeding. Sudden facial droop, arm weakness, speech trouble, vision change, imbalance, or severe headache requires emergency activation; treatment may include clot-busting medicine, thrombectomy, bleeding control, and rehabilitation.",
  "Syphilis in Women Overview" => "Syphilis is a sexually transmitted infection caused by Treponema pallidum and progresses through stages that may include painless sores, rash, neurologic or cardiovascular disease, or no symptoms. Penicillin treatment cures infection and is essential in pregnancy to prevent congenital disease.",
  "Systemic Lupus" => "Systemic lupus erythematosus is an autoimmune disease that can affect skin, joints, kidneys, blood, nervous system, lungs, and heart. Symptoms fluctuate, and treatment is tailored to organ involvement with sun protection, monitoring, and immunomodulatory medicines.",
  "Thallium" => "Thallium is a toxic heavy metal that can cause gastrointestinal illness followed by painful peripheral neuropathy, hair loss, skin changes, kidney or liver injury, seizures, and cardiovascular or neurologic toxicity. Suspected exposure requires immediate poison-control or emergency guidance.",
  "Thrush and Other Yeast Infections in Children" => "Thrush is Candida overgrowth in the mouth, producing white plaques, soreness, or feeding difficulty; Candida can also affect skin folds or diaper areas. Persistent, recurrent, severe, or immune-associated infection needs pediatric evaluation and appropriate antifungal treatment.",
  "Thymic Hyperplasia" => "Thymic hyperplasia is enlargement of the thymus from increased lymphoid tissue or rebound growth and may be incidental. It can be associated with autoimmune disease, infection, endocrine conditions, or stress; imaging and clinical context distinguish it from a mass.",
  "Thyroid Disease Symptoms and Signs" => "Thyroid disease can cause symptoms of underactivity, overactivity, inflammation, nodules, or hormone excess, including fatigue, weight change, heat or cold intolerance, palpitations, bowel change, tremor, neck swelling, or menstrual disturbance. Blood testing guides evaluation.",
  "Thyroid Nodules" => "A thyroid nodule is a discrete growth within the thyroid and is often benign. Ultrasound, thyroid-function testing, and selected needle biopsy assess cancer risk; rapid growth, hoarseness, swallowing difficulty, or breathing problems needs prompt review.",
  "Ticks" => "Ticks are blood-feeding parasites that can transmit infections such as Lyme disease, ehrlichiosis, anaplasmosis, babesiosis, and Rocky Mountain spotted fever. Prompt removal with fine-tipped tweezers and monitoring for fever or rash reduce complications.",
  "Tonsil Stones" => "Tonsil stones are calcified collections of debris and bacteria in tonsil crypts, causing bad breath, throat irritation, or a foreign-body sensation. Gargling and oral hygiene may help; recurrent symptoms, bleeding, or one-sided enlargement requires examination.",
  "Toothache Overview" => "Toothache usually reflects decay, pulp inflammation, fracture, gum disease, abscess, trauma, or referred pain. Dental treatment is needed to correct the cause; facial swelling, fever, difficulty swallowing, or breathing difficulty requires urgent care.",
  "Torn ACL" => "A torn anterior cruciate ligament is a knee injury commonly caused by sudden pivoting, landing, or contact, producing a pop, swelling, instability, and difficulty changing direction. Rehabilitation, bracing, or reconstruction is selected according to activity, associated injury, and goals.",
  "Torn Meniscus" => "A torn meniscus is a split in the knee's shock-absorbing cartilage caused by twisting or degeneration. Pain, swelling, catching, or locking may occur; physical therapy or arthroscopic treatment depends on tear pattern, symptoms, age, and associated disease.",
  "Tracheostomy vs Cricothyroidotomy" => "A tracheostomy creates an airway through the neck into the trachea, usually for prolonged airway support, while cricothyroidotomy enters through the membrane above the trachea as an emergency rescue airway. Both require trained procedural care and complication monitoring."
}.freeze

def excluded_title?(term)
  term =~ /^(Can |Do |Does |Are |Is |What |Why |How |Best |Fastest |First |Early |Easiest |Eat |Eating |Exercises |Foods |Figure |Father|Dealing|Difference|Differences|Disadvantages|Dandruff vs|Drink |Drinking |Duration|Good |Get |Get Rid|Having |Healthy Living|Health and|Tips|Ways|Should |Before|After|Common|Cochlear|Four |Exposure|Directives|Advantages|Coping|Dream|Weigh|Weight|Life Expectancy|Life With|Lose |Losing |Long-Term|Low FODMAP|Low-Glycemic|Left Brain|Labor Duration|Labor Pain|Gastroparesis Diet|Loss, Grief|Grief|Glycemic|Gambling|Healthy|Main |Make |Meaning |Most |Mirena |Mens Health|Menopause and Sex|Metabolic Syndrome Diet|MyPlate|Natural |Nature |Neuroendocrine Tumor the Same|Neurological Disorders Cause|Nightshade|Nonsurgical|Normal |Oldest |Overcoming|Ovulation Calculator|Palmitic|Parenting|Parkinson.s Disease: Eating|Part of the Body|Pathological Liar|Physically Fit|Poison Control|Prebiotics|Pregnancy Symptoms|Pregnancy: Your Guide|Protect Your Teeth|PMS vs|Pimple vs|Pancoast Tumor Lung Cancer|Pancreatic Cancer Be|Pancreatic Neuroendocrine Tumors Metastasize|Most Effective|Non-Itchy|Non-Small Cell.*vs|Oxycodone vs|Over-the-Counter|Osteoblast vs|Osteoarthritis vs|Patellofemoral Syndrome|Pneumonia Facts|Pain From|PMS|Pediatric|Pelvic Inflammatory Disease Without|Pelvic Pain|Pimple vs|Pathological|Parenting|Pregnancy:|Pregnancy Diet|Preparing for Pregnancy|Panic|Quackery|Quick |Radical |Recommended |Recovery |Role |Safe |Seizure vs|Set Point|Sever |Side Effects|Signs |Shoulder and Neck Pain|Sleep Aids|Smoker.s Lung|Smoking |Sore Throat Home|Stop |Stress Management|Success Rate|Survival Rate|Symptoms |The |Take |Talk |Target |Teen|Tell |Test HIV|Three |Top |Treat |Treatment |True |Types |Typical |Most Serious|Most Severe|Best Treatment|Fastest|Thyroid Storm vs|Thyroid-Problems|Turf Toe|Tylenol Liver Damage|Treatment Options|Treatment Get|Treatment How|treatment |Type 1 vs|Teenagers|Safe Cold|Stomach Cancer Survival|Spotting vs|Sun Protection|Sunburn|Stool Color|Spleen Problems|Spondylitis vs|Stages of Puberty|STDs|Stem Cells|Steroid Withdrawal|Success Rate|Stroke vs|Pneumonia|Palmitic|Parenting|Part of|PMS|Pimple vs)/i || term =~ /\bvs\.?\b/i
end

def latex_escape(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

%w[P Q R S T].each do |letter|
  input = "/tmp/medicinenet_#{letter}_terms.txt"
  output = "chapters/med_terms_#{letter.downcase}.tex"
  text = File.read(output)
  existing = text.scan(/^\\medterm\{([^}]*)\}/).flatten.to_h { |title| [normalize(title), true] }
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
  puts "#{letter}: added #{additions.length} terms"
end
