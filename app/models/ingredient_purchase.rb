class IngredientPurchase < ApplicationRecord
  belongs_to :ingredient
  has_many :batch_line_items, dependent: :destroy
  has_many :batches, through: :batch_line_items

  validates :purchased_on, :total_quantity_oz, :total_cost, :source, presence: true

  scope :active, -> {where(active: true)}

  def price_per_oz
    return 0.0 if total_cost <= 0

    total_quantity_oz / total_cost
  end
end
