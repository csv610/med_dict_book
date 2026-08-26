MARKER = /is a medical or biological concept whose definition|is an anatomical or physiologic term describing|is an anatomical or histologic term describing|is a biological, genetic, biochemical, or chemical term used|is a disease, symptom, syndrome, or clinical finding|is a diagnostic or laboratory test, method, or measurement|describes a clinical disorder or finding in the body system|is a healthcare or clinical-care term/i

C = {
'Chapped hands'=>'Dry, cracked, inflamed skin of the hands caused by irritants, cold, low humidity, frequent washing, eczema, or allergy; fissures can become painful or infected.',
'Chapped lips'=>'Dry, scaling, fissured lips caused by weather, licking, dehydration, irritants, medicines, or cheilitis; persistent lesions need assessment for infection or another disorder.',
'Charley horse'=>'A sudden painful involuntary contraction or spasm of a muscle, commonly in the calf or thigh, often related to exertion, dehydration, nerve disease, or medicines.',
'Chicken soup and sickness'=>'A supportive-care topic concerning the use of warm fluids and nutrition during illness; chicken soup may ease hydration or congestion but does not replace diagnosis or treatment.',
'Chiggers'=>'Larval harvest mites whose bite causes intensely itchy grouped red papules or welts; symptoms result from skin irritation, not from the mite burrowing into human tissue.',
'Child physical abuse'=>'Intentional physical injury or harm inflicted on a child by a caregiver or another person, including hitting, burning, shaking, or fractures; suspected abuse requires immediate safeguarding assessment.',
'Children and grief'=>'The emotional and behavioral response of children to death or major loss, which varies by developmental stage and may include sadness, regression, anger, worry, or physical symptoms.',
'Chin augmentation'=>'A cosmetic procedure that increases chin projection with an implant, injectable filler, or bone surgery to change facial contour; risks include infection, asymmetry, nerve injury, and implant problems.',
'Choking - adult or child over 1 year'=>'First aid for severe airway obstruction in a person older than one year, using back blows and abdominal thrusts when appropriate and CPR if the person becomes unresponsive.',
'Choking - infant under 1 year'=>'First aid for severe airway obstruction in an infant, using alternating back slaps and chest thrusts and avoiding blind finger sweeps; unresponsiveness requires infant CPR.',
'Choking - unconscious adult or child over 1 year'=>'Resuscitation for an unresponsive person with suspected airway obstruction, combining emergency activation, airway inspection, CPR, and removal of a visible object without blind sweeping.',
'Cholinesterase - blood'=>'A blood test measuring acetylcholinesterase or butyrylcholinesterase activity, useful in selected pesticide exposures, inherited enzyme variants, and some liver-function assessments.',
'Choroidal dystrophies'=>'Inherited disorders causing progressive degeneration of the choroid, retinal pigment epithelium, and retina, leading to night blindness, visual-field loss, and eventual vision impairment.',
'Chromatography'=>'A laboratory separation method in which substances partition between a stationary phase and a moving phase, allowing identification or measurement of components in a mixture.',
'Chronic subdural hematoma'=>'A collection of blood and breakdown products between the dura and arachnoid that develops over weeks, often after minor trauma in older adults, causing headache, confusion, weakness, or gait change.',
'Clean catch urine sample'=>'A midstream urine specimen collected after cleaning the genital area to reduce contamination and improve interpretation of urinalysis or culture.',
'Cleaning supplies and equipment'=>'Materials and devices used to remove soil and microorganisms from surfaces or equipment; selection and disinfection level depend on the item and infection risk.',
'Cleaning to prevent the spread of germs'=>'Cleaning and disinfection practices that remove or inactivate infectious organisms on hands, surfaces, equipment, and shared objects to reduce transmission.',
'Cloudy cornea'=>'Loss of corneal transparency from edema, scarring, infection, dystrophy, trauma, or deposits, potentially causing blurred vision, pain, photophobia, or glare.',
'Clubbing of the fingers or toes'=>'Bulbous enlargement of fingertip or toe soft tissue with increased nail curvature caused by chronic changes in the nail bed; it can accompany lung, heart, gastrointestinal, or other disease.',
'Cold medicines and children'=>'Safety guidance for giving medicines to children with cold symptoms; many combination products provide little benefit in young children and can cause dosing errors or serious adverse effects.',
'Colds and flu - antibiotics'=>'An explanation that antibiotics treat susceptible bacterial infections, not uncomplicated viral colds or influenza; unnecessary use causes adverse effects and antimicrobial resistance.',
'College students and the flu'=>'Influenza prevention and care for college students, emphasizing vaccination, hand and respiratory hygiene, staying home when ill, and prompt assessment for severe symptoms or high-risk conditions.',
'Coloboma of the iris'=>'A congenital keyhole- or notch-shaped defect in the iris caused by incomplete embryonic closure, sometimes associated with colobomas in the retina, optic nerve, or other organs.',
'Cologuard'=>'A stool-based colorectal-cancer screening test combining DNA-marker analysis with a fecal blood test; a positive result requires diagnostic colonoscopy.',
'Comedones'=>'Plugs of sebum and keratin within hair follicles, appearing as open blackheads or closed whiteheads and representing a primary lesion of acne.',
'Common symptoms during pregnancy'=>'Frequent pregnancy-related symptoms such as nausea, fatigue, breast tenderness, heartburn, constipation, and urinary frequency; severe, sudden, or unusual symptoms may signal complications.',
'Communicating with patients'=>'The clinical exchange of information, concerns, preferences, and decisions between healthcare professionals and patients, using clear language, listening, empathy, and confirmation of understanding.',
'Communicating with someone with aphasia'=>'Communication strategies for a person with impaired language from brain injury or disease, including short sentences, extra time, visual cues, and supported conversation rather than assuming impaired intelligence.',
'Communicating with someone with dysarthria'=>'Communication strategies for a person whose speech muscles are weak or poorly coordinated, including reducing background noise, confirming messages, and using writing or augmentative aids when needed.',
'Compression stockings'=>'Elastic garments that apply graduated pressure to the legs, supporting venous return and reducing swelling or selected risks of venous pooling; correct fit and arterial circulation matter.',
'Compulsive gambling'=>'Persistent gambling with impaired control, preoccupation, chasing losses, and continued behavior despite financial, social, occupational, or emotional harm, also called gambling disorder.',
'Condoms - male'=>'A sheath placed over the penis during sexual activity to reduce exchange of semen and genital secretions and lower pregnancy and sexually transmitted infection risk when used correctly.',
'Confusion'=>'Impaired ability to think clearly, orient, attend, remember, or respond appropriately; sudden confusion is delirium and may indicate infection, medication effect, metabolic illness, stroke, or another emergency.',
'Congenital rubella'=>'Fetal infection with rubella virus acquired during pregnancy, potentially causing hearing loss, cataracts, congenital heart disease, developmental impairment, and other findings.',
'Constipation in infants and children'=>'Infrequent, hard, painful, or difficult passage of stool in a child, caused by stool withholding, diet, dehydration, illness, medicines, or structural and neurologic disorders.',
'Controlling your high blood pressure'=>'Long-term blood-pressure management using accurate measurement, lifestyle measures, prescribed medicines, adherence, and monitoring for complications and treatment adverse effects.',
'Cooking without salt'=>'Preparing food with little or no added sodium to reduce dietary sodium intake, often useful in blood-pressure or fluid-retention management when combined with an individualized eating plan.',
'COPD - managing stress and your mood'=>'Support for anxiety, depression, and stress in chronic obstructive pulmonary disease through breathing strategies, activity, pulmonary rehabilitation, counseling, and treatment when indicated.',
'COPD and other health problems'=>'The interaction between chronic obstructive pulmonary disease and conditions such as cardiovascular disease, osteoporosis, depression, diabetes, and lung cancer, which can complicate symptoms and care.',
'COPD flare-ups'=>'Acute worsening of breathlessness, cough, or sputum beyond usual daily variation in chronic obstructive pulmonary disease, often triggered by infection, pollution, or other irritants.',
'COVID-19 – what to do when you are sick'=>'Home-care and infection-control guidance for illness caused by SARS-CoV-2, including testing, staying away from others, hydration, symptom monitoring, and prompt care for breathing difficulty or high-risk disease.',
'COVID-19 symptoms'=>'Symptoms of SARS-CoV-2 infection, which may include fever, cough, sore throat, congestion, fatigue, muscle aches, headache, loss of smell or taste, vomiting, or diarrhea.',
'COVID-19 vaccine - what you need to know'=>'Information about vaccines that reduce the risk of severe COVID-19, including eligibility, updated formulations, expected reactions, rare adverse events, and the need for recommendations to change over time.',
'COVID-19 vaccines'=>'Vaccines that prime immune responses against SARS-CoV-2 and reduce severe disease, hospitalization, and death; products, schedules, effectiveness, and recommendations vary by age and risk.',
'COVID-19 vaccines for children ages 6 months and older'=>'COVID-19 vaccination guidance for children at least six months old, with product and dose schedules determined by age, prior doses, immune status, and current public-health recommendations.',
"Cow's milk - infants"=>'Guidance on cow’s milk in infancy: it should not replace breast milk or iron-fortified formula before 12 months because of low iron content and risks of renal solute load and intestinal blood loss.',
"Cow's milk and children"=>'Nutritional guidance on cow’s milk for children, balancing protein, calcium, vitamin D, fat, iron, allergy, and total intake so milk does not displace a varied diet.',
'CPR - young child (age 1 year to onset of puberty)'=>'Cardiopulmonary resuscitation for a child from age one year until puberty who is unresponsive and not breathing normally, using emergency activation, compressions, breaths, and an AED as available.',
'Cranial sutures'=>'Fibrous joints between skull bones that permit molding in infancy and accommodate brain growth before progressively fusing; premature fusion causes craniosynostosis.',
'Craniotabes'=>'Soft, thin, or pliable areas of an infant’s skull that indent under gentle pressure, commonly associated with normal newborn molding but also with rickets or other bone disease.',
'Creating a family health history'=>'Collecting a record of relatives’ diseases, ages at diagnosis, ancestry, and causes of death to identify inherited risk and guide screening, prevention, and genetic counseling.',
'Creeping eruption'=>'An intensely itchy winding skin track caused by larvae, usually hookworms from contaminated soil or sand, migrating within the superficial skin; it is also called cutaneous larva migrans.',
'Crutches and children - sitting and getting up from a chair'=>'Instruction for a child using crutches to approach a chair, keep the injured limb protected as prescribed, reach for the armrests, and sit or stand safely without losing balance.',
'Crutches and children - stairs'=>'Instruction for safe stair use by a child with crutches, including handrail use, crutch placement, step sequencing, supervision, and adherence to weight-bearing restrictions.',
'Crutches and children - standing and walking'=>'Instruction for fitting and using crutches in children, including posture, handgrip support, gait pattern, weight-bearing limits, turning, and fall prevention.',
'Crying in childhood'=>'Vocal expression of distress or emotion in a child; persistent, inconsolable, unusual, or pain-associated crying may indicate illness, injury, abuse, or unmet developmental needs.',
'Crying in infancy'=>'Crying is an infant’s normal communication of hunger, discomfort, fatigue, or need for contact, but sudden inconsolable crying with lethargy, fever, vomiting, or injury needs urgent assessment.',
'CSF leak'=>'Escape of cerebrospinal fluid through a defect in the skull base or spinal dura, causing positional headache, clear nasal or ear drainage, wound leakage, meningitis risk, or intracranial hypotension.',
'CSF oligoclonal banding'=>'An electrophoretic test for restricted immunoglobulin bands in cerebrospinal fluid, interpreted with serum bands to detect intrathecal antibody production such as in multiple sclerosis.',
'CSF smear'=>'Microscopic examination of cerebrospinal fluid for cells, organisms, or abnormal material, supporting evaluation of meningitis, hemorrhage, malignancy, or inflammation.',
'Curvature of the penis'=>'A bend of the erect or flaccid penis caused by congenital tissue asymmetry, scar tissue such as Peyronie disease, trauma, or other conditions; it may impair intercourse or cause pain.',
'Cytologic evaluation'=>'Microscopic examination of individual cells or small cell groups from a fluid, brushing, scraping, or fine-needle sample to detect infection, inflammation, or malignancy.',
'Cytology exam of pleural fluid'=>'Microscopic examination of fluid around the lung for malignant cells and other cellular changes, performed with chemical and microbiologic testing when evaluating an effusion.',
'Cytology exam of urine'=>'Microscopic examination of shed urinary-tract cells, used mainly to detect high-grade urothelial malignancy and selected abnormal cells; a negative result does not exclude cancer.'
}

D = {
'D and C'=>'Dilation and curettage, a procedure that opens the cervix and removes tissue from the uterine lining for treatment or diagnosis.',
'Dextrocardia'=>'A congenital position in which the heart lies predominantly on the right side of the chest, sometimes with reversed internal organs or associated heart defects.',
'Dislocation'=>'Complete loss of normal contact between the surfaces of a joint, usually caused by trauma or structural disease and potentially accompanied by fracture, nerve, or blood-vessel injury.',
'Drooling'=>'Unintentional escape of saliva from the mouth caused by excess production, impaired swallowing, poor lip closure, or neurologic and developmental disorders.',
'Drowsiness'=>'An abnormally strong tendency to fall asleep or reduced alertness, caused by insufficient sleep, medicines, substances, metabolic illness, sleep disorders, or neurologic disease.',
'Danusertib'=>'An investigational aurora-kinase inhibitor studied as an anticancer drug; it is not an established routine treatment.',
'Dcc gene'=>'A gene encoding the netrin-1 receptor DCC, which guides developing axons and may act as a tumor suppressor; pathogenic variants can cause developmental or cancer-related phenotypes.',
'Decanoic acid'=>'A ten-carbon saturated fatty acid, also called capric acid, found in some fats and studied for antimicrobial, metabolic, and antiseizure effects.',
'Decenoic acid'=>'An unsaturated ten-carbon fatty acid; its biologic effects depend on the position and geometry of its double bond and on tissue and dietary context.',
'Degenerative disorder'=>'A disease in which progressive cellular or tissue deterioration causes loss of structure or function, as in neurodegenerative, joint, retinal, or muscle disorders.',
'Dehydroascorbic acid'=>'The oxidized form of vitamin C that can be transported into cells and reduced back to ascorbate, contributing to redox and antioxidant chemistry.',
'Dehydroepiandrosterone'=>'An adrenal steroid precursor that can be converted to androgens and estrogens; levels vary with age, adrenal disorders, medicines, and supplements.',
'Delftia acidovorans'=>'An environmental gram-negative bacterium that rarely causes bloodstream or other opportunistic infection, particularly in people with devices or impaired immunity.',
'Dent disease'=>'An inherited X-linked proximal renal-tubule disorder causing low-molecular-weight proteinuria, hypercalciuria, kidney stones or nephrocalcinosis, and progressive kidney impairment.',
'Dentinogenesis'=>'The formation of dentin by odontoblasts during tooth development and repair; inherited defects can cause abnormal tooth color, weakness, and rapid wear.',
'Depressive disorder'=>'A mood disorder with persistent depressed mood or loss of interest plus cognitive, physical, and functional symptoms; severity, duration, and suicide risk guide care.',
'Dermatologic disorder'=>'A disease affecting skin, hair, nails, or cutaneous glands, producing findings such as rash, scale, pigment change, ulcers, pain, or itching.',
'Desoximetasone'=>'A topical corticosteroid used to reduce inflammation and itching in steroid-responsive dermatitis; potency, site, duration, and skin absorption determine risk.',
'Desoxycorticosterone'=>'A mineralocorticoid steroid that promotes renal sodium retention and potassium loss, influencing extracellular fluid volume and blood pressure.',
'Deubiquitinating enzymes'=>'Enzymes that remove ubiquitin from proteins, thereby regulating protein stability, trafficking, signaling, DNA repair, and immune responses.',
'Dicarboxylic acid'=>'An organic molecule containing two carboxyl groups; dicarboxylic acids participate in metabolism and can accumulate in selected inherited or acquired metabolic disorders.',
'Dietary phospholipid'=>'A food-derived amphipathic lipid containing phosphate, used in cell membranes and lipoproteins and metabolized according to diet, absorption, and liver function.',
'Dietary protein'=>'Protein consumed in food and digested into amino acids and peptides needed for tissue maintenance, enzymes, hormones, immunity, and energy when required.',
'Digestive disorder'=>'A disease affecting the gastrointestinal tract or digestion, causing symptoms such as pain, nausea, reflux, diarrhea, constipation, bleeding, or malabsorption.',
'Diploid cell'=>'A cell containing two complete sets of chromosomes, one inherited from each parent; most human somatic cells are diploid.',
'Disease progression'=>'The change and usually worsening of a disease over time, assessed through symptoms, examination, biomarkers, imaging, function, complications, or treatment response.',
'Disease reservoir'=>'A person, animal, environmental site, or material in which an infectious agent normally lives and from which it can spread to a susceptible host.',
'Disease response'=>'The biologic or clinical reaction to a disease or its treatment, measured by symptoms, signs, laboratory results, imaging, function, or survival.',
'Disease susceptibility'=>'Increased likelihood of developing a disease because of genetic traits, immune status, age, exposures, behavior, comorbidities, or other risk factors.',
'Disease vector'=>'A living carrier, commonly a mosquito, tick, flea, or other arthropod, that transmits an infectious agent between hosts without necessarily becoming ill.',
'DNA adduct'=>'A chemical group covalently attached to DNA after exposure to a reactive compound; unrepaired adducts can distort replication and create mutations or cancer risk.',
'DNA alkylation'=>'Addition of an alkyl group to DNA bases or the phosphate backbone, which can alter base pairing, block replication, and cause mutations or cell death.',
'DNA demethylation'=>'Removal or loss of methyl groups from DNA, changing chromatin accessibility and gene expression during development, reprogramming, or disease.',
'DNA fingerprinting'=>'Analysis of variable DNA regions to distinguish individuals or establish biological relationships, used in forensic identification, paternity testing, and some research applications.',
'DNA footprinting'=>'A molecular method that identifies the DNA sequence protected by a bound protein because that region is less susceptible to enzymatic or chemical cleavage.'
}

def replace_file(file, definitions, limit)
  text = File.read(file)
  blocks = text.scan(/^\\medterm\{[^}]+\} .*?(?=^\\medterm\{|\z)/m)
  changed = 0
  blocks.each do |block|
    break if changed >= limit
    next unless block.match?(MARKER)
    title = block[/^\\medterm\{([^}]+)\}/, 1]
    next unless definitions.key?(title)
    text = text.sub(block, "\\medterm{#{title}} #{definitions[title]}\n\n")
    changed += 1
  end
  File.write(file, text)
  changed
end

if File.read('chapters/med_terms_c.tex').match?(MARKER)
  changed = replace_file('chapters/med_terms_c.tex', C, C.length)
  raise "C expected #{C.length}, got #{changed}" unless changed == C.length
  puts "chapters/med_terms_c.tex: replaced=#{changed}"
end
changed = replace_file('chapters/med_terms_d.tex', D, D.length)
raise "D expected #{D.length}, got #{changed}" unless changed == D.length
puts "chapters/med_terms_d.tex: replaced=#{changed}"
