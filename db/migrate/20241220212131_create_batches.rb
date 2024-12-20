class CreateBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :batches do |t|
      t.date :manufactured_on, null: false
      t.string :name, null: false
      t.decimal :units_produced

      t.timestamps
    end
  end
end
