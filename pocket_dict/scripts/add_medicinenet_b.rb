#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  "Bedbugs Bed Bugs vs Lice" => "Bedbugs and head lice are different parasites. Bedbugs live in the environment and bite exposed skin, while head lice live on the scalp and spread mainly through close contact; inspection of the insect, eggs, and usual body site distinguishes them.",
  "Bee and Wasp Sting" => "Bee and wasp stings inject venom and usually cause immediate localized pain, redness, swelling, and itching. Widespread hives, throat or tongue swelling, breathing difficulty, dizziness, or vomiting may indicate anaphylaxis and require emergency treatment.",
  "Behcet's Syndrome" => "Behcet syndrome is a relapsing inflammatory disorder that can cause recurrent mouth and genital ulcers, eye inflammation, skin lesions, and vascular, neurologic, or gastrointestinal disease. Treatment is tailored to the organs involved and may include immunosuppression.",
  "Being Good Partner to Someone With Chronic Illness" => "Supporting a partner with chronic illness involves listening, respecting autonomy, sharing practical tasks by agreement, and recognizing fluctuating symptoms and treatment demands. Clear communication, respite, boundaries, and professional or peer support help protect both partners' well-being.",
  "Benefits and Risks of Taking Amino Acid Supplement" => "Amino-acid supplements may be useful for a documented deficiency or a specific clinical indication, but most people obtain adequate amino acids from protein-containing foods. Excessive or unnecessary use can cause gastrointestinal symptoms, metabolic effects, interactions, or kidney and liver concerns.",
  "Benefits of Taking Magnesium Glycinate?" => "Magnesium glycinate is a magnesium salt often marketed for deficiency, muscle symptoms, or sleep. Evidence for specific benefits varies; supplements can cause diarrhea or excess magnesium, and kidney disease increases toxicity risk, so dose and indication should be reviewed.",
  "Bernard-Soulier Disease" => "Bernard-Soulier disease is a rare inherited platelet disorder caused by defects in the platelet glycoprotein Ib-IX-V complex. Platelets are unusually large and do not adhere normally, producing mucocutaneous bleeding, easy bruising, and prolonged bleeding after procedures.",
  "Best Foods To Eat When You Have Gallstones" => "For gallstones, meals lower in saturated fat and moderate in portion size may reduce symptoms in people whose pain follows fatty foods. No food dissolves most gallstones; recurrent right-upper-abdominal pain, fever, jaundice, or vomiting needs medical assessment.",
  "Best Fruits for Lowering Blood Pressure" => "Fruits such as citrus, berries, bananas, and other potassium- and fiber-containing choices can support a blood-pressure-friendly eating pattern. They complement, but do not replace, prescribed treatment, sodium reduction, physical activity, and monitoring.",
  "Best Home Remedies for Upper Respiratory Infection" => "Most uncomplicated upper-respiratory infections improve with rest, fluids, humidified air, saline nasal care, and appropriate symptom relief. Antibiotics do not treat viral infections; breathing difficulty, dehydration, persistent high fever, or worsening symptoms needs evaluation.",
  "Best Home Remedies for Vaginal Itching" => "Vaginal itching may result from yeast, bacterial vaginosis, sexually transmitted infection, irritant dermatitis, hormonal change, or skin disease. Avoiding scented products and keeping the area dry may help, but recurrent, painful, malodorous, or discharge-associated symptoms need diagnosis before treatment.",
  "Best Medicinal Mushroom Health Benefits" => "Medicinal mushrooms are marketed for immune, metabolic, or cancer-related benefits, but evidence and product standardization differ substantially by species and preparation. They should not replace proven treatment and may cause allergy, toxicity, or medicine interactions.",
  "Best Medicine and Treatment for Bronchitis" => "Acute bronchitis is usually viral and improves with fluids, rest, and symptom-directed care; antibiotics rarely help unless another bacterial diagnosis is present. Persistent breathlessness, high fever, bloody sputum, chest pain, or symptoms in a high-risk person warrants evaluation.",
  "Best Natural Treatments For Gastritis" => "Gastritis treatment depends on the cause, including Helicobacter pylori, anti-inflammatory medicines, alcohol, bile reflux, or autoimmune disease. Avoiding irritants may reduce symptoms, but persistent pain, bleeding, vomiting, anemia, or weight loss requires medical diagnosis and targeted therapy.",
  "Best Temperature for Roasting Vegetables" => "Roasting vegetables commonly uses a moderately high oven temperature, with time adjusted for the vegetable, size, moisture, and desired texture. Safe food handling and avoiding charring are more important than a single universal temperature.",
  "Best Thing to Eat for Breakfast to Lose Weight" => "A weight-supportive breakfast can combine protein, fiber, fruit or vegetables, and a portion that fits daily energy needs. No single food causes weight loss; sustainable intake, activity, sleep, medications, and medical conditions determine long-term change.",
  "Best Time to Measure Your Blood Pressure" => "Blood pressure is best compared when measured under consistent conditions, after several minutes of rest and before exercise, caffeine, smoking, or medications when instructed. Repeated readings at similar times provide more useful information than one isolated measurement.",
  "Best Treatment for Degenerative Disc Disease" => "Degenerative disc disease describes age- or wear-related changes in spinal discs and does not always cause pain. Treatment usually begins with activity modification, exercise-based rehabilitation, and pain management; selected patients may need injections or surgery after specialist assessment.",
  "Best Treatment for Hidradenitis Suppurativa" => "Hidradenitis suppurativa causes recurrent painful nodules, abscesses, and tunnels in skin folds. Management may include weight and smoking support, antiseptic care, antibiotics, hormonal or biologic medicines, injections, and surgery according to severity.",
  "Best Treatment for Yellow Jacket Stings" => "A yellow-jacket sting should be washed, and a cold pack can reduce local pain and swelling. Remove any visible bee stinger without squeezing, use symptom relief as appropriate, and seek emergency care for hives away from the site, breathing trouble, throat swelling, faintness, or vomiting.",
  "Best Treatment Options for Acne Rosacea" => "Rosacea treatment reduces flushing, persistent redness, bumps, and eye symptoms through trigger avoidance, gentle skin care, sunscreen, and selected topical or oral medicines. The regimen depends on subtype, severity, ocular involvement, and response.",
  "Best Treatments for Allergic Conjunctivitis" => "Allergic conjunctivitis causes itchy, watery, red eyes after exposure to an allergen. Limiting exposure, cool compresses, lubricating drops, and antihistamine or mast-cell-stabilizing eye medicines can help; severe pain, vision loss, or marked light sensitivity suggests another urgent eye problem.",
  "Best Way to Treat Razor Bumps from Shaving" => "Razor bumps are inflammatory ingrown hairs caused by shaving or hair removal. Pausing close shaving, using a clean sharp tool, shaving with hair growth, avoiding skin stretching, and selected topical treatment can reduce recurrence; widespread infection or scarring needs care.",
  "beyond food what triggers heartburn and GERD" => "Heartburn and gastroesophageal reflux can be triggered by lying down after meals, obesity, pregnancy, smoking, alcohol, certain medicines, large meals, and individual foods. Persistent symptoms, difficulty swallowing, bleeding, weight loss, or chest pain require medical evaluation.",
  "Bilirubin and Bilirubin Blood Test" => "Bilirubin is a yellow pigment produced when red blood cells are broken down. A blood test measures total and sometimes direct and indirect bilirubin to help evaluate liver disease, bile-duct obstruction, hemolysis, and newborn jaundice.",
  "Biorhythms" => "Biorhythms refers to recurring biological patterns such as circadian sleep-wake cycles, hormonal rhythms, and seasonal changes. Evidence does not support using popular fixed-cycle predictions to diagnose illness or reliably forecast mood, performance, or health events.",
  "Bioterrorism" => "Bioterrorism is the deliberate release of biological agents to cause illness, death, or disruption. Preparedness includes surveillance, laboratory identification, public-health communication, vaccination or prophylaxis when indicated, and rapid isolation or treatment of exposed people.",
  "Birth Control Methods" => "Birth-control methods include condoms, pills, implants, injections, intrauterine devices, patches, rings, fertility-awareness approaches, and permanent contraception. Effectiveness, sexually transmitted infection protection, side effects, reversibility, and medical eligibility vary by method.",
  "Birth Control Pill vs. Depo-Provera Shot" => "Combined or progestin-only pills require regular dosing, whereas the depot medroxyprogesterone injection provides contraception for about three months at a time. Both are effective when used correctly, but bleeding changes, bone-health considerations, contraindications, return to fertility, and adherence differ.",
  "Birthmarks and Other Skin Pigmentation Problems" => "Birthmarks and pigment changes may reflect vascular lesions, melanocytic cells, post-inflammatory change, medication, hormonal conditions, or genetic disease. A lesion that changes rapidly, bleeds, ulcerates, or differs from others should be examined.",
  "Bleeding After Not Having a Period for 10 Years" => "Any vaginal bleeding after menopause requires medical evaluation, even when it is light or occurs once. Causes include thinning tissue, polyps, hormone effects, and cancer; examination and often ultrasound or endometrial sampling determine the source.",
  "Bleeding Varices" => "Varices are enlarged, fragile veins, commonly in the esophagus or stomach when portal pressure is high. Rupture causes life-threatening gastrointestinal bleeding with vomiting blood, black stool, weakness, or shock and requires emergency treatment.",
  "Blood In Urine" => "Blood in the urine, or hematuria, may arise from infection, stones, prostate disease, kidney disease, trauma, medicines, or urinary-tract cancer. Visible blood, clots, pain, fever, inability to urinate, or persistent microscopic blood requires timely evaluation.",
  "Blood Pressure Chart: Reading by Age" => "Blood-pressure interpretation depends on repeated measurements, technique, age, pregnancy, comorbidities, and the guideline used; age alone does not define a safe target. Very high readings with chest pain, neurologic symptoms, shortness of breath, or confusion are emergencies.",
  "Blood Pressure Low (Low Blood Pressure)" => "Low blood pressure can be normal or can result from dehydration, bleeding, infection, heart disease, endocrine disease, or medicines. Symptoms such as fainting, confusion, chest pain, severe weakness, or shock require urgent assessment.",
  "Bottom Number of Your Blood Pressure is Over 100" => "A diastolic blood-pressure reading over 100 mm Hg is markedly elevated when confirmed with correct repeated measurements. Persistent elevation increases cardiovascular risk, while a very high reading with chest pain, breathlessness, neurologic symptoms, or confusion needs urgent care.",
  "Blood when I wipe: 11 causes of rectal bleeding" => "Blood on toilet paper may come from hemorrhoids, anal fissure, irritation, infection, inflammatory bowel disease, polyps, or colorectal cancer. The amount, color, pain, bowel changes, age, and recurrence guide evaluation; heavy bleeding or faintness is urgent.",
  "Body Type Ectomorph, Endomorph or Mesomorph" => "Ectomorph, endomorph, and mesomorph are informal body-type categories that do not reliably predict metabolism, health, or exercise response. Fitness and nutrition decisions are better based on measured health, goals, activity, and individual response.",
  "Bone Cancer Overview" => "Primary bone cancer is a malignant tumor arising in bone, while cancer more commonly spreads to bone from another organ. Persistent focal bone pain, swelling, or an unexplained fracture may prompt imaging and biopsy; treatment depends on tumor type and stage.",
  "Brain Aneurysm" => "A brain aneurysm is a weakened area of a cerebral artery that can enlarge and rupture. Rupture causes sudden severe headache, vomiting, neck stiffness, loss of consciousness, or neurologic deficits and is a medical emergency.",
  "Brain Cancer" => "Brain cancer consists of malignant tumors arising in or affecting brain tissue and its coverings. Symptoms depend on location and may include seizures, headache, weakness, speech or vision changes, personality change, or raised intracranial pressure; diagnosis uses imaging and tissue characterization.",
  "Brain Hemorrhage" => "A brain hemorrhage is bleeding within or around the brain, often from hypertension, aneurysm, vascular malformation, trauma, or blood-thinning treatment. Sudden headache, weakness, speech difficulty, vomiting, seizure, or reduced consciousness requires emergency evaluation.",
  "Brain Injury" => "Brain injury can result from trauma, lack of oxygen, stroke, infection, toxins, or other causes and may affect thinking, movement, sensation, behavior, or consciousness. Symptoms can evolve, so worsening headache, repeated vomiting, seizure, confusion, or weakness after injury is urgent.",
  "Brain Lesions" => "A brain lesion is an area of abnormal tissue caused by tumor, stroke, infection, inflammation, demyelination, trauma, or another process. Its significance depends on imaging features, location, symptoms, and change over time; it is not itself a diagnosis.",
  "Branchial Cyst" => "A branchial cyst is a congenital, usually benign fluid-filled lesion along an embryonic branchial-cleft remnant in the neck. It may present as a painless mass or become infected; examination and imaging guide management, and new adult neck masses require evaluation.",
  "Braxton Hicks vs. True Labor Contractions" => "Braxton Hicks contractions are usually irregular, do not progressively intensify, and may ease with rest or hydration. True labor contractions become longer, stronger, and closer together and lead to cervical change; rupture of membranes, bleeding, or decreased fetal movement requires obstetric advice.",
  "Breast Anatomy" => "The breast contains skin, fat, lobules that produce milk, ducts, connective tissue, blood vessels, nerves, and lymphatic drainage, extending toward the axilla. Normal structure varies with age, hormones, pregnancy, and lactation; a new persistent lump or skin change needs assessment.",
  "Breast Cancer (Facts, Stages)" => "Breast cancer is an uncontrolled growth of breast cells that may invade nearby tissue or spread to lymph nodes and distant organs. Stage reflects tumor size, nodes, and metastasis; receptor status and other biology also guide surgery, radiation, endocrine treatment, chemotherapy, or targeted therapy.",
  "Breast Cancer and Coping With Stress" => "Stress during breast-cancer diagnosis and treatment can affect sleep, mood, concentration, relationships, and adherence but does not mean a person caused the cancer. Counseling, support groups, exercise when safe, symptom treatment, and oncology or mental-health care can help.",
  "Breast Cancer and Lymphedema" => "Breast-cancer treatment can impair lymph drainage and cause swelling, heaviness, tightness, or skin changes in the arm, breast, or chest. Early assessment, compression when appropriate, exercise, skin protection, and specialized therapy can limit progression and complications.",
  "Breast Cancer Prevention" => "Breast-cancer risk can be lowered but not eliminated through physical activity, healthy weight, limiting alcohol, avoiding tobacco, appropriate screening, and discussing inherited risk. Preventive medicines or surgery may be considered for people at substantially elevated risk.",
  "Breast Cancer Questions To Ask The Doctor" => "Useful breast-cancer questions cover the pathology, stage, receptor and genetic results, treatment goals, alternatives, benefits, side effects, fertility, clinical trials, and follow-up. Written notes and a support person can help with complex decisions.",
  "Breast Cancer Recurrence" => "Breast-cancer recurrence is return of cancer after treatment, either near the original site, in regional nodes, or at distant sites. New lumps, bone pain, persistent cough, neurologic symptoms, or other concerning changes should be evaluated, but many symptoms have noncancer causes.",
  "Breast Implants Before Or After Pregnancy" => "Pregnancy after breast implants is usually possible, but breast shape and volume may change and breastfeeding ability depends on the operation and duct or nerve effects. Implant rupture, capsular contracture, pain, or new breast changes require surgical assessment.",
  "Breast Lumps In Women" => "A breast lump may be a cyst, fibroadenoma, infection, hormonal change, trauma-related finding, or cancer. Clinical examination and age-appropriate imaging, with biopsy when indicated, determine the cause; a new hard, fixed, enlarging, or skin-associated lump needs prompt review.",
  "Breastfeeding With Rheumatoid Arthritis" => "People with rheumatoid arthritis may be able to breastfeed, but disease activity, fatigue, hand function, and medicine safety must be considered. Some medicines are compatible and others require avoidance or timing changes; treatment should be planned with rheumatology and obstetric or pediatric clinicians.",
  "Brucellosis Facts" => "Brucellosis is a bacterial infection acquired from unpasteurized dairy products or contact with infected animals or tissues. It can cause prolonged fever, sweats, fatigue, joint or back pain, and organ complications and requires prolonged combination antibiotic treatment.",
  "Bruises" => "A bruise is bleeding beneath the skin after small blood vessels are damaged. Frequent, large, spontaneous, painful, or unusually persistent bruises may reflect medicines, platelet or clotting disorders, liver disease, nutritional deficiency, or injury and should be assessed.",
  "Bullying" => "Bullying is repeated aggression or intimidation involving a power imbalance and can be physical, verbal, social, or digital. It is associated with anxiety, depression, sleep problems, injury, school avoidance, and self-harm risk; safety planning and adult intervention are important.",
  "Bunions" => "A bunion is inward deviation of the big toe with prominence of the first metatarsophalangeal joint, often causing shoe pressure, pain, callus, or bursitis. Wider footwear, pads, activity changes, and selected surgery can relieve symptoms, but do not reverse the deformity without correction.",
  "Burns First Aid" => "Burn first aid includes removing the heat source, cooling a minor burn with cool running water, removing constricting items, and covering it with a clean nonstick dressing. Do not apply ice, butter, or adhesive materials; extensive, deep, electrical, chemical, facial, hand, genital, or airway burns need urgent care."
}.freeze

def latex_escape(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
text = File.read(output)
existing_titles = text.scan(/^\\medterm\{([^}]*)\}/).flatten
existing_by_normalized = existing_titles.to_h { |title| [normalize(title), title] }
terms = File.readlines(input, chomp: true)
additions = []

terms.each do |term|
  next if existing_by_normalized.key?(normalize(term))
  definition = DEFINITIONS[term]
  unless definition
    opening = term.index('(')
    if opening
      reference = term[(opening + 1)...-1]
      definition = "Alternate index label for #{latex_escape(reference)}."
    end
  end
  raise "No specific definition for #{term}" unless definition
  additions << [term, definition]
end

File.open(output, 'a') do |file|
  additions.each do |term, definition|
    file.puts
    file.puts "\\medterm{#{term}} #{definition}"
    file.puts
    file.puts '\\synonyms'
  end
end
puts "added #{additions.length} terms"
