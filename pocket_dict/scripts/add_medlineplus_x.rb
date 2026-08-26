#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'X-ray' => 'An X-ray is an imaging study that passes a small amount of ionizing radiation through the body to create a projection image. Differences in tissue density help show bones, lungs, teeth, and selected soft-tissue abnormalities.',
  'X-ray - skeleton' => 'A skeletal X-ray series uses radiographs of selected bones and joints to evaluate fractures, alignment, bone density patterns, arthritis, infection, tumors, and developmental abnormalities.',
  'Xanthoma' => 'A xanthoma is a yellowish deposit of lipid-laden macrophages in the skin, subcutaneous tissue, or tendons. It may occur with hyperlipidemia, diabetes, cholestatic liver disease, or an inherited lipid disorder and warrants assessment of the underlying cause.',
  'Xeroderma pigmentosum' => 'Xeroderma pigmentosum is a rare autosomal-recessive disorder of nucleotide-excision DNA repair that causes extreme sensitivity to ultraviolet radiation. It leads to early freckling, pigment changes, eye and neurologic complications in some people, and a markedly increased risk of skin cancers.'
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
