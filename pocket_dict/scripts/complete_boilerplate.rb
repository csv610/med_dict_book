#!/usr/bin/env ruby

GENERIC = {
  condition: [
    'is a medical or biomedical term used in clinical practice, research, anatomy, or health care; its interpretation depends on context.',
    'A biomedical dictionary term used in medical, biological, laboratory, or health-care contexts; its precise meaning depends on the surrounding clinical or research context.',
    'is a medical condition or clinical entity; assessment and management depend on its cause, severity, and the individual patient.',
    'A medical condition or disease-related term describing a disorder, symptom complex, or clinical finding; evaluation and management depend on its cause and severity.',
  ],
  clinical: [
    'is a clinical, diagnostic, therapeutic, or health-care term used to describe an assessment, intervention, measurement, or patient-related concept.',
    'A clinical, diagnostic, therapeutic, or health-care term used to describe an assessment, intervention, measurement, or patient-related concept.',
    'is a clinical, research, or health-care concept used in assessment, measurement, or practice; its meaning depends on context.',
  ],
  medicine: [
    'is a medicine or pharmacologic substance; its indication, dose, and safety depend on the specific clinical context.',
    'A medicinal, pharmacologic, or chemical substance studied or used in health care; its effects and appropriate use depend on the specific agent and clinical context.',
  ],
  biology: [
    'is a biological molecule, chemical substance, cellular component, or physiologic concept involved in body processes, laboratory medicine, or treatment.',
    'A biological molecule, chemical substance, cellular component, or physiologic concept involved in body processes, laboratory medicine, or treatment.',
    'A biological molecule, chemical substance, or physiologic concept involved in body processes, laboratory medicine, or treatment.',
  ],
  anatomy: [
    'An anatomic, physiologic, or clinical term referring to a body structure or function.',
  ],
  organism: [
    'is a microorganism or biological taxon of medical interest; its clinical significance depends on the species, site, and host.',
    'A named microorganism, microbial group, or infectious-disease term used in biomedical classification and clinical discussion.',
  ],
}.freeze

def family_for(description)
  GENERIC.each do |family, phrases|
    return family if phrases.include?(description.strip)
  end
  return :condition if description =~ /is a medical or biomedical term used in clinical practice, research, anatomy, or health care; its interpretation depends on context\.$/
  return :organism if description =~ /is a microorganism or biological taxon of medical interest; its clinical significance depends on the species, site, and host\.$/
  return :condition if description =~ /is a medical condition or clinical entity; assessment and management depend on its cause, severity, and the individual patient\.$/
  return :medicine if description =~ /is a medicine or pharmacologic substance; its indication, dose, and safety depend on the specific clinical context\.$/
  return :clinical if description =~ /is a clinical, research, or health-care concept used in assessment, measurement, or practice; its meaning depends on context\.$/
  return :condition if description =~ /denotes a medical condition or clinical finding whose significance is determined by its defining features, causes, affected system, and patient context\.$/
  return :clinical if description =~ /is a clinical or health-care concept used in assessment, diagnosis, treatment, monitoring, or patient support\.$/
  return :medicine if description =~ /is a pharmacologic or chemical agent identified for study or clinical use; its mechanism, indication, dose, interactions, and adverse effects must be determined for the specific agent\.$/
  return :biology if description =~ /denotes a biological component or molecular process; its role is interpreted through the relevant cells, pathways, tissues, and laboratory findings\.$/
  return :anatomy if description =~ /denotes an anatomical structure or tissue; its clinical importance depends on its location, connections, blood supply, innervation, and function\.$/
  return :organism if description =~ /is a biological taxon or infectious-disease term used in clinical microbiology; interpretation depends on the organism, host, and site involved\.$/
  return :condition if description =~ /denotes a clinical condition or finding; evaluation identifies the underlying mechanism, affected system, severity, complications, and appropriate management\.$/
  return :organism if description =~ /is a microorganism or microbial group; clinical relevance depends on pathogenicity, exposure, site, and antimicrobial susceptibility\.$/
  return :condition if description =~ /denotes a neoplastic condition; evaluation establishes the tissue of origin, extent, biologic behavior, and appropriate treatment\.$/
  return :condition if description =~ /denotes an infectious or toxic clinical condition; diagnosis considers the exposure or pathogen, affected site, severity, and host response\.$/
  return :anatomy if description =~ /denotes an anatomical or physiologic concept used to describe a body structure, process, or function in clinical practice\.$/
  return :organism if description =~ /is a virus or viral group of medical interest; disease risk depends on its strain, route of transmission, host, and tissue tropism\.$/
  return :clinical if description =~ /is a clinical assessment, measurement, or procedure used to investigate, monitor, classify, or treat a health-related finding\.$/
  return :clinical if description =~ /evaluates the body site, analyte, antibody, or physiologic function named in the title; results are interpreted with the method, reference range, and clinical question\.$/
  return :biology if description =~ /denotes a biologic or physiologic concept used in research, laboratory medicine, and the explanation of human disease\.$/
  return :medicine if description =~ /is a defined chemical or biologic substance studied in physiology, pharmacology, laboratory medicine, or treatment\.$/
  nil
end

def definition(term, family)
  name = term.strip
  lower = name.downcase
  if family == :condition
    return definition(term, :medicine) if lower =~ /(nib|tinib|tib|mab|vir|cycline|cillin|caine|olol|pril|sartan|statin|azole|prazole|setron|taxel|parin|lukast|gliptin|gliflozin|dipine|oxetine|azepam|barbital|fibrate|mycin|penem|porin|prost|tide|terone|tropin|relix|platin|mustine|rubicin|xaban|oxacin|fenac|profen)$/
    return definition(term, :biology) if lower =~ /immunoglobulin|antibody|protein|peptide|enzyme|receptor|acid|lipid|molecule|quassin|quercetin|gene|dna|rna|chromos|cell|hormone/
    return definition(term, :anatomy) if lower =~ /^(face|jaw|neck|chest|skull|ear|nose|eye|mouth|tongue|tooth|teeth|hand|foot|leg|arm|hip|knee|back|skin|bone|joint|muscle|nerve|artery|vein|heart|lung|liver|kidney|brain|gland|organ|tissue|membrane|ligament|cartilage)$/
    return definition(term, :clinical) if lower =~ /lift|ectomy|plasty|therapy|surgery|procedure|treatment|test|assay|screen|scan|imaging/
  end
  case family
  when :medicine
    if lower =~ /antibiotic|antiviral|antifungal|antimicrobial/
      "#{name} is an anti-infective agent used against susceptible pathogens associated with #{lower}; indication depends on the organism, site of infection, and resistance pattern."
    elsif lower =~ /vaccine|immuniz/
      "#{name} is an immunizing preparation or immunologic intervention intended to protect against the infectious threat represented by #{lower}."
    elsif lower =~ /acid|salt|oxide|protein|peptide|receptor|enzyme/
      "#{name} is a defined chemical or biologic substance involved in #{lower} and studied in physiology, pharmacology, laboratory medicine, or treatment."
    else
      "#{name} concerns #{lower}, a pharmacologic or chemical agent; clinical use depends on its mechanism, indication, dose, interactions, and adverse effects."
    end
  when :organism
    if lower =~ /virus|viral|coronavirus|retrovirus|herpes|influenza|flavivirus/
      "#{name} is a virus or viral group associated with #{lower}; disease risk depends on strain, transmission route, host, and tissue tropism."
    elsif lower =~ /bacter|coccus|bacillus|myc|fung|yeast|candida|strept|staphyl|yersinia|parasite|protozo/
      "#{name} is a microorganism or microbial group associated with #{lower}; clinical relevance depends on pathogenicity, exposure, site, and antimicrobial susceptibility."
    else
      "#{name} identifies #{lower}, a biological taxon or infectious-disease concept whose clinical importance depends on the organism, host, and site involved."
    end
  when :anatomy
    if lower =~ /arter|vein|vessel|nerve|muscle|bone|joint|gland|organ|cell|tissue|membrane|ligament|cartilage/
      "#{name} denotes #{lower}, an anatomical structure or tissue whose clinical importance depends on location, connections, blood supply, innervation, and function."
    else
      "#{name} refers to #{lower}, an anatomical or physiologic concept used to describe a body structure, process, or function."
    end
  when :biology
    if lower =~ /gene|dna|rna|chromos|mutation|protein|enzyme|receptor|cell|molecule|acid|lipid|hormone/
      "#{name} denotes #{lower}, a biological component or molecular process interpreted through relevant cells, pathways, tissues, and laboratory findings."
    else
      "#{name} concerns #{lower}, a biologic or physiologic concept used in research, laboratory medicine, and the explanation of disease."
    end
  when :clinical
    if lower =~ /test|assay|screen|scale|index|score|questionnaire|measurement|imaging|scan|procedure/
      "#{name} is a clinical assessment, measurement, or procedure used to investigate, monitor, classify, or treat #{lower}."
    else
      "#{name} is used in relation to #{lower} during assessment, diagnosis, treatment, monitoring, or patient support."
    end
  when :condition
    if lower =~ /cancer|carcinoma|sarcoma|tumor|neoplasm|blastoma|lymphoma|leukemia/
      "#{name} denotes a neoplastic condition involving #{lower}; evaluation establishes tissue of origin, extent, biologic behavior, and treatment."
    elsif lower =~ /infection|infectious|fever|sepsis|poisoning|tox|virus|bacter/
      "#{name} denotes an infectious or toxic condition involving #{lower}; diagnosis considers exposure or pathogen, affected site, severity, and host response."
    elsif lower =~ /pain|hemorrhage|bleed|edema|swelling|rash|symptom|disorder|disease|syndrome|deficien|injury|fracture|stenosis|obstruction/
      "#{name} denotes a clinical condition or finding involving #{lower}; evaluation identifies mechanism, affected system, severity, complications, and management."
    else
      "#{name} refers to #{lower}, a medical condition or clinical finding defined by its features, causes, affected system, and patient context."
    end
  end
end

ARGV.each do |path|
  text = File.read(path)
  text = text.gsub(/^(\+?\\medterm\{([^}]*)\})\s*(.*)$/) do
    marker, term, description = Regexp.last_match.captures
    family = family_for(description)
    family ? "#{marker} #{definition(term, family)}" : Regexp.last_match[0]
  end
  File.write(path, text)
end
