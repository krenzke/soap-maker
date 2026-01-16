class Ingredient < ApplicationRecord
  TYPES = {
    'oil' => 'Oil',
    'lye' => 'Lye',
    'water' => 'Water',
    'scent' => 'Scent',
    'colorant' => 'Colorant',
    'exfoliant' => 'Exfoliant',
    'other' => 'Other',
  }.freeze

  validates :name, presence: true, uniqueness: true
  validates :ingredient_type, inclusion: { in: TYPES }
  validates :unit, inclusion: { in: Units::valid_db_types }, allow_blank: true

  def pretty_ingredient_type
    TYPES[ingredient_type]
  end
end
