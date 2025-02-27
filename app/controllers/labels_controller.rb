class LabelsController < ApplicationController
  layout 'label_print', only: [:show]

  def index
    @batch = Batch.find_by(id: params[:batch_id])
    @num_labels = 4

    if @batch
      @label = Label.from_batch(@batch)
    else
      @label = Label.new(
        title: 'My Soap',
        batch_number: '',
        line_items: [LabelLineItem.new(name: 'Olive Oil', description: 'Moisturize')]
      )
    end
  end

  def show
    @num_labels = params[:num_labels].to_i > 0 ? params[:num_labels].to_i : 6

    line_items = (params[:line_items]&.values || []).map do |li|
      LabelLineItem.new(name: li[:name], description: li[:description])
    end.sort_by(&:seq)

    @label = Label.new(
      title: params[:title],
      batch_number: params[:batch_number],
      line_items: line_items
    )
  end
end
