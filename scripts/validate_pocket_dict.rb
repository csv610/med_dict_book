#!/usr/bin/env ruby

root = File.expand_path("..", __dir__)
source = {}

Dir.glob(File.join(root, "chapters", "*.tex")).sort.each do |path|
  File.foreach(path) do |line|
    next unless line.start_with?("\\medterm{")
    separator = line.index("}--")
    next unless separator
    title = line[9...separator].strip.gsub(/\\([%&#_])/, '\\1')
    source[title.downcase] = title unless title.empty?
  end
end

files = Dir.glob(File.join(root, "pocket_dict", "chapters", "med_terms_[a-z].tex")).sort
abort "expected 26 letter files, found #{files.length}" unless files.length == 26

generated = {}
max_lines = 0
ordering_errors = []

files.each do |path|
  titles = []
  current_lines = 0
  File.foreach(path) do |line|
    if line.start_with?("\\medterm{")
      max_lines = [max_lines, current_lines].max
      current_lines = 1
      separator = line.index("}--")
      abort "malformed entry in #{path}" unless separator
      title = line[9...separator].strip.gsub(/\\([%&#_])/, '\\1')
      titles << title
      generated[title.downcase] = title
    elsif current_lines.positive?
      if line.strip.empty?
        max_lines = [max_lines, current_lines].max
        current_lines = 0
      else
        current_lines += 1
      end
    end
  end
  max_lines = [max_lines, current_lines].max
  normalized_titles = titles.map { |title| title.gsub(/\\([%&#_])/, '\\1') }
  ordering_errors << File.basename(path) unless normalized_titles == normalized_titles.sort_by(&:downcase)
end

missing = source.keys - generated.keys
extra = generated.keys - source.keys
abort "coverage mismatch: missing=#{missing.inspect}, extra=#{extra.inspect}" unless missing.empty? && extra.empty?
abort "duplicate generated titles" unless generated.length == source.length
abort "alphabetical order errors: #{ordering_errors.join(', ')}" unless ordering_errors.empty?
abort "entry exceeds four source lines" if max_lines > 4

puts "validated: #{generated.length} unique terms, 26 files, alphabetical order, exact source coverage"
puts "maximum entry length: #{max_lines} source lines"
