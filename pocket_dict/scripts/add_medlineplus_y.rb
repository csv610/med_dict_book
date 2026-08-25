#!/usr/bin/env ruby

def normalize(value)
  value.downcase.gsub(/[^a-z0-9]/, '')
end

DEFINITIONS = {
  'Yawning - excessive' => 'Excessive yawning is unusually frequent or difficult-to-control yawning. It may accompany sleep deprivation, excessive daytime sleepiness, medication effects, vasovagal reactions, or less commonly neurologic or cardiopulmonary disease; persistent unexplained episodes merit clinical evaluation.',
  'Yaws' => 'Yaws is a chronic infection caused by Treponema pallidum subsp. pertenue and spread mainly through close skin contact. It can cause an initial papilloma or ulcer and later destructive lesions of skin, bone, and cartilage; antibiotics can cure the infection.',
  'Yellow fever' => 'Yellow fever is an acute mosquito-borne infection caused by yellow fever virus. Fever, headache, muscle aches, nausea, and vomiting may be followed by jaundice, bleeding, shock, and organ failure; vaccination is the main preventive measure.',
  'Yew poisoning' => 'Yew poisoning follows ingestion of yew plant material, especially leaves or seeds containing taxine compounds. Toxicity can cause nausea, abdominal symptoms, dizziness, seizures, dangerous slowing or disruption of the heart rhythm, cardiovascular collapse, and death.',
  'Yoga for health' => 'Yoga for health combines physical postures, breathing exercises, and meditation or relaxation. It may improve flexibility, balance, strength, stress, and some chronic symptoms when adapted to the person; instructors should account for injuries, pregnancy, and medical limitations.',
  'Your baby and the flu' => 'Infants with influenza can develop fever, cough, poor feeding, vomiting, diarrhea, breathing difficulty, or unusual sleepiness. Care focuses on prompt medical advice, hydration, monitoring for respiratory distress, and age-appropriate antiviral treatment when indicated; influenza vaccination is preventive for eligible family members and children.',
  'Your baby in  the birth canal' => 'A baby in the birth canal is progressing through the maternal pelvis during labor. Clinicians assess fetal position, descent, heart rate, and the progress of cervical dilation to identify normal vaginal-birth progress or complications requiring intervention.',
  'Your cancer care team' => 'A cancer care team is the group of oncology professionals who coordinate diagnosis, treatment, symptom control, rehabilitation, psychosocial support, and follow-up. It may include medical, surgical, and radiation oncologists, nurses, pharmacists, social workers, dietitians, and palliative-care specialists.',
  'Your cancer diagnosis - Do you need a second opinion?' => 'A second opinion after a cancer diagnosis is an independent review of pathology, imaging, staging, and treatment options by another qualified clinician or cancer center. It can confirm the diagnosis, identify alternatives, and help the patient make an informed treatment decision without usually delaying urgent care.',
  'Your cancer survivorship care plan' => 'A cancer survivorship care plan summarizes completed treatment, possible late effects, recommended surveillance, preventive care, rehabilitation, and communication between oncology and primary-care clinicians. It is updated as health needs change after active treatment.',
  'Your child and the flu' => 'Children with influenza may have fever, cough, sore throat, fatigue, headache, muscle aches, vomiting, or diarrhea. Supportive care includes fluids and symptom monitoring; urgent assessment is needed for breathing difficulty, dehydration, confusion, severe weakness, or worsening after improvement.',
  'Your child\'s first vaccines - what you need to know' => 'A child\'s first vaccines stimulate protection against serious infections according to the recommended immunization schedule. Clinicians review timing, contraindications, expected local or systemic reactions, catch-up options, and when urgent care is needed for a severe reaction.',
  'Your diet after gastric bypass surgery' => 'Diet after gastric bypass surgery progresses from liquids to pureed, soft, and regular-textured foods in small portions as healing permits. Long-term care emphasizes protein, fluids separated from meals, vitamin and mineral supplements, avoidance of dumping-triggering foods, and monitoring for nutritional deficiencies.'
}.freeze

input = ARGV.fetch(0)
output = ARGV.fetch(1)
text = File.read(output)
existing_titles = text.scan(/^\\medterm\{([^}]*)\}/).flatten
existing_by_normalized = existing_titles.to_h { |title| [normalize(title), title] }
terms = File.readlines(input, chomp: true).reject(&:empty?)
additions = []

terms.each do |term|
  definition = DEFINITIONS.fetch(term.strip)
  actual_title = existing_by_normalized[normalize(term.strip)]
  if actual_title
    escaped_title = Regexp.escape(actual_title)
    pattern = /^\\medterm\{#{escaped_title}\}.*?(?=\n\n\\textbf\{Synonyms\}:)/m
    replacement = "\\medterm{#{actual_title}} #{definition}"
    text.sub!(pattern, replacement)
  else
    additions << term.strip
  end
end

File.write(output, text)
File.open(output, 'a') do |file|
  additions.each do |term|
    file.puts
    file.puts "\\medterm{#{term}} #{DEFINITIONS.fetch(term)}"
    file.puts
    file.puts '\\textbf{Synonyms}:'
  end
end
puts "added #{additions.length} terms"
