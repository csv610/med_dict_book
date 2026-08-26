#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  "Ulcerative Colitis Diet" => "An ulcerative-colitis eating plan is individualized around symptoms, disease activity, nutrition, and treatment. During flares, hydration and tolerated lower-residue foods may help, but no universal diet cures inflammation or replaces medical therapy.",
  "Understanding Pica Eating Disorder" => "Pica is persistent eating of nonfood substances for at least a month in a way that is developmentally or culturally inappropriate. It may be associated with iron deficiency, pregnancy, intellectual disability, autism, or mental illness and can cause poisoning, obstruction, or infection.",
  "Undetectable Viral Load Without Treatment" => "An undetectable viral load means a test found virus below its reporting threshold, but the meaning depends on the infection and treatment status. In HIV, sustained suppression is usually treatment-related; stopping therapy can allow rebound, so medicines should not be stopped without care.",
  "Units of Insulin Needed for 400 Blood Sugar" => "A blood glucose of 400 mg/dL can indicate severe hyperglycemia or diabetic ketoacidosis and should not be self-treated with an improvised insulin dose. The required correction depends on the person's prescribed plan, insulin sensitivity, ketones, hydration, and diabetes type; urgent medical advice is needed.",
  "Upper Left Side Abdominal Pain Causes in Children" => "Upper-left abdominal pain in a child may come from the stomach, bowel, spleen, pancreas, kidney, ribs, muscles, or referred chest disease. Severe pain, injury, fever, repeated vomiting, breathing difficulty, faintness, or a rigid abdomen requires prompt evaluation.",
  "Urinary Incontinence in Children" => "Urinary incontinence in children may reflect normal development, constipation, urinary infection, bladder dysfunction, diabetes, sleep disorders, spinal disease, or psychosocial factors. New daytime wetting, pain, fever, excessive thirst, weakness, or recurrent accidents needs assessment.",
  "Urinary Tract Infections in Children" => "Urinary-tract infection in children can cause fever, painful urination, frequency, abdominal or back pain, vomiting, or nonspecific irritability. Prompt diagnosis and treatment help prevent kidney injury, especially in infants or children with recurrent or atypical infections.",
  "Usually the First Symptom of Testicular Cancer" => "A painless testicular lump or enlargement is a common first sign of testicular cancer, although heaviness, ache, or sudden pain may occur. Any persistent testicular change needs prompt examination and ultrasound; sudden severe pain is an emergency because torsion is possible.",
  "Uterine Growths" => "Uterine growths may include fibroids, polyps, adenomyosis, or rarely cancer. They can cause heavy or irregular bleeding, pelvic pressure, pain, infertility, or no symptoms; examination and imaging determine the type and treatment.",
  "Vaginal Birth After Cesarean Delivery Concerns" => "Vaginal birth after cesarean may be appropriate for selected patients, but uterine-scar rupture and emergency cesarean risks must be weighed against avoiding repeat surgery. Prior incision, number of cesareans, facility resources, pregnancy factors, and patient preference guide planning.",
  "Vaginal Dryness and Vaginal Atrophy" => "Vaginal atrophy is thinning and reduced lubrication from lower estrogen, commonly around menopause but also after childbirth, breastfeeding, cancer treatment, or some medicines. Moisturizers, lubricants, pelvic care, and selected local or systemic treatments may relieve symptoms.",
  "Vaginitis Overview" => "Vaginitis causes vaginal irritation, itching, burning, odor, discharge, or pain and may result from yeast, bacterial vaginosis, sexually transmitted infection, irritants, hormones, or skin disease. Testing is often needed because symptoms overlap and treatments differ.",
  "Vascular Disease" => "Vascular disease affects arteries, veins, or lymphatic vessels and includes atherosclerosis, aneurysm, peripheral artery disease, venous thrombosis, varicose disease, and inflammatory disorders. Symptoms and treatment depend on the vessel and may involve risk-factor control, medicines, procedures, or surgery.",
  "Vertigo Overview" => "Vertigo is the false sensation of movement, often caused by inner-ear disorders such as benign positional vertigo, vestibular neuritis, or Ménière disease, but sometimes by migraine or brain disease. New neurologic deficits, severe headache, or inability to walk is urgent.",
  "Vitamins & Exercise" => "Vitamins support defined physiologic functions, but exercise does not generally require high-dose supplementation when diet is adequate. Deficiency, malabsorption, pregnancy, age, and medical disease may justify targeted supplements; excess can be harmful.",
  "Vitamins and Calcium Supplements" => "Vitamin and calcium supplements are useful when dietary intake or laboratory findings show a need, such as deficiency or bone-health risk. Dose, absorption, kidney function, stone risk, and interactions with medicines should be reviewed rather than assumed safe.",
  "Vitamins in the Morning or in the Night" => "The best time for a vitamin depends on the nutrient, formulation, food requirements, side effects, and interactions. Fat-soluble vitamins are often absorbed with food, while some medicines and minerals need separation; consistency and appropriate dosing matter more than a universal time.",
  "VOR Reflex" => "The vestibulo-ocular reflex stabilizes gaze by moving the eyes opposite to head movement through inner-ear, brainstem, and eye-muscle pathways. Damage can cause oscillopsia, vertigo, imbalance, and abnormal head-impulse testing.",
  "Weber-Christian Disease" => "Weber-Christian disease is an older, nonspecific term historically used for relapsing fever and inflammation of subcutaneous fat, now often classified as panniculitis. Painful subcutaneous nodules and systemic symptoms require modern evaluation for infection, autoimmune disease, pancreatic disease, or other causes.",
  "Wisdom Teeth" => "Wisdom teeth are the third molars that commonly emerge in late adolescence or adulthood. Impaction, infection, decay, cysts, gum disease, or crowding can cause pain and swelling; dental examination and imaging determine whether monitoring or removal is appropriate.",
  "Yeast Infection in Women and Men" => "Genital yeast infection is usually caused by Candida and can cause itching, soreness, redness, and thick discharge in women or irritation and rash on the penis in men. Recurrent, severe, atypical, or treatment-resistant symptoms need confirmation and evaluation for contributing conditions.",
  "Yeast Infections: How Do You Know When It Heals" => "A yeast infection is generally improving when itching, soreness, redness, and abnormal discharge resolve and do not return after treatment. Persistent symptoms may reflect resistant yeast, another infection, dermatitis, or an incorrect diagnosis and warrant examination rather than repeated empiric treatment.",
  "Zika Virus" => "Zika virus is a mosquito-borne flavivirus that can also spread through sex and from a pregnant person to the fetus. Infection is often mild or asymptomatic but can cause congenital Zika syndrome and rarely neurologic complications such as Guillain-Barré syndrome."
}.freeze

def excluded_title?(term)
  return true if term == 'Vitamins and Supplements Avoid During Pregnancy'

  term =~ /^(Can |Do |Does |Are |Is |What |Why |How |Best |Fastest |First |Early |Easiest |Eat |Eating |Exercises |Foods |Figure |Father|Dealing|Difference|Differences|Disadvantages|Dandruff vs|Drink |Drinking |Duration|Good |Get |Get Rid|Having |Healthy Living|Health and|Tips|Ways|Should |Before|After|Common|Cochlear|Four |Exposure|Directives|Advantages|Coping|Dream|Weigh|Weight|Life Expectancy|Life With|Lose |Losing |Long-Term|Low FODMAP|Low-Glycemic|Left Brain|Labor Duration|Labor Pain|Gastroparesis Diet|Loss, Grief|Grief|Glycemic|Gambling|Healthy|Main |Make |Meaning |Most |Mirena |Mens Health|Menopause and Sex|Metabolic Syndrome Diet|MyPlate|Natural |Nature |Neuroendocrine Tumor the Same|Neurological Disorders Cause|Nightshade|Nonsurgical|Normal |Oldest |Overcoming|Ovulation Calculator|Palmitic|Parenting|Parkinson.s Disease: Eating|Part of the Body|Pathological Liar|Physically Fit|Poison Control|Prebiotics|Pregnancy Symptoms|Pregnancy: Your Guide|Protect Your Teeth|PMS vs|Pimple vs|Pancoast Tumor Lung Cancer|Pancreatic Cancer Be|Pancreatic Neuroendocrine Tumors Metastasize|Most Effective|Non-Itchy|Non-Small Cell.*vs|Oxycodone vs|Over-the-Counter|Osteoblast vs|Osteoarthritis vs|Patellofemoral Syndrome|Pneumonia Facts|Pain From|PMS|Pediatric|Pelvic Inflammatory Disease Without|Pelvic Pain|Pimple vs|Pathological|Parenting|Pregnancy:|Pregnancy Diet|Preparing for Pregnancy|Panic|Quackery|Quick |Radical |Recommended |Recovery |Role |Safe |Seizure vs|Set Point|Sever |Side Effects|Shoulder and Neck Pain|Sleep Aids|Smoker.s Lung|Smoking |Sore Throat Home|Stop |Stress Management|Success Rate|Survival Rate|Symptoms |The |Take |Talk |Target |Teen|Tell |Test HIV|Three |Top |Treat |Treatment |True |Types |Typical |Most Serious|Most Severe|Best Treatment|Fastest|Thyroid Storm vs|Thyroid-Problems|Turf Toe|Tylenol Liver Damage|Treatment Options|Treatment Get|Treatment How|treatment |Type 1 vs|Teenagers|Safe Cold|Stomach Cancer Survival|Spotting vs|Sun Protection|Sunburn|Stool Color|Spleen Problems|Spondylitis vs|Stages of Puberty|STDs|Stem Cells|Steroid Withdrawal|Stroke vs|Pneumonia|Palmitic|Parenting|Part of|PMS|Pimple vs|Personal|Potential|Prevent|Protect|Relationship|Review|Resources|Risk|Should|Why|When|Who|Ways|What|Where|Which)/i || term =~ /\bvs\.?\b/i
end

def latex_escape(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

%w[T U V W X Y Z].each do |letter|
  output = "chapters/med_terms_#{letter.downcase}.tex"
  text = File.read(output)
  existing = text.scan(/^\\medterm\{([^}]*)\}/).flatten.to_h { |title| [normalize(title), true] }
  source_terms = if letter == 'Z'
                   ['Zika Virus']
                 else
                   File.readlines("/tmp/medicinenet_#{letter}_terms.txt", chomp: true)
                 end
  terms = source_terms.reject { |term| excluded_title?(term) }
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
      file.puts "\\medterm{#{latex_escape(term)}} #{definition}"
      file.puts
      file.puts '\\synonyms'
    end
  end
  puts "#{letter}: added #{additions.length} terms"
end
