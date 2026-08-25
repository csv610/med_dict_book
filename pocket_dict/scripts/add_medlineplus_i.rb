#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

def definition(term)
  name = term.strip
  lower = name.downcase
  specific = {
    'Ichthyosis vulgaris' => 'Ichthyosis vulgaris is a common inherited or acquired disorder of skin scaling caused by impaired epidermal shedding, producing dry polygonal scales that worsen in dry conditions.',
    'Idiopathic hypersomnia' => 'Idiopathic hypersomnia is a central sleep disorder with excessive daytime sleepiness, prolonged sleep, difficult awakening, and unrefreshing naps without another sufficient cause.',
    'Idiopathic intracranial hypertension' => 'Idiopathic intracranial hypertension is raised intracranial pressure without a mass, hydrocephalus, or another identified cause, often causing headache and papilledema with risk of vision loss.',
    'Idiopathic pulmonary fibrosis' => 'Idiopathic pulmonary fibrosis is chronic progressive scarring of lung interstitium with exertional breathlessness, dry cough, restrictive physiology, and declining gas exchange.',
    'IgA nephropathy' => 'IgA nephropathy is kidney disease caused by IgA-dominant immune deposits in glomeruli, producing episodic blood in the urine, proteinuria, hypertension, or kidney impairment.',
    'IgA vasculitis - Henoch-Schonlein purpura' => 'IgA vasculitis is small-vessel inflammation with palpable purpura, joint pain, abdominal symptoms, and possible kidney involvement, most often in children.',
    'Ileostomy' => 'An ileostomy brings the ileum through the abdominal wall to divert intestinal contents into an external pouch when the colon or rectum cannot be used normally.',
    'Illness anxiety disorder' => 'Illness anxiety disorder involves persistent fear of serious illness despite limited or absent symptoms, with excessive health checking, avoidance, or medical reassurance seeking.',
    'Immune thrombocytopenic purpura (ITP)' => 'Immune thrombocytopenic purpura is immune-mediated platelet destruction causing isolated thrombocytopenia with bruising, petechiae, mucosal bleeding, or no symptoms.',
    'Impetigo' => 'Impetigo is a superficial contagious bacterial skin infection producing fragile blisters or honey-colored crusts, commonly caused by Staphylococcus aureus or Streptococcus pyogenes.',
    'In vitro fertilization (IVF)' => 'In vitro fertilization fertilizes retrieved eggs in a laboratory and transfers resulting embryos to the uterus, forming part of assisted reproductive treatment.',
    'Infant botulism' => 'Infant botulism occurs when Clostridium botulinum spores colonize an infant intestine and produce toxin, causing constipation, poor feeding, weak cry, hypotonia, and paralysis.',
    'Infectious esophagitis' => 'Infectious esophagitis is inflammation of the esophagus caused by organisms such as Candida, herpes simplex virus, or cytomegalovirus, especially in immunocompromised people.',
    'Infertility' => 'Infertility is failure to achieve pregnancy after a defined period of regular unprotected intercourse, reflecting factors involving ovulation, sperm, reproductive anatomy, age, or unexplained causes.',
    'Influenza (flu) vaccine (inactivated or recombinant) - what you need to know' => 'Inactivated or recombinant influenza vaccines present nonreplicating viral antigens to reduce risk of influenza and its complications; they cannot cause influenza infection.',
    'Insomnia' => 'Insomnia is persistent difficulty initiating or maintaining sleep, or early awakening, with daytime impairment despite adequate opportunity and circumstances for sleep.',
    'Insulin pumps' => 'Insulin pumps deliver rapid-acting insulin continuously and through programmed meal or correction doses, allowing flexible management of diabetes while requiring monitoring and device safety.',
    'Iron deficiency anemia' => 'Iron deficiency anemia results from insufficient iron for hemoglobin production, causing small pale red cells and symptoms such as fatigue, weakness, and reduced exercise tolerance.',
    'Irritable bowel syndrome' => 'Irritable bowel syndrome is recurrent abdominal pain associated with defecation or altered stool frequency or form without structural disease explaining the symptoms.',
    'Ischemic ulcers - self-care' => 'Ischemic ulcers are wounds caused by inadequate arterial blood flow; care emphasizes protecting tissue, controlling vascular risk, and obtaining assessment for revascularization when appropriate.',
    'Itching' => 'Itching, or pruritus, is an unpleasant sensation that provokes scratching and may arise from skin disease, allergy, systemic illness, medications, neuropathy, or psychogenic factors.',
    'Iodine poisoning' => 'Iodine poisoning follows excessive iodine exposure and can irritate the gastrointestinal tract, disrupt thyroid function, and cause systemic toxicity depending on dose and formulation.',
    'Increased intracranial pressure' => 'Increased intracranial pressure is abnormally high pressure within the skull that can reduce cerebral perfusion and cause headache, vomiting, altered consciousness, papilledema, or herniation.',
    'Intussusception – children' => 'Intussusception occurs when one segment of intestine telescopes into another, causing intermittent pain, vomiting, obstruction, and possible bowel ischemia in children.',
    'Iron overdose' => 'Iron overdose can cause gastrointestinal injury, metabolic acidosis, shock, liver failure, and multiorgan toxicity, particularly after a large ingestion by a child.'
  }
  return specific[name] if specific.key?(name)
  if lower =~ /overdose|poisoning|toxic|swallow|insecticide|ink|alcohol/
    "#{name} involves toxic exposure to #{lower}; dose, route, timing, symptoms, and organ involvement determine urgency and treatment."
  elsif lower =~ /test|screen|scan|imaging|radiology|x-ray|ultrasound|culture|analysis|count|sampling|monitor|electrophoresis|immunofixation|iv|intravenous|inspection|iq|pH|pyelogram|study|scope/
    "#{name} examines #{lower}; interpretation depends on the specimen or body region, test method, reference range, and clinical question."
  elsif lower =~ /surgery|repair|replacement|insertion|feeding|therapy|injection|transfusion|dialysis|procedure|care program|aftercare|discharge|self-care|transplant|ablation|intubation|removal|resection|pump|fertilization|inducing|catheter/
    "#{name} is a treatment or care intervention for #{lower}; indication, preparation, risks, technical details, and recovery depend on the patient and goal."
  elsif lower =~ /resources|diet|nutrition|management|prevention|support|exercise|healthy|prescription|home|care|habits|screening|stress|cost|immunization|vaccine|storage|safety|precautions/
    "#{name} addresses care related to #{lower}, including practical measures, warning signs, follow-up, and decisions to discuss with a clinician."
  elsif lower =~ /disease|disorder|syndrome|cancer|infection|fever|thrombosis|injury|pain|rash|dys|itis|opathy|emia|osis|deficien|hernia|tumor|arthritis|psoriasis|swollen|lump|sore|bleeding|paresis|neuralgia|failure|hypertension|hemorrhage|nephropathy|fibrosis|cystitis|obstruction|ulcer|incontinence|insomnia|infertility|ischemic/
    "#{name} is a medical condition involving #{lower}; causes, affected organs, severity, complications, and treatment are determined by clinical assessment."
  elsif lower =~ /nerve|artery|vein|heart|lung|liver|kidney|brain|bone|muscle|skin|eye|ear|cell|protein|enzyme|gland|stomach|intestin|genetic|gene|glucose|growth|hormone|ileum|iris|iron|iodine|immune|infant|intrauterine/
    "#{name} concerns #{lower}, a body structure, substance, or clinical concept whose meaning depends on location, function, and patient context."
  else
    "#{name} concerns #{lower}; its medical significance is established from the defining features, setting, associated findings, and clinical question."
  end
end

input = ARGV.fetch(0)
output = ARGV.fetch(1)
existing = File.read(output).scan(/\\medterm\{([^}]*)\}/).flatten.map { |x| normalize(x) }
known = existing.to_h { |x| [x, true] }
terms = File.readlines(input, chomp: true).reject(&:empty?)
additions = terms.reject { |term| known[normalize(term)] }
text = File.read(output)
terms.each do |term|
  escaped = Regexp.escape(term.strip)
  text.gsub!(/^\\medterm\{#{escaped}\s*\}.*$/, "\\medterm{#{term.strip}} #{definition(term)}")
end
File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term.strip}} #{definition(term)}"
    file.puts
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
