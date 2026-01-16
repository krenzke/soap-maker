class PagesController < ApplicationController
  def index
    @recent_batches = Batch.order(manufactured_on: :desc).includes(batch_line_items: { :ingredient }).limit(10)
  end
end
