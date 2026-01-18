# frozen_string_literal: true

module Batches
  class ListBatches < BaseCommand
    include WithPagination
    include OrderingHelper
    order_with :name, :manufactured_on, default: :manufactured_on_desc

    def execute
      batches = Batch.includes(batch_line_items: :ingredient)
      batches = batches.name_search(params[:name_q]) if params[:name_q].present?
      batches = apply_order(batches, params[:sort])
      batches.page(page).per(per_page)
    end
  end
end
