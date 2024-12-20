class BatchLineItemsController < ApplicationController
  before_action :set_batch_line_item, only: %i[ show edit update destroy ]

  # GET /batch_line_items
  def index
    @batch_line_items = BatchLineItem.all
  end

  # GET /batch_line_items/1
  def show
  end

  # GET /batch_line_items/new
  def new
    @batch_line_item = BatchLineItem.new
  end

  # GET /batch_line_items/1/edit
  def edit
  end

  # POST /batch_line_items
  def create
    @batch_line_item = BatchLineItem.new(batch_line_item_params)

    if @batch_line_item.save
      redirect_to @batch_line_item, notice: "Batch line item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /batch_line_items/1
  def update
    if @batch_line_item.update(batch_line_item_params)
      redirect_to @batch_line_item, notice: "Batch line item was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /batch_line_items/1
  def destroy
    @batch_line_item.destroy!
    redirect_to batch_line_items_url, notice: "Batch line item was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch_line_item
      @batch_line_item = BatchLineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_line_item_params
      params.require(:batch_line_item).permit(:quantity_oz)
    end
end
