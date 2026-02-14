class AddMoldToBatches < ActiveRecord::Migration[7.2]
  def change
    add_column :batches, :mold, :string
  end
end
