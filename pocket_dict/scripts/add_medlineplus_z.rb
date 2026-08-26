#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Zika virus disease' => 'Zika virus disease is an infection caused by Zika virus, usually spread by infected Aedes mosquitoes and sometimes through sex or from a pregnant person to the fetus. Many infections are mild or asymptomatic, but infection during pregnancy can cause congenital Zika syndrome; Guillain-Barré syndrome is a rare adult complication.',
  'Zinc in diet' => 'Zinc in the diet is supplied by foods such as meat, shellfish, dairy products, beans, nuts, and fortified grains. It supports immune function, protein and DNA synthesis, wound healing, growth, and taste; requirements and supplement safety depend on age, pregnancy, diet, and medical conditions.',
  'Zinc oxide overdose' => 'Zinc oxide overdose occurs after ingesting an excessive amount of zinc oxide, often from a product or supplement. It can cause nausea, vomiting, abdominal pain, diarrhea, and, with substantial or repeated exposure, copper deficiency, anemia, and impaired immune function; poison-control or emergency guidance may be needed.',
  'Zinc poisoning' => 'Zinc poisoning is illness from excessive zinc exposure, commonly through large supplement doses or occupational sources. Acute exposure can cause gastrointestinal symptoms, while repeated excess can produce copper deficiency, anemia, altered lipid metabolism, and immune or neurologic effects.',
  'Zollinger-Ellison syndrome' => 'Zollinger-Ellison syndrome is caused by one or more gastrin-secreting tumors, usually in the pancreas or duodenum. Excess gastrin drives severe gastric-acid production, leading to recurrent peptic ulcers, abdominal pain, reflux, and diarrhea; tumors may occur with multiple endocrine neoplasia type 1.'
}.freeze

input = ARGV.fetch(0)
output = ARGV.fetch(1)
text = File.read(output)
existing_titles = text.scan(/^\\medterm\{([^}]*)\}/).flatten
existing_by_normalized = existing_titles.to_h { |title| [normalize(title), title] }
terms = File.readlines(input, chomp: true).reject(&:empty?)
additions = []

terms.each do |term|
  definition = DEFINITIONS.fetch(term.strip)
  actual_title = existing_by_normalized[normalize(term.strip)]
  if actual_title
    escaped_title = Regexp.escape(actual_title)
    pattern = /^\\medterm\{#{escaped_title}\}.*?(?=\n\n\\synonyms)/m
    replacement = "\\medterm{#{actual_title}} #{definition}"
    text.sub!(pattern, replacement)
  else
    additions << term.strip
  end
end

File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term}} #{DEFINITIONS.fetch(term)}"
    file.puts
    file.puts '\\synonyms'
  end
end
puts "added #{additions.length} terms"
