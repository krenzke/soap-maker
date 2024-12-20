class IngredientPurchasesController < ApplicationController
  before_action :set_ingredient_purchase, only: %i[ show edit update destroy ]

  # GET /ingredient_purchases
  def index
    @ingredient_purchases = IngredientPurchase.all
  end

  # GET /ingredient_purchases/1
  def show
  end

  # GET /ingredient_purchases/new
  def new
    @ingredient_purchase = IngredientPurchase.new
  end

  # GET /ingredient_purchases/1/edit
  def edit
  end

  # POST /ingredient_purchases
  def create
    @ingredient_purchase = IngredientPurchase.new(ingredient_purchase_params)

    if @ingredient_purchase.save
      redirect_to @ingredient_purchase, notice: "Ingredient purchase was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ingredient_purchases/1
  def update
    if @ingredient_purchase.update(ingredient_purchase_params)
      redirect_to @ingredient_purchase, notice: "Ingredient purchase was successfully updated.", status: :see_other
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
      params.require(:ingredient_purchase).permit(:purchased_on, :total_quantity_oz, :total_cost, :source)
    end
end
