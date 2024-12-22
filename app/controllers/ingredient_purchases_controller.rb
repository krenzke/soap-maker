class IngredientPurchasesController < ApplicationController
  before_action :set_ingredient_purchase, only: %i[ show edit update destroy ]

  # GET /ingredient_purchases
  def index
    @ingredient_purchases = IngredientPurchase.includes(:ingredient, :batch_line_items).with_amount_used.order(purchased_on: :desc)
  end

  # GET /ingredient_purchases/1
  def show
  end

  # GET /ingredient_purchases/new
  def new
    @ingredient_purchase = IngredientPurchase.new(purchased_on: Date.today)
  end

  # GET /ingredient_purchases/1/edit
  def edit
  end

  # POST /ingredient_purchases
  def create
    @ingredient_purchase = IngredientPurchase.new(ingredient_purchase_params)

    if @ingredient_purchase.save
      url = params[:make_another].present? ? new_ingredient_purchase_path : ingredient_purchases_path
      redirect_to url, notice: "Ingredient purchase was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ingredient_purchases/1
  def update
    if @ingredient_purchase.update(ingredient_purchase_params)
      url = params[:back_to] == 'index' ? ingredient_purchases_path : edit_ingredient_purchase_path(@ingredient_purchase)
      redirect_to url, notice: "Ingredient purchase was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /ingredient_purchases/1
  def destroy
    @ingredient_purchase.destroy!
    redirect_to ingredient_purchases_url, notice: "Ingredient purchase was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_purchase
      @ingredient_purchase = IngredientPurchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ingredient_purchase_params
      params.require(:ingredient_purchase).permit(:ingredient_id, :purchased_on, :total_quantity_oz, :total_cost, :source, :active)
    end
end
