#!/usr/bin/env ruby

require "fileutils"

root = File.expand_path("..", __dir__)
source_dir = File.join(root, "chapters")
output_dir = File.join(root, "pocket_dict", "chapters")
FileUtils.mkdir_p(output_dir)

entries = {}

Dir.glob(File.join(source_dir, "*.tex")).sort.each do |path|
  current = nil
  flush = lambda do
    next unless current
    title, definition = current
    unless title.empty?
      definition = "Medical term; definition not provided in source." if definition.empty?
      key = title.downcase
      existing = entries[key]
      entries[key] = [title, definition] if existing.nil? || definition.length > existing[1].length
    end
    current = nil
  end

  File.foreach(path) do |line|
    if line.start_with?("\\medterm{")
      flush.call
      separator = line.index("}--")
      next unless separator
      title = line[9...separator].strip
      definition = line[(separator + 3)..].to_s.strip
      current = [title, definition]
    elsif current && !line.strip.empty?
      current[1] = [current[1], line.strip].reject(&:empty?).join(" ")
    else
      flush.call
    end
  end
  flush.call
end

def plain_definition(text)
  text = text.gsub(/\\hyperlink\{[^{}]*\}\{([^{}]*)\}/, '\\1')
  text = text.gsub(/\\href\{[^{}]*\}\{([^{}]*)\}/, '\\1')
  text = text.gsub(/\\(?:textbf|textit|emph|underline)\{([^{}]*)\}/, '\\1')
  text = text.gsub(/\\[A-Za-z]+\*?(?:\[[^\]]*\])?/, "")
  text = text.gsub(/[{}$]/, "")
  text = text.gsub(/\\([%&#_])/, '\\1')
  text = text.gsub(/\s+/, " ").strip

  sentences = text.split(/(?<=[.!?])\s+/)
  selected = ""
  sentences.each do |sentence|
    candidate = [selected, sentence].reject(&:empty?).join(" ")
    break if candidate.length > 340
    selected = candidate
  end
  selected = text[0, 340] if selected.empty?
  selected = selected.sub(/\s+\S*\z/, "") if selected.length > 340
  selected.gsub(/([%&#_])/, '\\\1')
end

groups = Hash.new { |hash, key| hash[key] = [] }
entries.values.each do |title, definition|
  initial = title[/[A-Za-z]/]&.upcase
  next unless initial
  groups[initial] << [title, plain_definition(definition)]
end

("A".."Z").each do |letter|
  terms = groups[letter].sort_by { |title, _| title.gsub(/\\([%&#_])/, '\\1').downcase }
  path = File.join(output_dir, "med_terms_#{letter.downcase}.tex")
  File.open(path, "w") do |file|
    file.puts "\\chapter{Pocket Dictionary: #{letter} Terms}"
    file.puts
    terms.each do |title, definition|
      words = definition.split
      lines = []
      current = ""
      words.each do |word|
        candidate = current.empty? ? word : "#{current} #{word}"
        if candidate.length > 88 && !current.empty?
          lines << current
          current = word
        else
          current = candidate
        end
      end
      lines << current unless current.empty?
      lines = lines.first(4)
      safe_title = title.gsub(/([%&#_])/, '\\1')
      file.puts "\\medterm{#{safe_title}}-- #{lines.shift}"
      lines.each { |line| file.puts line }
      file.puts
    end
  end
end

puts "unique terms: #{entries.length}"
puts groups.sort.map { |letter, terms| "#{letter}: #{terms.length}" }
