class Batch < ApplicationRecord
  has_many :batch_line_items, dependent: :destroy
  has_many :ingredient_purchases, through: :batch_line_items
  has_many :ingredients, through: :ingredient_purchases

  validates :name, :manufactured_on, presence: true
end
