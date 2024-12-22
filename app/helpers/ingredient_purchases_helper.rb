module IngredientPurchasesHelper
  def batch_line_item_purchase_options(purchases)
    purchases.map do |purchase|
      ["#{purchase.ingredient.name}, #{purchase.source}, #{purchase.purchased_on}", purchase.id]
    end
  end
end
