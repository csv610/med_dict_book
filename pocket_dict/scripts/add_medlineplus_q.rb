#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Q fever' => 'Q fever is a zoonotic infection caused by Coxiella burnetii, usually acquired by inhaling contaminated particles and causing fever, hepatitis, pneumonia, or chronic endocarditis.',
  'Quadruple screen test' => 'The quadruple screen measures maternal blood markers to estimate risk of selected fetal chromosomal or neural-tube conditions; it is a screening test, not a diagnosis.',
  'Quantitative Bence-Jones protein test' => 'A quantitative Bence-Jones protein test measures free monoclonal light chains in urine, supporting evaluation and monitoring of plasma-cell disorders such as multiple myeloma.',
  'Quantitative immunoglobulins' => 'Quantitative immunoglobulin testing measures classes of antibodies in blood and helps evaluate immune deficiency, chronic inflammation, monoclonal gammopathy, or abnormal immune activation.',
  'Quantitative nephelometry test' => 'Quantitative nephelometry estimates specific proteins by measuring light scattered by immune complexes, supporting assessment of immunoglobulins, complement, and other serum proteins.',
  'Questions to ask your child\'s doctor about cancer' => 'Questions about a child’s cancer should clarify the diagnosis, stage, treatment options, expected benefits and risks, clinical trials, supportive care, and follow-up plan.',
  'Questions to ask your doctor about getting pregnant' => 'Questions before pregnancy should address chronic conditions, medications, vaccinations, genetic risks, nutrition, fertility timing, and health changes that improve pregnancy safety.',
  'Questions to ask your doctor about going home with your baby' => 'Questions before taking a newborn home should cover feeding, sleep safety, medicines, warning signs, follow-up, immunizations, and when to seek urgent care.',
  'Questions to ask your doctor about hospital care after delivery' => 'Questions after delivery should clarify maternal recovery, bleeding, pain, wound care, mood symptoms, feeding, contraception, newborn care, and follow-up.',
  'Questions to ask your doctor about staying healthy during pregnancy' => 'Pregnancy health questions should address nutrition, activity, prenatal testing, medications, infection prevention, warning signs, and management of existing medical conditions.',
  'Questions to ask your doctor after knee replacement' => 'Questions after knee replacement should clarify wound care, pain control, mobility restrictions, exercises, clot prevention, infection warning signs, and rehabilitation milestones.',
  'Questions to ask your doctor before knee replacement' => 'Questions before knee replacement should address the diagnosis, alternatives, implant choice, surgical risks, preparation, expected recovery, rehabilitation, and long-term activity.',
  'Questions to ask your health care provider about labor and delivery' => 'Labor and delivery questions should clarify birth-plan preferences, pain relief, monitoring, induction, cesarean indications, newborn care, and urgent situations.',
  'Questions to ask your health care provider about post pregnancy care' => 'Post-pregnancy care questions should cover bleeding, pain, blood pressure, incision or tear healing, mood, contraception, lactation, pelvic recovery, and routine follow-up.',
  'Questions to ask your surgeon about spinal surgery' => 'Questions before spinal surgery should clarify the pain generator, goals, alternatives, procedure, neurologic risks, recovery restrictions, rehabilitation, and expected outcomes.'
}.freeze

input = ARGV.fetch(0)
output = ARGV.fetch(1)
existing = File.read(output).scan(/\\medterm\{([^}]*)\}/).flatten.map { |x| normalize(x) }
known = existing.to_h { |x| [x, true] }
terms = File.readlines(input, chomp: true).reject(&:empty?)
additions = terms.reject { |term| known[normalize(term)] }
text = File.read(output)
terms.each do |term|
  escaped = Regexp.escape(term.strip)
  text.gsub!(/^\\medterm\{#{escaped}\s*\}.*$/, "\\medterm{#{term.strip}} #{DEFINITIONS.fetch(term.strip)}")
end
File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term.strip}} #{DEFINITIONS.fetch(term.strip)}"
    file.puts
    file.puts '\\synonyms'
  end
end
puts "added #{additions.length} terms"
