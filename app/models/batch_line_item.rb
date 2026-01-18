class BatchLineItem < ApplicationRecord
  belongs_to :batch
  belongs_to :ingredient

  validates :quantity_in_grams, :cost_per_gram, presence: true

  scope :in_order, -> { order(seq: :asc) }

  def self.of_type(types)
    joins(:ingredient).where({ingredients: {ingredient_type: types}})
  end

  def cost
    quantity_in_grams * cost_per_gram
  end
end
