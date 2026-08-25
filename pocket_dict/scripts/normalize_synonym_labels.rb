#!/usr/bin/env ruby

Dir['chapters/med_terms_*.tex'].each do |path|
  lines = File.readlines(path, chomp: true)
  compact = []
  lines.each do |line|
    if line == '\\textbf{Synonyms}:'
      previous = compact.reverse.find { |value| !value.empty? }
      next if previous == '\\textbf{Synonyms}:'
    end
    compact << line
  end

  output = []
  i = 0
  while i < compact.length
    output << compact[i]
    unless compact[i].start_with?('\\medterm{')
      i += 1
      next
    end
    i += 1
    found = false
    while i < compact.length && compact[i] !~ /^\\medterm\{/
      found ||= compact[i] == '\\textbf{Synonyms}:'
      output << compact[i]
      i += 1
    end
    unless found
      output << '' unless output.last == ''
      output << '\\textbf{Synonyms}:'
    end
  end
  File.write(path, output.join("\n") + "\n")
end
