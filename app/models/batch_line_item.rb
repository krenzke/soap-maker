class BatchLineItem < ApplicationRecord
  belongs_to :batch
  belongs_to :ingredient_purchase

  validates :quantity_oz, presence: true

  scope :in_order, -> { order(seq: :asc) }
end
