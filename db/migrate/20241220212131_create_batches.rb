class CreateBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :batches do |t|
      t.string :name, null: false
      t.date :manufactured_on
      t.decimal :units_produced

      t.timestamps
    end
  end
end
