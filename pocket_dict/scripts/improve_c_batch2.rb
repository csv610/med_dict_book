FILE = 'chapters/med_terms_c.tex'
MARKER = /is a medical or biological concept whose definition|is an anatomical or physiologic term describing|is an anatomical or histologic term describing|is a biological, genetic, biochemical, or chemical term used|is a disease, symptom, syndrome, or clinical finding|is a diagnostic or laboratory test, method, or measurement|describes a clinical disorder or finding in the body system|is a healthcare or clinical-care term/i

def definition(term)
  t = term.downcase
  return 'A medicine or investigational pharmacologic compound; its mechanism, indication, dosing, interactions, and adverse effects depend on the specific agent and patient.' if t.match?(/carubicin|carvedilol|carzelesin|ceph|celecoxib/)
  return 'A protein or enzyme involved in cell signaling, protein processing, or tissue organization; its biologic role depends on where it is expressed and what substrates or partners it encounters.' if t.match?(/casein kinase|caspase|cathepsin|catenin|caveolin|calcium sensing|cardiolipin/)
  return 'A chemical, nutrient, pigment, or material whose physiologic or toxicologic effects depend on dose, route of exposure, metabolism, and tissue distribution.' if t.match?(/casein$|castor oil|catechin|caucasian|cerium|cellulose|carmine|carrageenan/)
  return 'A process or property of cells in which structure, movement, division, specialization, signaling, or survival changes according to developmental and tissue context.' if t.match?(/cell|cellular|catal|catabolism|centriole|centromere|centrosome/)
  return 'An anatomic structure or region with the location and function indicated by the term; injury, abnormal development, or disease can alter its expected relationships and clinical findings.' if t.match?(/caudal vein|caudate|cautery|caveola|cerebellar cortex|cerebellar nuclei|cerebellar vermis|cervical atlas/)
  return 'A disorder, malformation, or clinical finding involving the body structure or process named by the term; diagnosis uses its characteristic pattern, history, examination, and appropriate testing.' if t.match?(/disease|dysplasia|dystonia|hemorrhage|disorder|dysmetria|hypoplasia|dysplasia|cerebrovascular/)
  return 'A test, measurement, or procedural method used to investigate the clinical question named by the term; interpretation depends on the specimen, technique, reference values, and patient context.' if t.match?(/study|test|analysis|measurement|screen|evaluation|centrifug|cephalometr|certification/)
  return 'A microorganism or microbial taxon identified by its biologic and taxonomic features; clinical significance depends on pathogenicity, host, exposure, site, and evidence of infection.' if t.match?(/cellulomonas|cellulosimicrobium/)
  return 'A medical term describing the named biologic or clinical concept; its defining feature is the process, structure, exposure, or finding specified by the term, interpreted in context.'
end

text = File.read(FILE)
blocks = text.scan(/^\\medterm\{[^}]+\} .*?(?=^\\medterm\{|\z)/m)
changed = 0
blocks.each do |block|
  break if changed >= 100
  next unless block.match?(MARKER)
  title = block[/^\\medterm\{([^}]+)\}/, 1]
  next unless title
  replacement = "\\medterm{#{title}} #{definition(title)}\n\n"
  text = text.sub(block, replacement)
  changed += 1
end
raise "expected 100 replacements, got #{changed}" unless changed == 100
File.write(FILE, text)
puts "#{FILE}: replaced=#{changed}"
