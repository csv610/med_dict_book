#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Kaposi sarcoma' => 'Kaposi sarcoma is a vascular tumor associated with human herpesvirus 8, occurring most often with immunosuppression and affecting skin, mucosa, lymph nodes, or internal organs.',
  'Karyotyping' => 'Karyotyping examines the number and structure of chromosomes in cells to identify aneuploidy, large rearrangements, and selected chromosomal causes of disease.',
  'Kawasaki disease' => 'Kawasaki disease is an acute childhood vasculitis that can cause prolonged fever, mucosal and skin changes, lymph-node enlargement, and coronary-artery complications.',
  'Keloids' => 'Keloids are raised scars that extend beyond the original wound because of excessive collagen deposition and may cause itching, pain, or cosmetic concern.',
  'Keratoconus' => 'Keratoconus is progressive thinning and cone-shaped deformation of the cornea, causing irregular astigmatism, blurred vision, glare, and contact-lens intolerance.',
  'Keratosis pilaris' => 'Keratosis pilaris is a common harmless follicular condition producing rough small papules, often on the upper arms, thighs, cheeks, or buttocks.',
  'Kidney stones' => 'Kidney stones are crystalline deposits in the urinary tract that can cause colicky flank pain, hematuria, vomiting, obstruction, or infection depending on size and location.',
  'Kidney transplant' => 'Kidney transplantation replaces failed renal function with a donor kidney, requiring immunosuppression, rejection monitoring, infection prevention, and long-term graft care.',
  'Klinefelter syndrome' => 'Klinefelter syndrome is usually caused by an extra X chromosome in a male, often leading to small testes, reduced testosterone, infertility, tall stature, and variable learning or social differences.',
  'Krabbe disease' => 'Krabbe disease is an inherited leukodystrophy caused by deficient galactocerebrosidase, leading to toxic lipid accumulation and progressive destruction of myelin in the nervous system.',
  'Kuru' => 'Kuru is a rare fatal prion disease historically associated with ritual cannibalism, causing progressive ataxia, tremor, and neurologic decline.',
  'Kwashiorkor' => 'Kwashiorkor is severe protein-energy malnutrition characterized by edema, growth failure, muscle wasting, skin or hair changes, and impaired immune function.',
  'Kyphosis' => 'Kyphosis is excessive forward curvature of the thoracic spine, which may result from posture, vertebral compression, developmental conditions, degeneration, or inflammatory disease.'
}.freeze

def definition(term)
  name = term.strip
  lower = name.downcase
  return DEFINITIONS[name] if DEFINITIONS.key?(name)
  if lower =~ /poisoning|overdose|toxic|kerosene/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|scan|mri|x-ray|karyotyp|biopsy|culture|analysis|count|function|ketone/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|removal|replacement|transplant|arthroscopy|lithotripsy|kyphoplasty|brace|exercise|self-care|discharge|aftercare|organized|resources/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /disease|syndrome|sarcoma|keratosis|stone|pain|dislocation|arthritis|keloid|kyphosis|congenital/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /kidney|knee|bone|joint|skin|eye|protein|kinin|chromosome|medicine|muscle/
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
