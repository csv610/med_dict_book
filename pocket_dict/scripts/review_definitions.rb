#!/usr/bin/env ruby

Entry = Struct.new(:file, :line, :term, :definition, :synonyms, keyword_init: true)

entries = []
Dir['chapters/med_terms_*.tex'].sort.each do |file|
  lines = File.readlines(file, chomp: true)
  i = 0
  while i < lines.length
    match = lines[i].match(/^\\medterm\{([^}]*)\}\s*(.*)$/)
    unless match
      i += 1
      next
    end
    term = match[1]
    definition = [match[2]]
    i += 1
    while i < lines.length && lines[i] !~ /^\\textbf\{Synonyms\}:$/
      definition << lines[i]
      i += 1
    end
    i += 1
    synonyms = []
    while i < lines.length && lines[i] !~ /^\\medterm\{/ && !lines[i].empty?
      synonyms << lines[i]
      i += 1
    end
    i += 1 while i < lines.length && lines[i].empty?
    entries << Entry.new(file: file, line: i, term: term, definition: definition.join(' ').strip, synonyms: synonyms.join(' ').strip)
  end
end

boilerplate = /medical or biomedical term used|biomedical dictionary term|patient-care topic focused|precise meaning depends|health-care subject named|is a health condition or clinical topic requiring/i
long = entries.select { |e| e.definition.scan(/[.!?](?:\s|$)/).length > 5 }
empty = entries.select { |e| e.definition.empty? }
same_line_synonyms = entries.select { |e| e.synonyms.match?(/\S/) && e.synonyms.lines.first&.match?(/^\\textbf\{Synonyms\}/) }
duplicates = entries.group_by { |e| e.term.downcase.gsub(/[^a-z0-9]/, '') }.values.select { |group| group.length > 1 }

puts "entries=#{entries.length}"
puts "long_definitions=#{long.length}"
puts "empty_definitions=#{empty.length}"
puts "boilerplate_definitions=#{entries.count { |e| e.definition.match?(boilerplate) }}"
puts "same_line_synonyms=#{same_line_synonyms.length}"
puts "duplicate_normalized_titles=#{duplicates.length}"

[['LONG', long], ['EMPTY', empty], ['BOILERPLATE', entries.select { |e| e.definition.match?(boilerplate) }]].each do |label, list|
  list.each { |e| puts "#{label}\t#{e.file}:#{e.line}\t#{e.term}\t#{e.definition}" }
end
