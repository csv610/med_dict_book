#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Ulcerative colitis' => 'Ulcerative colitis is chronic inflammatory disease of the colon and rectum causing continuous mucosal inflammation, diarrhea, rectal bleeding, urgency, pain, and variable systemic complications.',
  'Ulnar nerve dysfunction' => 'Ulnar nerve dysfunction causes numbness or tingling in the little and ring fingers and weakness of hand muscles from compression, trauma, inflammation, or systemic neuropathy.',
  'Ultrasound' => 'Ultrasound uses high-frequency sound waves to create images of organs, vessels, tissues, or a developing fetus without ionizing radiation.',
  'Umbilical hernia' => 'An umbilical hernia is protrusion of abdominal contents through weakness at the navel, often closing spontaneously in children but sometimes requiring repair or urgent assessment.',
  'Unstable angina' => 'Unstable angina is acute coronary ischemia with new, worsening, or rest chest discomfort without established myocardial infarction and is treated as an emergency.',
  'Ureteropelvic junction obstruction' => 'Ureteropelvic junction obstruction impairs urine flow from the renal pelvis into the ureter, causing hydronephrosis, flank pain, infection, stones, or declining kidney function.',
  'Urethritis' => 'Urethritis is inflammation of the urethra, commonly from sexually transmitted infection, causing dysuria, irritation, or discharge and requiring evaluation of partners and complications.',
  'Urinary incontinence' => 'Urinary incontinence is involuntary urine leakage caused by problems with bladder storage, sphincter control, pelvic support, neurologic function, or mobility.',
  'Urinary tract infection - adults' => 'Urinary tract infection in adults is microbial infection of the bladder, urethra, ureters, or kidneys, causing dysuria, frequency, urgency, pelvic pain, fever, or flank pain depending on location.',
  'Uterine fibroids' => 'Uterine fibroids are benign smooth-muscle tumors of the uterus that may cause heavy menstrual bleeding, pelvic pressure, pain, infertility, or no symptoms.',
  'Uterine prolapse' => 'Uterine prolapse is descent of the uterus into or through the vaginal canal because pelvic support weakens, causing pressure, bulging, urinary symptoms, or bowel difficulties.',
  'Uveitis' => 'Uveitis is inflammation of the uveal tract and adjacent eye structures, causing pain, redness, light sensitivity, floaters, or impaired vision from infectious, autoimmune, traumatic, or other causes.',
  'Uvulitis' => 'Uvulitis is inflammation and swelling of the uvula from infection, trauma, allergy, dehydration, or irritation and may interfere with swallowing or airway protection.',
  'Urinalysis' => 'Urinalysis examines urine appearance, chemistry, and sediment for evidence of infection, kidney disease, bleeding, diabetes, dehydration, or other systemic conditions.',
  'Urinary tract infection in children' => 'Urinary tract infection in children is bacterial infection of the urinary system that may present with fever, vomiting, irritability, urinary symptoms, or kidney-injury risk.',
  'Urethral stricture' => 'Urethral stricture is narrowing from scar tissue that obstructs urine flow, causing weak stream, spraying, incomplete emptying, infections, retention, or renal complications.',
  'Ureteroscopy' => 'Ureteroscopy uses a small endoscope passed through the urinary tract to inspect, biopsy, or treat ureteral or kidney stones and other lesions.',
  'Urostomy - stoma and skin care' => 'Urostomy care protects the stoma and surrounding skin, maintains pouch drainage, manages urine leakage, and monitors for infection, obstruction, or changes requiring clinical review.',
  'Urinary catheters' => 'Urinary catheters drain the bladder when a person cannot empty it normally or accurate urine measurement is needed, with risks including infection, trauma, blockage, and discomfort.',
  'Umbilical catheters' => 'Umbilical catheters provide vascular access through a newborn’s umbilical vessels for fluids, medicines, monitoring, or blood sampling while complications are monitored.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /test|scan|ultrasound|culture|analysis|count|sampling|chemistry|concentration|pH|electrophoresis|uroflowmetry|catheter|biopsy|upper gi/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|repair|reimplantation|ureteroscopy|embolization|procedure|discharge|aftercare|self-care|catheter|sling|suspension|stoma|pouch|care|using|understanding|insurance|medicare|diet|oxygen|antibiotics|restraints|cane|walker|crutches|spirometer/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /ulcer|colitis|neuropathy|hernia|cancer|angina|obstruction|urethritis|incontinence|infection|prolapse|sarcoma|uveitis|uvulitis|dysfunction|stone|cyst|disease|syndrome|tumor|pain|bleeding|retention|urination|urine|unconsciousness|testicle|nodule/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /resources|food|health|insurance|cost|cancer risk|prognosis|staging|safety|newborn|cord|breast|prostate|colorectal|cardiovascular|medicare|DASH|information|care providers/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|uter|ureter|urethra|urinary|umbilical|uvea|uvula/
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
