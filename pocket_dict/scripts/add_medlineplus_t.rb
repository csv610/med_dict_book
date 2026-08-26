#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Takayasu arteritis' => 'Takayasu arteritis is large-vessel granulomatous vasculitis affecting the aorta and major branches, causing pulse or blood-pressure differences, limb claudication, vascular bruits, and organ ischemia.',
  'Tardive dyskinesia' => 'Tardive dyskinesia is persistent involuntary movement caused by chronic exposure to dopamine-receptor-blocking medicines, often affecting the mouth, tongue, face, trunk, or limbs.',
  'Tay-Sachs disease' => 'Tay-Sachs disease is an inherited lysosomal storage disorder caused by hexosaminidase A deficiency, leading to progressive neurodegeneration and a characteristic retinal finding.',
  'Tetanus' => 'Tetanus is toxin-mediated neurologic disease caused by Clostridium tetani entering a wound, producing painful muscle rigidity, spasms, autonomic instability, and respiratory failure.',
  'Tetralogy of Fallot' => 'Tetralogy of Fallot is a congenital heart defect combining ventricular septal defect, right-ventricular outflow obstruction, overriding aorta, and right-ventricular hypertrophy.',
  'Thalassemia' => 'Thalassemia is an inherited disorder of globin-chain production causing microcytic anemia of variable severity, ineffective erythropoiesis, hemolysis, and possible iron overload.',
  'Thrombocytopenia' => 'Thrombocytopenia is a low platelet count caused by reduced production, increased destruction or consumption, sequestration, or dilution and may increase bleeding risk.',
  'Thrombotic thrombocytopenic purpura' => 'Thrombotic thrombocytopenic purpura is a medical emergency caused by severe ADAMTS13 deficiency, producing platelet-rich microthrombi, thrombocytopenia, hemolytic anemia, neurologic or kidney injury, and fever.',
  'Thyroid storm' => 'Thyroid storm is life-threatening decompensated thyrotoxicosis with fever, tachycardia, agitation or delirium, gastrointestinal symptoms, heart failure, or shock.',
  'Tinnitus' => 'Tinnitus is perception of sound without an external source, often related to hearing loss, noise exposure, ear disease, medications, vascular causes, or neurologic factors.',
  'Tonsillitis' => 'Tonsillitis is inflammation or infection of the tonsils causing sore throat, painful swallowing, fever, swollen tonsils, and sometimes abscess or airway complications.',
  'Toxic shock syndrome' => 'Toxic shock syndrome is acute toxin-mediated systemic illness, usually from Staphylococcus aureus or Streptococcus pyogenes, causing fever, rash, hypotension, multiorgan injury, and shock.',
  'Toxoplasmosis' => 'Toxoplasmosis is infection with Toxoplasma gondii, usually mild in healthy people but potentially causing congenital disease or severe brain, eye, or systemic disease in immunocompromised people.',
  'Transient ischemic attack' => 'A transient ischemic attack is a brief episode of focal neurologic dysfunction caused by temporary cerebral, spinal, or retinal ischemia without established infarction and signals elevated stroke risk.',
  'Tuberculosis' => 'Tuberculosis is infection with Mycobacterium tuberculosis, usually affecting lungs but potentially disseminating to lymph nodes, meninges, bones, kidneys, or other organs.',
  'Turner syndrome' => 'Turner syndrome is a chromosomal condition in which all or part of one X chromosome is absent or altered, causing short stature, ovarian insufficiency, characteristic features, and variable heart or kidney disease.',
  'Type 1 diabetes' => 'Type 1 diabetes is autoimmune destruction of pancreatic beta cells causing absolute insulin deficiency, hyperglycemia, and risk of diabetic ketoacidosis without insulin replacement.',
  'Type 2 diabetes' => 'Type 2 diabetes is chronic hyperglycemia caused by insulin resistance and progressive beta-cell dysfunction, with risks to the eyes, kidneys, nerves, heart, and blood vessels.',
  'Typhoid fever' => 'Typhoid fever is systemic infection with Salmonella Typhi, spread fecal-orally and causing sustained fever, abdominal symptoms, bacteremia, and possible intestinal perforation.',
  'Typhus' => 'Typhus refers to several rickettsial infections transmitted by lice, fleas, or mites and characterized by fever, headache, rash, and variable systemic complications.',
  'Trigeminal neuralgia' => 'Trigeminal neuralgia causes brief recurrent electric-shock-like pain in one or more trigeminal nerve divisions, often triggered by light touch, chewing, or speaking.',
  'Trichomoniasis' => 'Trichomoniasis is a sexually transmitted infection caused by Trichomonas vaginalis, often producing genital irritation, discharge, dysuria, or no symptoms.',
  'Tricuspid regurgitation' => 'Tricuspid regurgitation is backward flow through the tricuspid valve during ventricular contraction, caused by valve disease or annular dilation and potentially leading to right-heart failure.',
  'Thyroid cancer' => 'Thyroid cancer is malignant growth of thyroid tissue, with papillary, follicular, medullary, and anaplastic types differing in biology, spread, and treatment.',
  'Thyroid function tests' => 'Thyroid function tests measure hormones or related markers such as TSH and free thyroid hormones to evaluate thyroid underactivity, overactivity, treatment response, or pituitary disease.',
  'Thoracic aortic aneurysm' => 'A thoracic aortic aneurysm is abnormal enlargement of the aorta in the chest, with risks of dissection or rupture influenced by size, growth, location, and cause.',
  'Toxic megacolon' => 'Toxic megacolon is acute severe dilation of the colon with systemic toxicity, usually from fulminant colitis, and can progress to perforation, sepsis, and shock.',
  'Tourette syndrome' => 'Tourette syndrome is a neurodevelopmental disorder with multiple motor tics and at least one vocal tic, beginning in childhood and varying in severity over time.',
  'Traumatic brain injury' => 'Traumatic brain injury results from external force causing temporary or permanent brain dysfunction, ranging from concussion to hemorrhage, swelling, coma, or lasting cognitive and neurologic impairment.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|talcum|tar|toluene|turpentine|tetrahydrozoline|thiazide|thioridazine|trisodium|toilet cleaner|tobacco|tick bite|snake|spider/
    "#{name} involves toxic or environmental exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|ct|x-ray|ultrasound|culture|analysis|count|sampling|angiograph|biopsy|plethysmograph|function|pet|assay|gram stain|electro|tbg|tsh|tsi|titer|tonometry|tympanometry|troponin|trypsin|transillumination|doppler/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|resection|removal|replacement|transplant|repair|insertion|therapy|radiation|ablation|laparosc|catheter|discharge|aftercare|self-care|feeding|vaccin|endoscopy|fusion|arthroscopy|tracheostomy|transcatheter|transurethral|tubal ligation|tonsil|tooth extraction|tendon repair/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|management|prevention|support|exercise|healthy|home|living|learn|habits|safety|screening|education|services|information|palliative|pain|care|stress|returning|responsible drinking|rights|masks|work|sports|safe|shared decision|facilities|nutrition|taking|talking|tips|coaching|preparation/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephritis|fibrosis|cystitis|obstruction|ulcer|incontinence|leukemia|lymph|liver|lung|lupus|endometriosis|fibroid|parkinson|pancreat|periton|pneum|polio|poly|pleur|placenta|pituitary|phary|pilo|pityriasis|pallor|paraphimosis|paronychia|phobia|pica|pregnancy|rheumatoid|retinal|renal|respiratory|ricket|ringworm|rosacea|rotator|rabies|sepsis|shock|sickle|sinus|sleep|scoliosis|scler|schizo|scabies|sarcoid|salmonella|staph|strep|stomach|shoulder|spinal|spondyl|splen|sprain|stroke|systemic|tetanus|thyroid|throm|tinnitus|tonsil|toxic|trache|transverse|trauma|tremor|trem|torticollis|tooth|tropical|tularemia|tuber|twin|turner|type 1 diabetes|type 2 diabetes/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|lymph|iron|lead|pelvis|penis|pericard|peripheral|platelet|plasma|phosphor|pituitary|placenta|radial|retina|rib|salivary|sclera|scrotum|skeleton|spine|spleen|sputum|skin|small bowel|testes|tibia|tongue|tooth|trachea|tendon|tarsal|thoracic|thymus|throat/
    "#{name} concerns #{lower}, a body structure, substance, or clinical concept whose meaning depends on location, function, and patient context."
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
    file.puts '\\synonyms'
  end
end
puts "added #{additions.length} terms"
