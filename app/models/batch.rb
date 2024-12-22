class Batch < ApplicationRecord
  has_many :batch_line_items, dependent: :destroy
  has_many :ingredient_purchases, through: :batch_line_items
  has_many :ingredients, through: :ingredient_purchases

  validates :name, :manufactured_on, presence: true

  accepts_nested_attributes_for :batch_line_items, allow_destroy: true
end
