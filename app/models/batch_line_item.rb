class BatchLineItem < ApplicationRecord
  belongs_to :batch
  belongs_to :ingredient

  validates :quantity, :quantity_unit, :cost_per_unit, presence: true

  scope :in_order, -> { order(seq: :asc) }

  def self.of_type(types)
    joins(:ingredient).where({ingredients: {ingredient_type: types}})
  end

  def cost
    quantity * cost_per_unit
  end
end
