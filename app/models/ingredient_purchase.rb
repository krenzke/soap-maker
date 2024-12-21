class IngredientPurchase < ApplicationRecord
  belongs_to :ingredient
  has_many :batch_line_items, dependent: :destroy
  has_many :batches, through: :batch_line_items

  validates :purchased_on, :total_quantity_oz, :total_cost, :source, presence: true
end
