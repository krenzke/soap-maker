# frozen_string_literal: true

module Ingredients
  class ListIngredients < BaseCommand
    include WithPagination
    include OrderingHelper
    order_with :name, :ingredient_type, default: :name_asc

    def execute
      ingredients = Ingredient.all
      ingredients = ingredients.name_search(params[:name_q]) if params[:name_q].present?
      ingredients = apply_order(ingredients, params[:sort])
      ingredients.page(page).per(per_page)
    end
  end
end
