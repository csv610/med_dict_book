#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  "Damage to the Amygdala" => "Damage to the amygdala can affect fear processing, emotional learning, memory, threat recognition, and social behavior. Causes include trauma, stroke, infection, tumor, epilepsy, or degenerative disease, and effects depend on the side and extent of injury.",
  "Degenerative Disc" => "Degenerative disc disease describes age- or wear-related changes in spinal discs that may cause neck or back pain, stiffness, or nerve compression. Imaging changes can occur without symptoms; treatment usually begins with activity, exercise-based rehabilitation, and pain management.",
  "De Quervain's Tenosynovitis" => "De Quervain tenosynovitis is painful inflammation or thickening of the thumb-side wrist tendons, often aggravated by gripping, lifting, or repetitive wrist motion. Rest, splinting, activity changes, injections, or surgery may be used according to severity.",
  "Dehydration: Causes and Prevention" => "Dehydration occurs when fluid loss exceeds intake through vomiting, diarrhea, fever, sweating, urination, or inadequate access to fluids. Prevention includes regular intake and replacement of electrolytes when needed; confusion, fainting, minimal urine, or severe weakness requires urgent care.",
  "Dengue Fever vs. Dengue Hemorrhagic Fever" => "Dengue fever commonly causes abrupt fever, headache, muscle and joint pain, nausea, and rash. Severe dengue can cause plasma leakage, bleeding, shock, or organ injury, often around the time fever falls, and requires close monitoring and urgent treatment.",
  "Dental Braces" => "Dental braces apply controlled force to move teeth and align the bite over time. Treatment requires oral hygiene, dietary care, periodic adjustments, and retention afterward; risks include temporary soreness, enamel decalcification, gum problems, and root changes.",
  "Dental Injuries" => "Dental injuries include fractures, displacement, loosening, or loss of teeth and damage to gums or jaw after trauma. Prompt dental assessment can preserve injured teeth; uncontrolled bleeding, jaw deformity, airway problems, or head injury requires emergency care.",
  "Depression in Children" => "Depression in children may present as persistent sadness, irritability, loss of interest, withdrawal, school decline, sleep or appetite change, physical complaints, guilt, or thoughts of death. Assessment considers development, family context, medical causes, safety, and treatment response.",
  "Diabetes and Eye Problems" => "Diabetes can damage retinal blood vessels, causing diabetic retinopathy, macular edema, cataracts, glaucoma, and vision loss. Blood-glucose and blood-pressure control, regular dilated eye examinations, and timely laser, injection, or surgical treatment reduce risk.",
  "Diabetes Symptoms in Men" => "Diabetes in men may cause thirst, frequent urination, fatigue, blurred vision, slow wound healing, recurrent infections, erectile dysfunction, or loss of sensation. Some people have no symptoms, so risk-based blood testing is important.",
  "Diabetes Symptoms in Women" => "Diabetes in women may cause thirst, frequent urination, fatigue, blurred vision, recurrent vaginal or urinary infections, slow wound healing, or pregnancy complications. Symptoms can be absent, and screening depends on age, risk factors, and pregnancy status.",
  "Diabetes Treatment" => "Diabetes treatment combines nutrition, physical activity, glucose monitoring, education, and medicines chosen for the type of diabetes and individual risks. Care also addresses blood pressure, lipids, kidneys, eyes, nerves, feet, vaccines, and cardiovascular health.",
  "Diabetic Diet for Type 2 Diabetes" => "A type 2 diabetes eating plan emphasizes consistent carbohydrate awareness, fiber-rich foods, adequate protein, unsaturated fats, and portions that support glucose and weight goals. There is no single diabetic diet; medicines, kidney function, culture, and preferences guide the plan.",
  "Diabetic Home Care and Monitoring" => "Home diabetes care may include checking glucose, taking medicines, inspecting feet, recognizing low or high glucose, recording results, and attending eye, kidney, dental, and cardiovascular follow-up. Sick-day plans and ketone guidance are important for people at risk of ketoacidosis.",
  "Diffuse Idiopathic Skeletal Hyperostosis" => "Diffuse idiopathic skeletal hyperostosis causes flowing calcification and ossification along spinal ligaments and may affect peripheral entheses. It can produce stiffness, pain, swallowing difficulty, or fractures after minor trauma; management is symptom-focused and addresses associated metabolic risks.",
  "Diphtheria Facts" => "Diphtheria is a toxin-producing infection, usually of the throat or skin, caused by Corynebacterium diphtheriae. A gray membrane, neck swelling, nerve injury, heart inflammation, and airway obstruction can occur; vaccination, isolation, antitoxin, and antibiotics are central to treatment.",
  "Direct vs Indirect Hernia" => "A direct inguinal hernia pushes through a weak area of the abdominal wall medial to the inferior epigastric vessels, while an indirect hernia follows the inguinal canal through the deep ring. Both may cause a groin bulge and can become incarcerated or strangulated.",
  "Dislocated Elbow" => "An elbow dislocation occurs when the joint surfaces lose alignment, usually after a fall or collision. It causes severe pain, deformity, and limited movement and requires urgent reduction with assessment of nerves, blood vessels, fractures, and later stiffness.",
  "Dislocated Hip" => "A hip dislocation is displacement of the femoral head from the acetabulum, usually after major trauma or around a prosthetic joint. It is an emergency because blood supply to the femoral head and nearby nerves can be compromised.",
  "Dislocated Knee" => "A knee dislocation is loss of alignment between the femur and tibia, often after high-energy trauma. Artery and nerve injury may be occult, so urgent reduction and vascular assessment are required even when the joint spontaneously relocates.",
  "Diverticulosis vs Diverticulitis" => "Diverticulosis is the presence of pouches in the colon wall and may cause no symptoms or bleeding. Diverticulitis occurs when a pouch becomes inflamed or infected, causing localized pain, fever, bowel changes, or complications such as abscess or perforation.",
  "Dizziness: Causes, Symptoms, and Treatment" => "Dizziness may mean vertigo, lightheadedness, imbalance, or a floating sensation. Causes include inner-ear disease, dehydration, medication, anemia, heart rhythm problems, migraine, anxiety, or neurologic disease; treatment depends on the pattern and examination.",
  "Dizziness: When To See a Doctor?" => "Dizziness needs urgent assessment when it begins suddenly or occurs with weakness, numbness, trouble speaking, severe headache, chest pain, fainting, inability to walk, persistent vomiting, or new hearing loss. Recurrent or unexplained dizziness also merits evaluation.",
  "Dog Bite Treatment" => "Dog-bite care includes thorough wound cleaning, assessment of tissue and tendon injury, tetanus review, rabies-risk evaluation, and antibiotics when indicated. Deep punctures, bites to the hand or face, uncontrolled bleeding, infection, or immune compromise require prompt medical care.",
  "Dos and Donts During First Trimester of Pregnancy" => "First-trimester care includes prenatal visits, recommended folic acid, avoidance of alcohol and tobacco, medication review, food-safety precautions, and appropriate activity. Severe pain, heavy bleeding, fainting, fever, or persistent vomiting needs urgent obstetric evaluation.",
  "Double Vision" => "Double vision may arise from an eye alignment problem, corneal or lens disease, muscle or nerve dysfunction, medication, migraine, or brain disease. Sudden double vision, especially with weakness, speech change, severe headache, or eye pain, is an emergency.",
  "Doula vs. Midwife" => "A doula provides nonmedical emotional, informational, and physical support during pregnancy, birth, and postpartum care. A midwife is a licensed clinician who provides medical maternity care within training and local scope, including assessment and management of normal pregnancy and birth.",
  "Down Syndrome Overview" => "Down syndrome is a genetic condition caused by an extra chromosome 21 and is associated with characteristic features, developmental differences, hypotonia, and variable heart, hearing, vision, thyroid, gastrointestinal, and sleep conditions. Lifelong individualized health and developmental support is beneficial.",
  "Drug Induced Liver Disease" => "Drug-induced liver injury occurs when a medicine, supplement, or toxin damages liver cells or bile flow. It may cause fatigue, nausea, itching, dark urine, jaundice, or no symptoms; identifying and stopping the responsible exposure under medical guidance is central to care.",
  "Dry Socket Overview" => "Dry socket is painful inflammation after a tooth extraction when the protective blood clot is lost or breaks down before healing. Pain often worsens several days after extraction and may radiate to the ear; dental cleaning, medicated dressing, and analgesia provide relief.",
  "Duck Syndrome" => "Duck syndrome is an informal term for appearing successful while privately experiencing severe stress, anxiety, exhaustion, or depression. It is not a formal diagnosis; persistent distress, impaired functioning, or self-harm thoughts warrant mental-health evaluation and support.",
  "Duodenal Diverticulum" => "A duodenal diverticulum is an outpouching of the duodenal wall, often found incidentally near the ampulla. It can rarely cause pain, bleeding, inflammation, obstruction, pancreatitis, or bile-duct infection and is treated according to symptoms and complications."
}.freeze

def excluded_title?(term)
  term =~ /^(Dandruff vs|Dealing|Difference|Differences|Disadvantages|Disease Prevention|Diseases Get|Do |Does |Dream |Drink |Drinking |Duration |DVT and|DVT deep|Dandruff)/
end

def latex_escape(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
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
puts "added #{additions.length} terms"
