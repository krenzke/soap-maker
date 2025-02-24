[
  ['Lye','',''],
  ['Sodium Lactate','',''],
  ['Distilled Water','',''],
  ['Orange 10x Essential Oil','Orange Oil','Fragrance'],
  ['Eucalyptus Essential Oil','Eucalyptus Oil','Fragrance'],
  ['Lemongrass Essential Oil','Lemongrass Oil','Fragrance'],
  ['Lavender Essential Oil','Lavender Oil','Fragrance'],
  ['Grapefruit Essential Oil','Grapefruit Oil','Fragrance'],
  ['Titanium Dioxide','Titanium Dioxide','Mineral Colorant'],
  ['Green Chrome Oxide Pigment','Green Chrome Oxide','Mineral Colorant'],
  ['Lavender Mica','Lavender Mica','Mineral Colorant'],
  ['Cappucino Mica','Cappucino Mica','Mineral Colorant'],
  ['Merlot Sparkle Mica','Merlot Sparkle Mica','Mineral Colorant'],
  ['Coconut Oil','Coconut Oil','Lather'],
  ['Canola Oil','Canola Oil','Moisturize'],
  ['Cocoa Butter','Cocoa Butter','Hardness'],
  ['Sweet Almond Oil','Sweet Almond Oil','Conditioning'],
  ['Rice Bran Oil','Rice Bran Oil','Lather'],
  ['Olive Oil','Olive Oil','Moisturize'],
  ['Shea Butter','Shea Butter','Moisturize'],
].each do |e|
  Ingredient.create!(name: e[0], label_name: e[1], label_description: e[2]) unless Ingredient.exists?(name: e[0])
end