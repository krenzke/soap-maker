class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :label_name
      t.string :label_description

      t.timestamps
    end
  end
end
