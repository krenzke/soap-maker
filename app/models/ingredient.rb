class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :ingredient_purchases, dependent: :destroy
end
