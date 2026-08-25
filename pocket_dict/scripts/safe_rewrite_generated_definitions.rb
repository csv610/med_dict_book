#!/usr/bin/env ruby

def escape_latex(value)
  value.gsub('&', '\\&').gsub('%', '\\%').gsub('#', '\\#')
end

Dir['chapters/med_terms_*.tex'].each do |path|
  lines = File.readlines(path, chomp: true)
  changed = 0
  lines.map! do |line|
    match = line.match(/^\\medterm\{([^}]*)\}(\s+)(.*)$/)
    next line unless match

    term, spacing, definition = match.captures
    revised = case definition
              when /is a medical condition involving .*; causes, affected organs, severity, complications, and treatment are determined by clinical assessment\./i
                "#{term} is a disorder affecting the body system or process named by the term. Clinical features and causes vary, so diagnosis is based on the history, examination, and appropriate investigations."
              when /denotes a clinical condition or finding involving .*; evaluation identifies mechanism, affected system, severity, complications, and management\./i
                "#{term} describes a clinical disorder or finding in the body system or process named by the term. Evaluation identifies the underlying mechanism, affected site, severity, and clinically relevant complications."
              when /denotes a neoplastic condition involving .*; evaluation establishes tissue of origin, extent, biologic behavior, and treatment\./i
                "#{term} describes a neoplastic process involving the tissue or organ named by the term. Diagnosis establishes the tumor type, extent, biologic behavior, and appropriate management."
              when /denotes an infectious or toxic condition involving .*; diagnosis considers exposure or pathogen, affected site, severity, and host response\./i
                "#{term} describes an infectious or toxic process involving the site or exposure named by the term. Diagnosis considers the cause, route of exposure, affected tissues, severity, and host response."
              when /is a virus or viral group associated with .*; disease risk depends on strain, transmission route, host, and tissue tropism\./i
                "#{term} is a virus or viral group classified by its genetic and biologic features. Clinical importance depends on the strain, host, route of transmission, tissue tropism, and ability to cause disease."
              when /is a microorganism or microbial group associated with .*; clinical relevance depends on pathogenicity, exposure, site, and antimicrobial susceptibility\./i
                "#{term} is a microorganism or microbial group identified by its biologic and taxonomic features. Clinical significance depends on pathogenicity, exposure, the site involved, and antimicrobial susceptibility."
              when /denotes a biological component or molecular process interpreted through relevant cells, pathways, tissues, and laboratory findings\./i
                "#{term} is a biological component or molecular process involved in normal physiology or disease. Its role is interpreted through the relevant cells, pathways, tissues, and laboratory findings."
              when /denotes an anatomical structure or tissue; its clinical importance depends on its location, connections, blood supply, innervation, and function\./i
                "#{term} is an anatomical structure or tissue identified by its location and relationships to nearby structures. Its clinical importance depends on its function, blood supply, innervation, and involvement in disease or injury."
              when /refers to .* a medical condition or clinical finding defined by its features, causes, affected system, and patient context\./i
                "#{term} is a medical condition or clinical finding involving the body system or process named by the term. Its significance is established from its characteristic features, causes, and clinical context."
              else
                nil
              end
    if revised
      changed += 1
      "\\medterm{#{escape_latex(term)}}#{spacing}#{revised}"
    else
      line
    end
  end
  File.write(path, lines.join("\n") + "\n") if changed.positive?
  puts "#{path}: #{changed}" if changed.positive?
end
