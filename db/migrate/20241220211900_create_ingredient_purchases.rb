class CreateIngredientPurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredient_purchases do |t|
      t.references :ingredient, foreign_key: true
      t.date :purchased_on, null: false
      t.decimal :total_quantity_oz, null: false
      t.decimal :total_cost, null: false
      t.string :source, null: false

      t.timestamps
    end
  end
end
