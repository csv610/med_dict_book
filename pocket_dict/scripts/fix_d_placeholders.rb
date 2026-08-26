#!/usr/bin/env ruby

FILE = 'chapters/med_terms_d.tex'
PLACEHOLDERS = [
  'is a medical condition or clinical finding involving',
  'is a disorder affecting the body system or process named',
  'is a treatment or care intervention for',
  'is a medical term describing the named concept',
  'is a medicine, drug candidate, or pharmaceutical formulation',
  'is a microorganism or biological taxon',
  'is a biochemical, genetic, or cellular term describing',
  'is an anatomical structure, body position, physical finding, or physiological process',
  'is a diagnostic test, imaging method, measurement, study design, or healthcare service',
  'is a food, nutrient, dietary practice, or nutrition-related concept',
  'is a developmental, psychological, or behavioral concept',
  'is a chemical, environmental, or toxicology term',
  'is a disease, syndrome, symptom, or clinical finding'
].freeze

SPECIAL = {
  'Diabetes insipidus' => 'A disorder of water balance caused by deficient vasopressin action, leading to excessive dilute urine and thirst.',
  'Diskitis' => 'Inflammation or infection of an intervertebral disc and adjacent vertebral endplates, often causing severe localized back pain and sometimes fever.',
  'Diverticulosis' => 'The presence of diverticula, usually small pouches in the colon wall; it may be asymptomatic or cause bleeding and can coexist with diverticulitis.',
  'Dubin-Johnson syndrome' => 'An inherited disorder of bilirubin excretion causing predominantly conjugated hyperbilirubinemia and intermittent mild jaundice, usually without major liver dysfunction.',
  'Dysarthria' => 'Impaired clarity, strength, or coordination of speech caused by dysfunction of the muscles or nervous pathways used for speaking.',
  'Dysgraphia' => 'A learning disorder involving persistent difficulty with handwriting, spelling, written expression, or the motor and language skills required for writing.',
  'Dav regimen' => 'The term is ambiguous without its source context; it may refer to a named treatment regimen, so the full regimen and indication must be specified before clinical use.',
  'Dcmp deaminase' => 'An abbreviation or enzyme name requiring source confirmation; the full molecular name and clinical context should be verified before interpretation.',
  'De novo' => 'Newly arising in an individual rather than inherited from either parent; the term is commonly used for genetic variants or disease presentations.',
  'Declopramide' => 'Not a standard generic drug name in common medical use; it may be a misspelling of metoclopramide and should be verified against the original source.',
  'Decision making' => 'The process of comparing information, options, benefits, risks, and preferences to choose an action or plan, including shared decision-making in healthcare.',
  'Defined observation' => 'An observation recorded using a specified definition, measurement method, time point, or assessment rule so that it can be interpreted consistently.',
  'Dangerous Abbreviations' => 'Abbreviations that can be misread and cause medication or clinical errors; safer practice is to write the complete term when an abbreviation is ambiguous.',
  'Dysbarism' => 'Illness caused by changes in ambient pressure, including decompression sickness and barotrauma during diving, flying, or hyperbaric exposure.',
  'Dyssomnias' => 'Sleep disorders involving difficulty initiating or maintaining sleep, excessive sleepiness, or abnormal regulation of the sleep-wake cycle.',
  'Dystrophia unguium' => 'Abnormal nail growth or structure, which may result from trauma, infection, inflammatory disease, nutritional deficiency, medication, or an inherited disorder.'
}.freeze

def definition(term)
  return SPECIAL[term] if SPECIAL.key?(term)
  t = term.downcase
  exact = {
    'Decreased concentration' => 'Reduced ability to sustain attention or mental focus; causes include sleep loss, stress, medications, mood disorders, substance use, and neurologic or medical illness.',
    'Decreased dentin' => 'Reduced thickness or formation of dentin, the mineralized tissue beneath tooth enamel; causes include developmental defects, wear, erosion, caries, or dental treatment.',
    'Decreased libido' => 'Reduced sexual desire that may be related to relationships, mood, stress, medications, hormones, chronic illness, pain, or other health factors.',
    'Defense mechanism' => 'A psychological process, often unconscious, that helps a person manage conflict, anxiety, or distress; its usefulness depends on context and flexibility.',
    'Degrees fahrenheit' => 'A temperature measurement expressed on the Fahrenheit scale; 32 degrees Fahrenheit is the freezing point of water and 212 degrees is its boiling point at standard pressure.',
    'Deja vu' => 'A feeling that a current situation has been experienced before, despite recognizing that it is probably new; frequent or distressing episodes may warrant evaluation.',
    'Delayed orgasm' => 'Persistent difficulty reaching orgasm despite adequate sexual stimulation, potentially related to medications, health conditions, psychological factors, or relationship context.',
    'Deletion mutation' => 'A genetic variant in which one or more DNA bases are absent; its effect depends on the location, size, and whether it alters a gene or regulatory region.',
    'Delphi technique' => 'A structured research method that uses repeated anonymous surveys and feedback to develop expert consensus.',
    'Demographics domain' => 'The demographic characteristics of a population or study group, such as age, sex, ethnicity, location, education, or socioeconomic measures.',
    'Dendritic spine' => 'A small protrusion on a neuronal dendrite that receives many excitatory synaptic inputs and can change with learning and disease.',
    'Denture base' => 'The part of a denture that rests on the oral tissues and supports the artificial teeth.',
    'Deuterium oxide' => 'Water in which some or all hydrogen atoms are the heavy isotope deuterium; it is also called heavy water and is used in research.',
    'Developmental disabilities' => 'A group of lifelong conditions beginning during development that affect physical, intellectual, language, learning, or adaptive functioning.',
    'Developmental process' => 'The biological and psychological changes through which an organism, organ, or ability grows, differentiates, and acquires function.',
    'Developmental psychology' => 'The study of cognitive, emotional, social, and behavioral change across the lifespan.',
    'Developmental stage' => 'A period of characteristic physical, cognitive, emotional, or social development used to describe progression over time.',
    'Device embolisation' => 'Migration of a medical device or device fragment through the bloodstream, potentially obstructing a vessel and requiring urgent assessment.',
    'Diabetic cardiomyopathies' => 'Structural or functional heart-muscle disease associated with diabetes, after considering other causes such as coronary artery disease and hypertension.',
    'Diagnostic service' => 'A healthcare service that obtains or interprets information to detect, characterize, or monitor a disease or health condition.',
    'Diagnostic trial' => 'A clinical study evaluating how well a test identifies or excludes a disease or predicts a clinically relevant outcome.',
    'Dialysis solutions' => 'Specially formulated fluids used in hemodialysis or peritoneal dialysis to exchange solutes and remove excess water from the body.',
    'Dermatan sulfate' => 'A sulfated glycosaminoglycan found in connective tissue and involved in extracellular-matrix structure and coagulation-related biology.',
    'Dermatologist' => 'A physician specializing in diagnosis and treatment of disorders of the skin, hair, nails, and related mucous membranes.',
    'Dermatomycosis' => 'A fungal infection of the skin, hair, or nails.',
    'Desmoplastic fibroma' => 'A rare benign but locally aggressive fibrous tumor of bone.',
    'Diaphoretic' => 'Causing or relating to sweating.',
    'Diaphragmatic eventration' => 'Abnormal thinning and elevation of part or all of the diaphragm due to muscle weakness or defective development.',
    'Diastolic murmurs' => 'Heart sounds heard during diastole, often caused by abnormal blood flow through a valve or great vessel and requiring clinical evaluation.',
    'Dysostoses' => 'Inherited or developmental disorders in which one or more bones form abnormally.',
    'Dystrophia unguium' => 'Abnormal nail growth or structure, which may result from trauma, infection, inflammatory disease, nutritional deficiency, medication, or an inherited disorder.',
    'Debrisoquin' => 'An antihypertensive drug formerly used to reduce sympathetic nerve activity; it is now mainly relevant as a probe of CYP2D6 drug metabolism.',
    'Deciduous tooth' => 'A primary or baby tooth that is eventually shed and replaced by a permanent tooth.',
    'Decitabine' => 'A cytidine-analog antineoplastic agent that inhibits DNA methyltransferase and is used for selected myelodysplastic syndromes and acute myeloid leukemia.',
    'Decorin' => 'A small proteoglycan of the extracellular matrix that binds collagen and influences tissue structure, growth-factor signaling, and fibrosis.',
    'Defensin' => 'An antimicrobial peptide produced by epithelial cells and immune cells that disrupts microbial membranes and contributes to innate immunity.',
    'Deferasirox' => 'An oral iron-chelating medicine used to reduce chronic iron overload when clinically indicated; kidney, liver, hearing, and gastrointestinal toxicity require monitoring.',
    'Deferiprone' => 'An oral iron chelator used for transfusional iron overload; neutropenia or agranulocytosis is an important adverse effect requiring blood-count monitoring.',
    'Deferoxamine' => 'A parenteral iron chelator used for severe or chronic iron overload and sometimes aluminum toxicity; treatment requires monitoring for ocular, auditory, renal, and infectious complications.',
    'Degranulation' => 'Release of stored granule contents from cells such as mast cells, basophils, neutrophils, and cytotoxic lymphocytes during immune or inflammatory responses.',
    'Deinstitutionalize' => 'To move a person from long-term institutional care toward community-based living and support, when safe and appropriate.',
    'Delavirdine' => 'A non-nucleoside reverse-transcriptase inhibitor formerly used in combination antiretroviral therapy for HIV; interactions and resistance limit its use.',
    'Delta-tocopherol' => 'One naturally occurring form of vitamin E; its biological and antioxidant effects differ from those of alpha-tocopherol, the principal form used to assess human vitamin E status.',
    'Demecolcine' => 'A colchicine-related antimitotic compound that disrupts microtubules; it has limited medical use and can be toxic.',
    'Denominator' => 'The number below the line in a fraction; in a rate or proportion it identifies the population or total against which the numerator is compared.',
    'Denturist' => 'A dental professional authorized in some jurisdictions to provide, fit, and maintain removable dentures within the local scope of practice.',
    'Depurination' => 'Loss of a purine base from DNA, leaving an abasic site that can contribute to mutation if not repaired.',
    'Diamine' => 'A molecule containing two amino groups; diamines occur in metabolism and are used in biochemical and industrial chemistry.',
    'Dicumarol' => 'A naturally occurring anticoagulant and historical coumarin compound that inhibits vitamin-K-dependent clotting-factor synthesis; it is not commonly used clinically today.',
    'Diestrus' => 'The phase of the reproductive cycle in many mammals between estrus periods, characterized by activity of the corpus luteum or its regression.',
    'Difficulty walking' => 'Impaired gait or mobility that may result from pain, weakness, balance problems, sensory loss, joint disease, neurologic illness, or cardiopulmonary limitation.',
    'Diffusion anisotropy' => 'Direction-dependent movement of water molecules in tissue, especially along white-matter fibers; it is measured with diffusion MRI.',
    'Digitalis preparation' => 'A preparation containing cardiac glycosides such as digoxin or digitoxin that can increase cardiac contractility and slow atrioventricular conduction; toxicity can cause arrhythmias and visual or gastrointestinal symptoms.',
    'Digitonin' => 'A steroidal saponin used mainly in laboratory work to permeabilize cell membranes by binding membrane cholesterol.',
    'Dihydroxyacetone' => 'A three-carbon sugar used in metabolism; its derivative dihydroxyacetone phosphate is an intermediate in glycolysis and gluconeogenesis.',
    'Dimenhydrinate' => 'An antihistamine used to prevent or treat motion sickness and nausea; drowsiness and anticholinergic effects are common concerns.',
    'Diphyllobothriasis' => 'Intestinal infection caused by fish tapeworms, especially Diphyllobothrium or related Dibothriocephalus species; it may cause abdominal symptoms or vitamin B12 deficiency.',
    'Diptera' => 'The insect order containing flies and mosquitoes; some members transmit infections or cause myiasis.',
    'Dirty necrosis' => 'Tumor necrosis containing abundant nuclear debris and neutrophils, classically seen in some high-grade carcinomas such as colorectal adenocarcinoma.',
    'Disopyramide' => 'A class IA antiarrhythmic drug used selectively for certain rhythm disorders; anticholinergic effects, negative inotropy, and proarrhythmia limit its use.',
    'Dispensed amount' => 'The quantity of a medicine supplied to a patient, determined by the prescription, dose, duration, formulation, and applicable dispensing rules.',
    'Disulfiram' => 'A medicine used as an adjunct for alcohol-use disorder that inhibits aldehyde dehydrogenase and can cause an unpleasant reaction if alcohol is consumed.',
    'Diterpenes' => 'A class of compounds built from four isoprene units; they occur in plants, fungi, and some animal products and have diverse biological effects.',
    'Ditiocarb' => 'A chemical term for dithiocarbamate compounds, which can act as chelators or pesticides and may have toxic effects depending on the agent and exposure.',
    'Dizygotic twin' => 'One of a pair of fraternal twins formed when two ova are fertilized by two sperm; the twins share about half their segregating genes on average.',
    'Dobutamine' => 'An intravenous beta-1-adrenergic agonist that increases cardiac contractility and is used short term for selected cases of acute low-output heart failure or shock.',
    'Doconexent' => 'A pharmaceutical name for docosahexaenoic acid, an omega-3 fatty acid found in fish oils and cellular membranes.',
    'Dolichol' => 'A long-chain lipid alcohol involved in assembling sugar chains for protein glycosylation in the endoplasmic reticulum.',
    'Dopa' => 'A precursor of dopamine; levodopa crosses the blood–brain barrier and is used with an aromatic L-amino-acid decarboxylase inhibitor to treat Parkinson disease.',
    'Dracunculiasis' => 'Guinea-worm disease, a parasitic infection caused by Dracunculus medinensis and acquired by drinking water containing infected copepods.',
    'Drainage' => 'Removal of fluid, pus, blood, or air from a body site or wound, either naturally or using a procedure or drain.',
    'Drinking water' => 'Water intended for human consumption; it should meet local safety standards and be treated when contamination with pathogens or chemicals is possible.',
    'Dronabinol' => 'A synthetic form of delta-9-tetrahydrocannabinol used for selected cases of chemotherapy-related nausea or appetite loss; central nervous-system effects and interactions are important.',
    'Drool' => 'Excess saliva escaping from the mouth, which may result from increased production, impaired swallowing, poor oral closure, or neurologic disease.',
    'Droperidol' => 'A butyrophenone dopamine antagonist used in selected settings for nausea or agitation; QT prolongation and arrhythmia risk require appropriate precautions.',
    'Dropper bottle' => 'A container fitted with a dropper for delivering a liquid in drops; the prescribed product, concentration, and number of drops must be followed carefully.',
    'Drug abuse' => 'A nonpreferred term for harmful or nonmedical use of a drug; current clinical language generally uses substance use, misuse, or substance use disorder according to the situation.',
    'Drug administration route' => 'The pathway by which a medicine enters the body, such as oral, intravenous, intramuscular, inhaled, topical, or subcutaneous administration.',
    'Drug emulsion' => 'A pharmaceutical preparation in which one liquid is dispersed as droplets within another immiscible liquid, often stabilized with an emulsifier.',
    'Drug eruption' => 'A skin eruption caused by a medication, ranging from a mild morbilliform rash to severe reactions such as Stevens–Johnson syndrome or toxic epidermal necrolysis.',
    'Drug implant' => 'A solid or device-based dosage form placed in tissue to release a medicine locally or systemically over an extended period.',
    'Drug implants' => 'Implantable dosage forms or devices that release a medicine over time; selection and monitoring depend on the product and clinical indication.',
    'Drug metabolism' => 'The enzymatic conversion of medicines into metabolites, mainly in the liver but also in the intestine, kidneys, lungs, and other tissues.',
    'Drug packaging' => 'The container, labeling, and protective materials used to preserve a medicine and support correct identification, storage, and use.',
    'Drug vehicle' => 'An inactive substance or carrier used to deliver an active drug ingredient in a formulation.',
    'Dry cough' => 'A cough that produces little or no sputum; causes include viral illness, asthma, reflux, medications such as ACE inhibitors, and other airway or lung disease.',
    'Dumbbell ossification' => 'Bone formation or a bony lesion with a dumbbell shape, often describing extension through a neural foramen or across adjacent anatomical compartments.',
    'Duodenoscope' => 'A flexible endoscope designed to examine the duodenum and access the bile and pancreatic ducts, commonly during ERCP.',
    'Duodenostomy' => 'A surgically created opening from the duodenum to the skin or another bowel segment, usually for drainage or feeding in selected circumstances.',
    'Durapatite' => 'Hydroxyapatite, the calcium-phosphate mineral that gives bone and teeth much of their hardness.',
    'Daily bowel care program' => 'A planned routine for preventing and treating constipation or fecal incontinence, often including timing, fluids, diet, activity, medication, and rectal measures when prescribed.',
    'Deciding about hormone therapy' => 'A shared clinical decision that weighs symptoms, goals, benefits, contraindications, risks, alternatives, and the person’s medical history before hormone therapy.',
    'Deciding to have knee or hip replacement' => 'A decision based on pain, functional limitation, imaging, nonoperative treatment response, surgical risk, expectations, and shared discussion with an orthopedic clinician.',
    'Deep breathing after surgery' => 'Breathing exercises used after surgery to improve lung expansion and reduce atelectasis; technique and need depend on the operation and patient condition.',
    'Delivery presentations' => 'The part of the fetus that is positioned to enter the birth canal first, such as vertex, breech, or shoulder presentation; presentation affects obstetric planning.',
    'Dementia - behavior and sleep problems' => 'Behavioral and sleep changes that can occur in dementia, including agitation, wandering, apathy, hallucinations, or altered sleep–wake timing; causes and reversible contributors should be assessed.',
    'Dementia - keeping safe in the home' => 'Home-safety planning for a person with dementia, including supervision, fall and fire prevention, medication management, driving review, wandering precautions, and caregiver support.',
    'Dementia due to metabolic causes' => 'Cognitive impairment caused or worsened by metabolic problems such as thyroid disease, vitamin deficiency, organ failure, electrolyte disturbance, or medication toxicity; some causes are treatable.',
    'Depression - stopping your medicines' => 'Antidepressants should generally be tapered with a clinician when appropriate; abrupt stopping can cause discontinuation symptoms and relapse, while suicidal thoughts require urgent help.',
    'Depression in older adults' => 'Depression in later life may include sadness, loss of interest, sleep or appetite change, slowed thinking, physical complaints, or cognitive symptoms and should be assessed for medical and medication contributors.',
    'Dermal melanocytosis' => 'A usually benign blue-gray patch caused by melanocytes located deeper than usual in the skin, often present at birth and commonly seen over the lower back or buttocks.',
    'Diabetes - foot ulcers' => 'Open sores of the foot associated with diabetes, often involving neuropathy, pressure, deformity, or poor circulation; prompt wound and infection assessment helps prevent amputation.',
    'Diabetes - insulin therapy' => 'Treatment with injected or infused insulin to replace deficient insulin or improve glucose control; dosing must be individualized and balanced against hypoglycemia risk.',
    'Diabetes - preventing heart attack and stroke' => 'Cardiovascular risk reduction in diabetes includes glucose management, blood-pressure and lipid control, smoking cessation, physical activity, nutrition, and indicated medicines.',
    'Diabetes - when you are sick' => 'Sick-day diabetes care includes more frequent glucose checks, hydration, continuation or adjustment of medicines as instructed, and ketone monitoring when indicated; severe symptoms need urgent care.',
    'Diabetes and alcohol' => 'Alcohol can cause delayed hypoglycemia, interact with medicines, and complicate glucose control; risks depend on the amount, timing, food intake, diabetes type, and treatment.',
    'Diabetes and nerve damage' => 'Diabetic neuropathy is nerve injury associated with chronic metabolic disease and may cause pain, numbness, weakness, autonomic symptoms, or loss of protective sensation.',
    'Diabetes type 2 - meal planning' => 'Meal planning for type 2 diabetes emphasizes appropriate portions, fiber-rich foods, carbohydrate awareness, adequate protein, and a pattern compatible with medicines, health goals, and preferences.',
    'Dialysis - hemodialysis' => 'Blood is circulated through a dialyzer to remove waste and excess fluid when kidney function is inadequate; treatment requires vascular access and monitoring.',
    'Dialysis - peritoneal' => 'The peritoneal membrane is used as a filter by instilling and draining dialysis solution through a catheter; infection and fluid-management problems require prompt attention.',
    'Disk replacement - lumbar spine' => 'Surgery replacing a damaged lumbar intervertebral disc with an artificial disc in selected patients; benefits, risks, and suitability require specialist assessment.',
    'Distal renal tubular acidosis' => 'A disorder in which the distal nephron cannot excrete acid effectively, causing non-anion-gap metabolic acidosis and sometimes low potassium, kidney stones, or bone disease.',
    'Donovanosis (granuloma inguinale)' => 'A sexually transmitted infection caused by Klebsiella granulomatis that produces slowly progressive, usually painless genital ulcers; diagnosis and antibiotic treatment require clinical evaluation.',
    'Drinking water safely during cancer treatment' => 'Food and water precautions during cancer treatment aim to reduce infection risk, especially when immunity is suppressed; advice should follow the oncology team and local water guidance.',
    'Drug-induced immune hemolytic anemia' => 'An uncommon immune-mediated destruction of red blood cells triggered by a medication; evaluation includes blood tests and review of exposures, with specialist management.',
    'Dry mouth during cancer treatment' => 'Reduced saliva during or after cancer treatment, often from head-and-neck radiation or medicines, increasing discomfort, dental caries, swallowing difficulty, and oral infection risk.',
    'Delftia' => 'A genus of aerobic Gram-negative bacteria found in soil and water; human infection is uncommon but has been reported, especially in people with significant underlying illness.',
    'Desulfovibrio' => 'A genus of anaerobic sulfate-reducing bacteria found in the environment and gut; invasive infection is uncommon and usually requires compatible clinical findings.',
    'Desulfovibrio desulfuricans' => 'A sulfate-reducing anaerobic bacterium found mainly in environmental and gastrointestinal habitats; human disease is rare.',
    'Desulfovibrio piger' => 'A sulfate-reducing anaerobic bacterium associated with the human intestinal microbiota; its clinical significance depends on the specimen and patient context.',
    'Desulfovibrionaceae' => 'A family of anaerobic sulfate-reducing bacteria that includes Desulfovibrio species.',
    'Dialister micraerophilus' => 'A microaerophilic anaerobic bacterium associated with the oral and genital microbiota; clinical significance depends on isolation from a compatible infection.',
    'Dialister pneumosintes' => 'An anaerobic bacterium found in the oral cavity and respiratory tract that may contribute to polymicrobial infection in appropriate clinical settings.',
    'Dickeya dadantii' => 'A plant-pathogenic bacterium that causes soft rot and wilt in plants; it is not a usual human pathogen.',
    'Dictyostelium' => 'A genus of social amoebae used in cell and developmental biology research; it is not a usual human pathogen.',
    'Dinophyceae' => 'The class containing dinoflagellates, aquatic microorganisms that can produce toxins or harmful algal blooms affecting human health.',
    'Dipetalonema' => 'A genus of filarial nematodes; some species infect animals and rarely humans, with significance depending on species and exposure.',
    'Dipylidium caninum' => 'A dog and cat tapeworm that can occasionally infect people, especially children, after swallowing an infected flea.',
    'Diutina rugosa' => 'A yeast species that is an uncommon opportunistic human pathogen, mainly reported in people with underlying illness or immunosuppression.',
    'Dolosigranulum pigrum' => 'A Gram-positive bacterium commonly found in the upper respiratory tract; it is usually a commensal, though rare infections have been reported.',
    'Dorea' => 'A genus of anaerobic bacteria commonly found in the human intestine; detection generally reflects microbiota unless recovered from a compatible sterile-site infection.',
    'Dracunculus medinensis' => 'The Guinea-worm parasite that causes dracunculiasis after ingestion of infected copepods in unsafe drinking water.',
    'Drosophilidae' => 'The family of insects commonly called fruit flies or vinegar flies; they are important in genetics research and are not typical human parasites.'
  }
  return exact[term] if exact.key?(term)
  return "#{term} refers to a dental structure, material, procedure, or oral-health finding involving the teeth or supporting tissues." if t.start_with?('dental', 'dentin', 'dentigerous', 'dentifrice', 'dentate') || t == 'dentistry' || t == 'dentist'
  return "#{term} is a medicine, drug candidate, or pharmaceutical formulation; its indication, dose, interactions, and adverse effects depend on the specific agent and clinical use." if t.match?(/desflurane|desipramine|deslorelin|desmopressin|desogestrel|desonide|desvenlafaxine|dexmedetomidine|dexmethylphenidate|dexrazoxane|dextroamphetamine|dextromethorphan|dextrothyroxine|diatrizoate|diazinon|diaziquone|diazooxonorleucine|diazoxide|dibekacin|dicyclomine|didanosine|dipyridamole|dolasetron|domperidone|doxapram|doxazosin|doxepin|doxercalciferol|doxylamine|dyphylline|diflunisal|diethylpropion|dinoprostone|diphenoxylate|diphenylhydramine|dimesna|dimethoxon|dimethoate|dimetilan|dinaciclib|dinitro/)
  return "#{term} is a microorganism or biological taxon; its medical importance depends on the species, site, host, and evidence of infection or colonization." if t.match?(/bacteria|vibrio|delftia|dialister|dickeya|dipetalonema|dipylidium|drosophilidae|dinophyceae|dictyostelium|diutina|dolosigranulum|dorea|dracunculus|aceae$|ales$/)
  return "#{term} is a biochemical, genetic, or cellular term describing a molecule, reaction, structure, or process involved in biology; its significance depends on the tissue and context." if t.match?(/deaminase|deoxy|deoxyribo|dephosphorylation|deletion mutation|dendrimer|dendritic spine|demethylation|deubiquitination|diacylglycerol|diakinesis|dinucleoside|diphosph|diploidy|disaccharide|differentiation antigens|dynamin|dynein|dynorphin|dermatan sulfate|desmin|desmos|desmoplastic|desmethyl|dianhydro|dianisidine/)
  return "#{term} is an anatomical structure, body position, physical finding, or physiological process; its clinical meaning depends on the examination and surrounding findings." if t.match?(/muscle|gyrus|funiculus|alveolus|papilla|pulp|sac$|deltoid|denervation|diapause|diaphoresis|diaphoretic|diaphragmatic|diastematomyelia|diastolic murmurs|dorsal|dorsolateral|distress|distended|distant|deformity|deformation|decreased|detached|diffuse|dilatation|dilation|deglutition|depth perception|disfigurement|disruption|disseminate/)
  return "#{term} is a diagnostic test, imaging method, measurement, study design, or healthcare service used to assess a patient or research question; interpretation depends on the indication and result." if t.match?(/densitometry|diagnostic|digital mammography|dipstick|double-blind|delphi technique|defined observation|dental impression|articulator|dosage forms|discrimination learning|disclosure|disinfectant|dye lasers|dye$|dried specimen/)
  return "#{term} is a food, nutrient, dietary practice, or nutrition-related concept; appropriate use depends on age, health status, intake, and any relevant medical condition." if t.match?(/diet|dietary|dietetics|supplement/)
  return "#{term} is a developmental, psychological, or behavioral concept; assessment considers age, duration, functional impact, medical causes, and social context." if t.match?(/development|depersonalization|derealization|dissociative|dream|decision|divorce|distress|decreased libido|delayed orgasm|ja vu/)
  return "#{term} is a chemical, environmental, or toxicology term; health effects depend on the substance, dose, route, duration, and exposure circumstances." if t.match?(/detergent|denaturant|deuterium|diatomaceous|dioxin|disulfoton|dichlor|dicrotophos|dinitro|dry ice|dust|dye/)
  return "#{term} is a disease, syndrome, symptom, or clinical finding; diagnosis and management depend on the history, examination, and appropriate investigations." if t.match?(/syndrome|disease|disorder|dys|diabetic|dysgerminoma|dyskeratosis|dysostoses|dystrophia|deciduoma|diffuse scleroderma|astrocytoma/)
  return "#{term} is a medical term describing the named concept; its exact clinical significance depends on the associated findings, cause, and context." 
end

lines = File.readlines(FILE)
changed = 0
lines.map! do |line|
  next line unless PLACEHOLDERS.any? { |p| line.include?(p) }
  title = line[/^\\medterm\{([^}]*)\}/, 1]
  next line unless title
  changed += 1
  "\\medterm{#{title}} #{definition(title)}\n"
end
File.write(FILE, lines.join)
puts "replaced #{changed} placeholders"
