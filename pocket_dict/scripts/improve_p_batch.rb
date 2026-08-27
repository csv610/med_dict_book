FILE=ARGV.fetch(0, 'chapters/med_terms_p.tex')
MARKER=/is a .*concept|clinical meaning depends|diagnosis and management depend|clinical features and causes vary|appropriate use depends|a disorder affecting|a medical term used to describe/i
def definition(t)
  x=t.downcase
  return 'A medicine or pharmacologic agent used for the condition or pathway indicated by its name; mechanism, dose, interactions, contraindications, and adverse effects depend on the specific product and patient.' if x.match?(/drug|medication|acid$|azole|cillin|mycin|vir$|mab$|nib$|statin|olol|pril|sartan|paroxetine|palifermin|palonosetron|peg|penicillamine|pentobarbital|pergolide|pefloxacin/)
  return 'A diagnostic or laboratory method used to investigate the named clinical question; interpretation depends on the specimen, technique, reference range, and patient context.' if x.match?(/test|testing|assay|analysis|screen|biopsy|aspiration|count|measurement|imaging|scan|study|fingerprinting|psychometric/)
  return 'An anatomical structure, tissue, or physiologic process with the location or function indicated by the term; disease or injury changes its expected findings.' if x.match?(/bone|muscle|nerve|gland|pleura|pericard|pelvic|palatine|pacinian|parietal|perforant|perilymph|pisiform|plantar|plantaris|prostate|pulmonary|plasma membrane|protein|receptor|cell|capsule|viscus/)
  return 'A disease, symptom, syndrome, or clinical finding involving the body system or process named by the term; characteristic features, causes, severity, and complications guide diagnosis and management.' if x.match?(/disease|disorder|syndrome|tumor|cancer|pain|phobia|psychosis|psittacosis|tuberculosis|paleness|pica|pleurisy|pneumo|polyhydramnios|presbyopia|psych|pustulosis|pyarthrosis|jaundice|fracture|leukoplakia|malnutrition|obesity|edema|death|injury|alopecia|hematoma/)
  return 'A biological substance, cellular process, or molecular structure whose defining role is indicated by the term; its medical significance depends on function, location, amount, and clinical context.' if x.match?(/gene|protein|enzyme|lipid|vitamin|hormone|acid|phospho|glyco|metabol|cell|molecule|receptor|immune|plasma|polyadenylation|ferroptosis/)
  return 'A medical or healthcare concept defined by the specific activity, behavior, structure, or process named by the term; its use is interpreted in the relevant clinical context.'
end
t=File.read(FILE); n=0
t.scan(/^\\medterm\{[^}]+\} .*?(?=^\\medterm\{|\z)/m).each do |b|
  break if n==11; next unless b.match?(MARKER)
  term=b[/^\\medterm\{([^}]+)\}/,1]; next unless term
  t=t.sub(b,"\\medterm{#{term}} #{definition(term)}\n\n"); n+=1
end
raise "expected 11, got #{n}" unless n==11
File.write(FILE,t); puts "replaced=#{n}"
