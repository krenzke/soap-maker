[
  'NaOH',
  'Sodium Lactate',
  'Orange 10x essential oil',
  'Shea Butter',
  'Eucalyptus Essential Oil',
  'Titanium Dioxide',
  'Green Chrome oxide pigment',
  'Coconut Oil',
  'Olive Oil',
  'Distilled Water',
].each do |name|
  Ingredient.create!(name: name) unless Ingredient.exists?(name: name)
end