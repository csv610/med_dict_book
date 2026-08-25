#!/usr/bin/env ruby

Dir['chapters/med_terms_*.tex'].each do |path|
  lines = File.readlines(path, chomp: true)
  changed = 0
  lines.map! do |line|
    match = line.match(/^\\medterm\{([^}]*)\}(\s+)(.*)$/)
    next line unless match
    term, spacing, definition = match.captures
    sentences = definition.split(/(?<=[.!?])\s+/)
    next line unless sentences.length > 5
    changed += 1
    "\\medterm{#{term}}#{spacing}#{sentences.first(5).join(' ')}"
  end
  File.write(path, lines.join("\n") + "\n") if changed.positive?
  puts "#{path}: #{changed}" if changed.positive?
end
