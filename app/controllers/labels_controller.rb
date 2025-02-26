class LabelsController < ApplicationController
  layout 'label_print', only: [:show]

  def index
    @batch = Batch.find_by(id: params[:batch_id])
    @num_labels = 4

    if @batch
      @title = @batch.name
      @ingredient_line_items = @batch.batch_line_items.includes(ingredient_purchase: :ingredient).map do |li|
        ingredient = li.ingredient_purchase.ingredient
        LabelLineItem.new(name: ingredient.label_name.presence || ingredient.name, description: ingredient.label_description)
      end
    else
      @title = 'My Soap'
      @ingredient_line_items = [
        LabelLineItem.new(name: 'Ingredient 1', description: 'Description 1'),
      ]
    end
  end

  def show
    @title = params[:title]
    @num_labels = params[:num_labels].to_i > 0 ? params[:num_labels].to_i : 6
    @ingredient_line_items = (params[:line_items]&.values || []).map do |li|
      LabelLineItem.new(name: li[:name], description: li[:description])
    end.sort_by(&:seq)
  end
end
