#!/usr/bin/env ruby

def sentence_count(text)
  text.scan(/[.!?](?:\s|$)/).length
end

Dir['chapters/med_terms_*.tex'].each do |path|
  lines = File.readlines(path, chomp: true)
  output = []
  i = 0
  changed = 0
  while i < lines.length
    match = lines[i].match(/^\\medterm\{([^}]*)\}(\s*)(.*)$/)
    unless match
      output << lines[i]
      i += 1
      next
    end

    term, spacing, first = match.captures
    definition_lines = [first]
    i += 1
    while i < lines.length && lines[i] !~ /^\\textbf\{Synonyms\}:$/ && lines[i] !~ /^\\medterm\{/ 
      definition_lines << lines[i]
      i += 1
    end
    definition = definition_lines.join(' ').gsub(/\s+/, ' ').strip
    if sentence_count(definition) > 5
      definition = definition.split(/(?<=[.!?])\s+/).first(5).join(' ')
      changed += 1
      output << "\\medterm{#{term}}#{spacing}#{definition}"
    else
      output << "\\medterm{#{term}}#{spacing}#{first}"
      output.concat(definition_lines.drop(1))
    end
  end
  File.write(path, output.join("\n") + "\n") if changed.positive?
  puts "#{path}: #{changed}" if changed.positive?
end
