class BatchesController < ApplicationController
  before_action :set_batch, only: %i[ show edit update destroy ]

  # GET /batches
  def index
    @batches = Batch.order(manufactured_on: :desc).page(params[:page])
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
    # @batch.preload(batch_line_items: {})
    ActiveRecord::Associations::Preloader.new(records: [@batch], associations: [{batch_line_items: :ingredient}]).call
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
      redirect_to edit_batch_path(@batch), notice: "Batch was successfully updated.", status: :see_other
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
      params.require(:batch).permit(:manufactured_on, :name, :units_produced, :notes,
        batch_line_items_attributes: [:id, :_destroy, :ingredient_id, :quantity, :quantity_unit, :cost_per_unit, :seq],
        images: [])
    end
end
