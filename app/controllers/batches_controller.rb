class BatchesController < ApplicationController
  before_action :set_batch, only: %i[ show edit update destroy ]

  # GET /batches
  def index
    @batches = Batch.all
  end

  # GET /batches/1
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new(manufactured_on: Date.today)
    @batch.batch_line_items.build
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches
  def create
    @batch = Batch.new(batch_params)

    if @batch.save
      redirect_to @batch, notice: "Batch was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /batches/1
  def update
    if @batch.update(batch_params)
      redirect_to @batch, notice: "Batch was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /batches/1
  def destroy
    @batch.destroy!
    redirect_to batches_url, notice: "Batch was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:manufactured_on, :name, :units_produced,
        batch_line_items_attributes: [:ingredient_purchase_id, :quantity_oz, :seq])
    end
end
