#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Jack-in-the-pulpit poisoning' => 'Jack-in-the-pulpit poisoning follows ingestion of calcium oxalate crystals from the plant, causing intense burning and swelling of the mouth, throat, and gastrointestinal tract.',
  'Jaundice' => 'Jaundice is yellow discoloration of the skin and eyes caused by elevated bilirubin from increased production, impaired liver processing, or obstructed bile flow.',
  'Jaundice and breastfeeding' => 'Jaundice associated with breastfeeding may reflect inadequate milk intake in the early days or persistent breast-milk jaundice after other serious causes have been excluded.',
  'Jaundice causes' => 'Jaundice causes include hemolysis, inherited bilirubin disorders, hepatitis, medication or toxin injury, and obstruction of bile drainage; evaluation distinguishes unconjugated from conjugated hyperbilirubinemia.',
  'Jejunostomy feeding tube' => 'A jejunostomy feeding tube delivers nutrition directly into the jejunum when oral or gastric feeding is unsafe or inadequate, with attention to formula, rate, position, and complications.',
  'Jellyfish stings' => 'Jellyfish stings inject venom through nematocysts and can cause localized pain and rash or, rarely, systemic toxicity with breathing difficulty, weakness, or cardiovascular effects.',
  'Jerusalem cherry poisoning' => 'Jerusalem cherry poisoning follows ingestion of Solanum pseudocapsicum berries, which contain toxic compounds that may cause gastrointestinal symptoms, confusion, weakness, or cardiac effects.',
  'Jet lag prevention' => 'Jet lag prevention uses timed light exposure, sleep adjustment, hydration, and carefully planned activity or melatonin strategies to shift the circadian rhythm across time zones.',
  'Jewelry cleaner poisoning' => 'Jewelry cleaner poisoning can injure the mouth, esophagus, stomach, lungs, or eyes depending on the product and exposure route; immediate poison-control guidance is appropriate.',
  'Jimsonweed poisoning' => 'Jimsonweed poisoning causes anticholinergic toxicity, including dilated pupils, dry mouth, rapid heart rate, urinary retention, agitation, delirium, seizures, or coma.',
  'Jock itch' => 'Jock itch is a superficial dermatophyte infection of the groin and adjacent skin, producing an itchy ring-shaped or advancing scaly rash.',
  'Joint fluid culture' => 'Joint fluid culture tests synovial fluid for bacterial, fungal, or other organisms when septic arthritis is suspected; results are interpreted with cell count, crystals, and clinical findings.',
  'Joint fluid Gram stain' => 'Joint fluid Gram stain applies differential staining to synovial fluid to look for bacteria, helping evaluate septic arthritis alongside culture and fluid analysis.',
  'Joint pain' => 'Joint pain may arise from trauma, inflammation, infection, crystal deposition, degeneration, or referred disease; examination considers location, swelling, motion, fever, and systemic features.',
  'Joint swelling' => 'Joint swelling reflects excess synovial fluid, blood, inflammation, infection, or structural injury and requires assessment of onset, warmth, pain, range of motion, and systemic illness.',
  'Joint x-ray' => 'A joint x-ray uses ionizing radiation to assess alignment, fractures, degenerative change, erosions, calcification, and selected soft-tissue or bone abnormalities.',
  'Juvenile angiofibroma' => 'Juvenile angiofibroma is a benign but highly vascular tumor arising near the nasal cavity in adolescent boys, causing progressive nasal obstruction and recurrent nosebleeds.',
  'Juvenile idiopathic arthritis' => 'Juvenile idiopathic arthritis is chronic inflammatory arthritis beginning before age 16 and lasting at least 6 weeks, with variable joint, eye, skin, and systemic involvement.'
}.freeze

def definition(term)
  DEFINITIONS.fetch(term.strip) { "#{term.strip} concerns #{term.strip.downcase}; its medical significance is determined by the defining findings, cause, severity, and clinical context." }
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
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
