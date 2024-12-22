class PagesController < ApplicationController
  def index
    @recent_batches = Batch.order(manufactured_on: :desc).includes(batch_line_items: { ingredient_purchase: :ingredient }).limit(10)
    @recent_purchases = IngredientPurchase.order(purchased_on: :desc).includes(:ingredient).limit(10)
  end
end
