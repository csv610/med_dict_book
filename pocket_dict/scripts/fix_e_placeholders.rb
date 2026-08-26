#!/usr/bin/env ruby

FILE = 'chapters/med_terms_e.tex'
MARKERS = [
  'is a medical condition or clinical finding involving',
  'is a disorder affecting the body system or process named',
  'is a treatment or care intervention for',
  'addresses care for'
].freeze

SPECIAL = {
  'Echinococcosis' => 'A parasitic infection caused by Echinococcus tapeworms, producing cystic or infiltrative disease in organs such as the liver and lungs.',
  'Endometritis' => 'Inflammation or infection of the uterine lining, often associated with childbirth, miscarriage, abortion, or uterine instrumentation.',
  'Endophthalmitis' => 'A severe inflammation, usually infectious, inside the eye that can rapidly threaten vision and requires urgent ophthalmic treatment.',
  'Endoscope' => 'A flexible or rigid instrument with a light and camera used to inspect an internal body passage or cavity and sometimes perform procedures.',
  'Endoscopy' => 'Examination of an internal body passage or cavity with an endoscope; tissue sampling and treatment may be performed during the procedure.',
  'Enteritis' => 'Inflammation of the small intestine caused by infection, inflammatory disease, radiation, reduced blood flow, or other injury.',
  'Eosinophilic fasciitis' => 'A rare inflammatory disorder causing painful swelling and progressive thickening of fascia and skin, often with increased blood eosinophils.',
  'Epididymitis' => 'Inflammation of the epididymis, commonly caused by infection and presenting with gradual unilateral scrotal pain and swelling.',
  'Episcleritis' => 'Usually self-limited inflammation of the thin tissue overlying the white of the eye, causing localized redness and mild discomfort.',
  'Eat' => 'To consume food; nutritional needs and safe intake depend on age, health conditions, swallowing ability, and dietary requirements.',
  'Eccrine poroma' => 'A usually benign tumor arising from the eccrine sweat-gland duct, commonly presenting as a flesh-colored or reddish nodule on the hands or feet.',
  'Elective abortion' => 'A planned termination of pregnancy, performed with medication or a procedure according to gestational age, patient preference, and local clinical requirements.',
  'Emergency care' => 'Immediate assessment and treatment for a potentially serious or time-sensitive illness or injury.',
  'Effectiveness' => 'The degree to which an intervention produces its intended outcome in routine practice, as distinct from efficacy under ideal study conditions.',
  'Epidemiologic studies' => 'Research that examines the distribution, causes, risk factors, prevention, or outcomes of health events in populations.',
  'Epidemiologic method' => 'A method for measuring disease occurrence or investigating associations between exposures and health outcomes in populations.',
  'Environmental illness' => 'Illness caused or worsened by environmental exposures; evaluation requires attention to timing, dose, setting, and alternative explanations.',
  'Excessive bruising' => 'Bruising that is unusually frequent, large, spontaneous, or prolonged and may reflect trauma, medications, low platelets, clotting disorders, or another illness.',
  'Excision biopsy' => 'Removal of an entire lesion or abnormal area for microscopic examination, when complete removal is appropriate and feasible.',
  'Expectorant' => 'A medicine intended to help loosen or mobilize respiratory mucus so it can be coughed up; benefit varies by cause and product.',
  'Exposure' => 'Contact with a physical, chemical, biological, or psychological agent at a particular intensity and duration; risk depends on the agent and circumstances.',
  'Eucalyptus oil' => 'An essential oil containing compounds such as eucalyptol; ingestion can be toxic, and concentrated oil should not be used internally without appropriate medical guidance.',
  'Ethics' => 'Principles used to evaluate what is right, fair, respectful, and responsible in healthcare, research, and professional practice.',
  'Equipment safety' => 'Practices that reduce injury, infection, malfunction, and misuse of medical equipment through selection, inspection, cleaning, maintenance, and training.',
  'Exercise tolerance' => 'The ability to perform physical activity before symptoms such as breathlessness, fatigue, chest discomfort, or pain limit activity.',
  'Exacerbation' => 'A worsening or flare of a disease or its symptoms, sometimes triggered by infection, exposure, treatment interruption, or another stressor.',
  'Examination table' => 'A table designed to support a patient during a physical examination or clinical procedure.',
  'Extraction' => 'Removal of a substance, tissue, tooth, foreign body, or other structure from the body, usually by a defined procedure.',
  'Ewingella americana' => 'A rare Gram-negative environmental bacterium that can occasionally cause opportunistic infection, mainly in people with underlying illness.',
  'Dysplasia' => 'Abnormal development or organization of cells, tissues, or organs; in pathology it may indicate a precancerous change depending on the site and grade.'
}.freeze

def definition(term)
  return SPECIAL[term] if SPECIAL.key?(term)
  t = term.downcase
  return "#{term} is a medicine or pharmaceutical agent; its indication, dose, interactions, contraindications, and adverse effects depend on the specific product and patient." if t.match?(/desflurane|desipramine|deslorelin|desvenlafaxine|dexmedetomidine|dexmethylphenidate|dexrazoxane|dextro|echothiophate|edodekin|edotecarin|efaproxiral|elesclomol|elinafide|eltrombopag|emitefur|emtricitabine|enflurane|eniluracil|enclomiphene|ephedrine|epoprostenol|escitalopram|estazolam|estriol|estrone|eszopiclone|etanercept|ethambutol|ethionamide|ethosuximide|ethoxzolamide|ethynodiol|etilefrine|etodolac|etomidate|etoposide|etoricoxib|etretinate|everolimus|exatecan|exemestane|ergotamine|eribulin|erlotinib|epothilone|epoxide hydrolase/)
  return "#{term} is a microorganism or biological taxon; its clinical importance depends on the species, specimen, host, and evidence of infection or colonization." if t.match?(/echinococcus|endolimax|endolimax nana|enterobius|enterococcaceae|enterocytozoon|enteromonas|euglena|eukaryote|eurotium|ewingella|exophiala|exserohilum|erysipelothrix|aceae$|ales$/)
  return "#{term} is an anatomical, embryological, cellular, or physiological term; its clinical meaning depends on the structure, function, and surrounding findings." if t.match?(/embry|efferent|eccrine|efferent|endocervical|endocrine|endolymph|endometrial|endothelium|entorhinal|epiblast|epigastric|epithalamic|epithelial|exocrine|extraocular|extrinsic|elastic|erythroblast|erythroid|epidermal|endosome|enterocyte|end point/)
  return "#{term} is a chemical, toxicology, laboratory, or environmental term; significance depends on the substance, concentration, route, duration, and exposure circumstances." if t.match?(/ethane|ethanol|ethanolamine|ether|epichlorohydrin|ethylene|ethidium|ethion|eosine|europium|elixir|emulsion|ester|esterase|esterification|element|ecology|environment|exposure|eucalyptus|essiac|diatomaceous/)
  return "#{term} is a diagnostic, research, imaging, or measurement term used to assess a condition or question; interpretation depends on the indication, method, and result." if t.match?(/count|diagnostic|epidemiologic|equivalence trial|effectiveness|electric impedance|echolocation|endoscopy|endoscope|esthesiometer|examination|trial|method|studies|mammography|synapse|function/)
  return "#{term} is a nutrition or dietary term; appropriate use depends on age, health status, allergies, intake, and medical treatment." if t.match?(/eat|energy intake|diet|dietary|supplement|nutrition|fats|iron|phosphorus/)
  return "#{term} is a disease, symptom, syndrome, or clinical finding; diagnosis and management depend on history, examination, and appropriate investigations." if t.match?(/disease|disorder|dys|endomet|enteritis|eosinophilic|epididym|episcler|esophag|erythro|exacerbation|excessive|erosion|exposure|fasciitis|goiter|necrosis|ulcer|tumor|cyst|deformity/)
  return "#{term} is a clinical procedure, treatment, device, or care topic; its indications, benefits, risks, and follow-up depend on the patient and clinical goal." if t.match?(/care|repair|replacement|insertion|block|embolization|therapy|treatment|surgery|exercise|safety|delivery|pregnancy|pregnant|aftercare|discharge|removal|excision|extraction|circulation|implant|insertion|screening/)
  "#{term} is a medical term whose precise meaning depends on the clinical context, associated findings, and source definition."
end

lines = File.readlines(FILE)
changed = 0
lines.map! do |line|
  next line unless MARKERS.any? { |marker| line.include?(marker) }
  title = line[/^\\medterm\{([^}]*)\}/, 1]
  next line unless title
  changed += 1
  "\\medterm{#{title}} #{definition(title)}\n"
end
File.write(FILE, lines.join)
puts "replaced #{changed} placeholders"
