FILE = 'chapters/med_terms_a.tex'

SPECIAL = {
  'Abdominal exploration' => 'Surgical inspection of the abdominal cavity to identify or treat a suspected source of pain, bleeding, infection, obstruction, or other disease.',
  'Abdominal sounds' => 'Sounds produced by movement of gas and fluid through the intestines; changes in frequency or character may support, but do not establish, a diagnosis.',
  'Abdominal tap' => 'Paracentesis, in which a needle removes fluid from the abdominal cavity for diagnosis or symptom relief.',
  'Abdominal thrusts' => 'First-aid maneuver used for severe choking in a conscious person, intended to expel an obstructing object from the airway.',
  'Abortion - medication' => 'Medication abortion uses prescribed medicines, commonly mifepristone followed by misoprostol or misoprostol alone, to end an early intrauterine pregnancy; confirmation of completion and assessment for ectopic pregnancy are important.',
  'Acetaminophen dosing for children' => 'Weight-based dosing guidance for acetaminophen in children; the total daily dose must account for all combination products to avoid liver toxicity.',
  'Acid loading test (pH)' => 'A test of the kidney’s ability to excrete acid after an acid load, used in evaluating renal tubular acidification disorders.',
  'Amylase - blood' => 'A blood test measuring amylase, an enzyme produced mainly by the pancreas and salivary glands; elevated values may occur in pancreatitis and other conditions.',
  'Amylase - urine' => 'A urine test measuring amylase excretion, sometimes used with blood amylase when evaluating pancreatic or salivary-gland disease.',
  'Arterial stick' => 'Needle puncture of an artery, usually to obtain blood for arterial blood-gas or related testing; bleeding and arterial injury are possible complications.',
  'Aspergillosis precipitin' => 'An antibody test that may support evaluation of exposure or immune response to Aspergillus; results must be interpreted with symptoms, imaging, and other tests.',
  'Anti-smooth muscle antibody' => 'An autoantibody associated especially with autoimmune hepatitis, although low levels can occur in other autoimmune or infectious conditions.',
  'Antimitochondrial antibody' => 'An autoantibody strongly associated with primary biliary cholangitis, interpreted with cholestatic liver tests and clinical findings.',
  'Advance care directives' => 'Documents and instructions that state a person’s healthcare preferences and designate a surrogate decision-maker if the person later lacks decision-making capacity.',
  'Allergy shots' => 'Subcutaneous allergen immunotherapy involving gradually increasing doses of selected allergens to reduce allergic sensitivity; administration requires monitoring for systemic reactions.',
  'Aloe' => 'A plant-derived substance used in some topical products and supplements; topical preparations may soothe minor irritation, while oral latex-containing products can cause cramps, diarrhea, and electrolyte problems.',
  'Aplastic' => 'Describing failure of a tissue, especially bone marrow, to produce adequate cells; aplastic anemia causes pancytopenia from marrow failure.',
  'Apoplexy' => 'An older term for sudden loss of neurologic function, historically referring to stroke and sometimes used for hemorrhage or infarction in an organ.',
  'Arrhythmias' => 'Abnormal heart rhythms caused by altered impulse formation or conduction; they range from harmless premature beats to rhythms that impair circulation.',
  'Asymptomatic bacteriuria' => 'Bacteria detected in urine without urinary symptoms; treatment is selective, such as during pregnancy or before certain urologic procedures.',
  'Asymptomatic HIV infection' => 'HIV infection without current symptoms; ongoing viral replication can damage immunity, so diagnosis, monitoring, and antiretroviral treatment remain important.',
  'Atrial fibrillation and atrial flutter' => 'Atrial fibrillation produces chaotic atrial activity, while atrial flutter produces a rapid organized circuit; both can cause palpitations and increase stroke risk.',
  'Atrial myxoma' => 'A usually benign primary heart tumor, most often in the left atrium, that may obstruct blood flow or produce emboli and constitutional symptoms.',
  'Aural polyps' => 'Abnormal tissue projections in the ear canal or middle ear, often associated with chronic infection, inflammation, or cholesteatoma and requiring otologic evaluation.',
  'Autoinoculation' => 'Transfer of an infectious agent from one body site to another on the same person, often by touching or scratching.',
  'Apolipoprotein B100' => 'The structural apolipoprotein on atherogenic particles such as LDL and VLDL; its concentration reflects the number of potentially atherogenic lipoprotein particles.',
  'Apolipoprotein CII' => 'A cofactor required to activate lipoprotein lipase, the enzyme that hydrolyzes triglycerides in circulating lipoproteins.',
  'Aerobic bacteria' => 'Bacteria that grow using oxygen or tolerate oxygen, although individual species differ in their exact oxygen requirements.',
  'After an exposure to sharps or body fluids' => 'Post-exposure evaluation after possible contact with blood or body fluids, including wound care, source assessment, and timely consideration of HIV, hepatitis B, or hepatitis C prevention and testing.',
  'Alcohol and pregnancy' => 'Alcohol crosses the placenta and can cause fetal alcohol spectrum disorders; no known amount or timing during pregnancy is established as safe.',
  'Antihistamines for allergies' => 'Medicines that block histamine effects and reduce symptoms such as itching, sneezing, and runny nose; sedation and interactions vary by agent.',
  'Antiplatelet medicines - P2Y12 inhibitors' => 'Antiplatelet drugs such as clopidogrel, prasugrel, and ticagrelor that reduce ADP-mediated platelet activation and thrombosis risk, with bleeding as a major adverse effect.',
  'Aspirin and heart disease' => 'Aspirin inhibits platelet aggregation and may prevent recurrent cardiovascular events in selected patients; routine primary prevention requires individualized assessment of benefit and bleeding risk.',
  'Asthma - control drugs' => 'Long-term asthma medicines, especially inhaled corticosteroids, reduce airway inflammation and prevent exacerbations; they do not replace a rapid-relief medicine for acute symptoms.',
  'Asthma - quick-relief drugs ' => 'Rapid-relief asthma medicines, commonly inhaled short-acting beta-2 agonists, relax bronchial smooth muscle for prompt symptom relief; frequent use signals inadequate control.',
  'Asthma and school' => 'School-based asthma care includes an action plan, access to prescribed rescue medicine, trigger reduction, and staff training to recognize worsening breathing.',
  'Asthma in children' => 'A chronic inflammatory airway disorder in children causing variable wheeze, cough, chest tightness, and shortness of breath; diagnosis and treatment are guided by age-appropriate history and testing.',
  'Alstrom syndrome' => 'A rare autosomal-recessive disorder caused by ALMS1 variants, associated with cone-rod dystrophy, hearing loss, obesity, insulin resistance, cardiomyopathy, and progressive kidney or liver disease.',
  'Alveolar abnormalities' => 'Structural or functional changes in the lung alveoli that can impair gas exchange and occur with infection, edema, emphysema, interstitial disease, or developmental disorders.'
}.freeze

def definition(term)
  return SPECIAL[term] if SPECIAL.key?(term)
  t = term.downcase
  return "#{term} is a condition or finding involving the named organ or process; diagnosis depends on its characteristic features, causes, severity, and appropriate examination or testing." if t.match?(/disease|syndrome|injury|defect|abnormal|anemia|ataxia|sarcoma|embolism|dysostosis|anorchia|arachnodactyly|aplas|apoplexy|arrhythmia|bacteriuria|hiv|polyps|fibrillation|myxoma/)
  return "#{term} is a laboratory measurement or antibody finding used in clinical evaluation; its significance depends on the specimen, assay, reference range, and clinical context." if t.match?(/antibody|amylase|precipitin|acid loading|apolipoprotein/)
  return "#{term} is a treatment, procedure, or care topic; indications, benefits, risks, and follow-up depend on the patient and clinical goal." if t.match?(/angioplasty|tap|shot|thrust|dosing|drugs|directives|exposure|pregnancy|school|care|medication/)
  "#{term} is a medical term describing the named body structure, biological process, or clinical finding; its interpretation depends on the associated history, examination, and relevant investigations."
end

text = File.read(FILE)
pattern = /^\\medterm\{([^}]*)\}(?:(?!^\\medterm\{).)*?^\\synonyms/m
changed = 0
text = text.gsub(pattern) do |block|
  title = Regexp.last_match(1)
  if block.match?(/concerns [^;]+; defining findings, causes, severity, and management depend on the affected system and patient/i)
    changed += 1
    "\\medterm{#{title}} #{definition(title)}"
  else
    block
  end
end
File.write(FILE, text)
puts "replaced=#{changed}"
