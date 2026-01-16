class CreateBatchLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :batch_line_items do |t|
      t.references :ingredient, foreign_key: true
      t.references :batch, foreign_key: true
      t.decimal :quantity, null: false
      t.decimal :cost_per_unit, null: false
      t.string :quantity_unit, null: false
      t.integer :seq

      t.timestamps
    end
  end
end
