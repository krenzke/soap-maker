class Batch < ApplicationRecord
  has_many :batch_line_items, dependent: :destroy
  has_many :ingredient_purchases, through: :batch_line_items
  has_many :ingredients, through: :ingredient_purchases
  has_many_attached :images

  validates :images, attachment: { image: true, max_size: 10.megabyte }
  validates :name, :manufactured_on, presence: true

  accepts_nested_attributes_for :batch_line_items, allow_destroy: true

  def total_cost
    batch_line_items.map(&:cost).sum
  end

  def cost_per_unit
    return 0.0 unless units_produced.present? && units_produced > 0
    total_cost / units_produced
  end
end
