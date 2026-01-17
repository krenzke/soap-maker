class Batch < ApplicationRecord
  has_many :batch_line_items, ->  { order(seq: :asc) }, dependent: :destroy
  has_many :ingredients, through: :batch_line_items
  has_many_attached :images
  has_rich_text :notes

  validates :images, attachment: { image: true, max_size: 10.megabyte }
  validates :name, presence: true

  accepts_nested_attributes_for :batch_line_items, allow_destroy: true

  def total_cost
    batch_line_items.map(&:cost).sum
  end

  def cost_per_unit
    return 0.0 unless units_produced.present? && units_produced > 0
    total_cost / units_produced
  end
end
