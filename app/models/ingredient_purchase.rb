class IngredientPurchase < ApplicationRecord
  belongs_to :ingredient
  has_many :batch_line_items, dependent: :destroy
  has_many :batches, through: :batch_line_items

  validates :purchased_on, :total_quantity_oz, :total_cost, :source, presence: true

  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  def self.with_amount_used
    items_table = BatchLineItem.arel_table
    purchases_table = IngredientPurchase.arel_table
    select([
      purchases_table[Arel.star],
      Arel::Nodes::NamedFunction.new(
        'coalesce',
        [BatchLineItem.arel_table[:quantity_oz].sum, 0]
      ).as('amount_used')
    ]).group(purchases_table[:id]).left_outer_joins(:batch_line_items)
  end

  def price_per_oz
    return 0.0 if total_cost <= 0

    total_quantity_oz / total_cost
  end
end
