class LabelsController < ApplicationController
  layout 'label_print', only: [:show]

  def index
    @title = 'Dummy Title'
    @ingredient_line_items = [LabelLineItem.new(name: 'Ingredient 1', description: 'Description 1')]
  end

  def show
    @title = params[:title]
    @num_labels = 6
    @ingredient_line_items = (params[:line_items]&.values || []).map do |li|
      LabelLineItem.new(name: li[:name], description: li[:description])
    end
  end
end
