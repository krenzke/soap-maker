class CreateBatchLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :batch_line_items do |t|
      t.references :ingredient_purchase, foreign_key: true
      t.references :batch, foreign_key: true
      t.decimal :quantity_oz, null: false
      t.integer :seq

      t.timestamps
    end
  end
end
