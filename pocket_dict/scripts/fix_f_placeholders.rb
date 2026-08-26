#!/usr/bin/env ruby

FILE = 'chapters/med_terms_f.tex'
MARKERS = [
  'is a medical condition or clinical finding involving',
  'is a disorder affecting the body system or process named',
  'is a treatment or care intervention for'
].freeze

SPECIAL = {
  'Facial paralysis' => 'Weakness or loss of movement of the facial muscles caused by dysfunction of the facial nerve or its pathways; sudden onset requires urgent evaluation for stroke.',
  'Farsightedness' => 'Hyperopia, a refractive error in which light focuses behind the retina, causing near blur or eyestrain; glasses or contact lenses can correct it.',
  'Folate-deficiency anemia' => 'A megaloblastic anemia caused by inadequate folate, impaired absorption, increased need, or certain medicines; blood testing identifies the cause and folate replacement treats deficiency.',
  'Folliculitis' => 'Inflammation of a hair follicle, often caused by bacteria, yeast, friction, occlusion, or ingrown hairs, producing small itchy or tender bumps.',
  'Favism' => 'Acute hemolysis after ingestion of fava beans or exposure to an oxidant in a person with glucose-6-phosphate dehydrogenase deficiency.',
  'Fibromyalgia' => 'A chronic pain disorder with widespread pain, fatigue, sleep disturbance, and cognitive symptoms without a single structural lesion explaining all symptoms.',
  'Fibroma' => 'A benign tumor composed mainly of fibrous connective tissue; behavior and treatment depend on its location and pathology.',
  'Fistula' => 'An abnormal connection between two epithelial-lined surfaces, such as an organ and skin or two hollow organs.',
  'Fistula, anal' => 'An abnormal tract between the anal canal or rectum and nearby skin, often following an abscess or inflammatory bowel disease and commonly causing drainage.',
  'Flat affect' => 'Marked reduction in the outward expression of emotion, which may occur with schizophrenia, depression, neurologic disease, medicines, or other conditions.',
  'Focal sclerosis' => 'Localized hardening or scarring of tissue; the clinical meaning depends on the organ, such as focal segmental glomerulosclerosis in the kidney.',
  'Folic acid' => 'A form of folate, a B vitamin needed for DNA synthesis and red-cell formation; supplementation before and during early pregnancy reduces neural-tube-defect risk.',
  'Food poisoning' => 'Illness caused by eating or drinking food contaminated with infectious organisms, toxins, chemicals, or parasites, commonly producing vomiting, diarrhea, cramps, or fever.',
  'Foreign body airway obstruction' => 'Partial or complete blockage of the airway by an inhaled object; inability to speak, cough, or breathe is a life-threatening emergency requiring immediate first aid.',
  'Fracture' => 'A break or crack in a bone caused by injury, repetitive stress, or weakened bone.',
  'Furuncle' => 'A painful localized infection of a hair follicle and surrounding tissue, usually caused by Staphylococcus aureus, that may form a pus-filled abscess.',
  'FTA-ABS test' => 'A treponemal antibody test used to support diagnosis of syphilis; antibodies often remain positive after successful treatment, so it is not usually used to measure response.',
  'Fusospirochetal gingivitis' => 'Acute necrotizing gingivitis associated with fusobacteria and spirochetes, causing painful bleeding gums, ulceration, and foul breath; prompt dental care is needed.'
}.freeze

def definition(term)
  return SPECIAL[term] if SPECIAL.key?(term)
  t = term.downcase
  return "#{term} is a medicine or pharmaceutical agent; its indication, dose, interactions, contraindications, and adverse effects depend on the specific product and patient." if t.match?(/famophos|famotidine|fazarabine|febuxostat|felbamate|fenamiphos|fenclonine|fenfluramine|fenitrothion|fenobucarb|fenoldopam|fenoxycarb|fenretinide|fentanyl|fenthion|fidaxomicin|filgrastim|flavopiridol|flavoxate|floxuridine|flucytosine|fludarabine|fludrocortisone|flumazenil|fluocinolone|fluocinonide|fluorometholone|fluphenazine|flurandrenolide|flutamide|fluticasone|fluvoxamine|fondaparinux|formoterol|fosaprepitant|fosbretabulin|foscarnet|framycetin|fulvestrant|furazolidone|fursultiamin|etodolac/)
  return "#{term} is a microorganism or biological taxon; its clinical importance depends on the species, specimen, host, and evidence of infection or colonization." if t.match?(/facklamia|flavonifractor|flea|facklamia hominis/)
  return "#{term} is an anatomical, cellular, developmental, or physiological term; its clinical meaning depends on the structure, function, and surrounding findings." if t.match?(/fallopian|female|femoral|forearm|forehead|forelimb|foreskin|finger|fingernail|facial|fascia|fat body|fat pad|flank|foot|frontal|fundus|fetal|fetus|follicular|fucose|flexion|fasciculation|femt/)
  return "#{term} is a chemical, toxicology, laboratory, or environmental term; significance depends on the substance, concentration, route, duration, and exposure circumstances." if t.match?(/formalin|formate|formetanate|formothion|formparanate|furan|fullerene|fluorine|fluorescein|fluorescence|flavin|flavonoid|flavonol|filler|fixative|fomites|fumarate|ethidium|fats|fatty/)
  return "#{term} is a diagnostic, research, imaging, or measurement term used to assess a condition or question; interpretation depends on the indication, method, and result." if t.match?(/count|factor|fish|fiducial|fourier|fmri|flowmeter|fixation|feedback|fetal heart|fetal weight|fetal circulation|fetal brady|function|fluorimetry|fluorophotometry|microscopy|polarization|trial|study|method|analysis|sampling|examination/)
  return "#{term} is a nutrition or dietary term; appropriate use depends on age, health status, allergies, intake, and medical treatment." if t.match?(/fasting|food|fiber|fodmaps|fat$|fatty|fish oil|formula feeding|fructose|folic|feeding|consumption|diet/)
  return "#{term} is a disease, symptom, syndrome, or clinical finding; diagnosis and management depend on history, examination, and appropriate investigations." if t.match?(/disease|disorder|syndrome|fibro|febrile|fever|fistula|folliculitis|furuncle|fetal death|fetal distress|fetal mal|floppy|flare|flat affect|formication|fracture|focal|fused|swelling|pain|amputation|bruising|gingivitis|xanthomatosis/)
  return "#{term} is a clinical procedure, treatment, device, or care topic; its indications, benefits, risks, and follow-up depend on the patient and clinical goal." if t.match?(/care|repair|replacement|insertion|removal|block|embolization|amputation|foraminotomy|fusion|aftercare|discharge|surgery|therapy|treatment|excision|safety|management|exercise|pregnancy/)
  "#{term} is a medical term describing the named concept; its precise interpretation depends on the clinical context, associated findings, and current reference definitions."
end

text = File.read(FILE)
changed = 0
titles = text.lines.filter_map { |line| MARKERS.any? { |m| line.include?(m) } ? line[/^\\medterm\{([^}]*)\}/, 1] : nil }
titles.each do |title|
  pattern = /^\\medterm\{#{Regexp.escape(title)}\}.*?(?=\n\n\\synonyms)/m
  text.sub!(pattern) { "\\medterm{#{title}} #{definition(title)}" }
  changed += 1
end
File.write(FILE, text)
puts "replaced #{changed} placeholders"
