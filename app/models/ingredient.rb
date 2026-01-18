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

  has_many :batch_line_items
  has_many :batches, through: :batch_line_items
  before_destroy :check_for_line_items

  def self.of_type(types)
    where(ingredient_type: types)
  end

  def self.name_search(q)
    where('ingredients.name ILIKE :q', q: "%#{q}%")
  end

  def pretty_ingredient_type
    TYPES[ingredient_type]
  end

  protected

  def check_for_line_items
    if batch_line_items.exists?
      errors.add(:base, "Cannot delete ingredient that is in use")
      throw :abort
    end
  end
end
