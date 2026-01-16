class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :ingredient_type, null: false
      t.decimal :default_cost_per_unit
      t.string :unit

      t.timestamps
    end
  end
end
