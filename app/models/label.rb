class Label
  attr_accessor :title, :batch_number, :line_items

  def self.from_batch(batch)
    line_items = batch.batch_line_items.includes(ingredient_purchase: :ingredient).map do |li|
      ingredient = li.ingredient_purchase.ingredient
      LabelLineItem.new(name: ingredient.label_name.presence || ingredient.name, description: ingredient.label_description)
    end

    new(
      title: batch.name,
      batch_number: batch.id.to_s.rjust(3,'0'),
      line_items: line_items
    )
  end

  def initialize(title: '', batch_number: '', line_items: [])
    @title = title
    @batch_number = batch_number
    @line_items = line_items
  end
end