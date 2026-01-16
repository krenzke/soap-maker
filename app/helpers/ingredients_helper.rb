module IngredientsHelper
  def ingredient_type_select_options
    Ingredient::TYPES.to_a.map(&:reverse).sort_by(&:first)
  end

  def ingredient_select_options
    all_ingredients = Ingredient.order(name: :asc).to_a

    [
      ['oil', 'Oil'],
      ['lye', 'Lye'],
      ['water', 'Water'],
      ['scent', 'Scent'],
      ['colorant', 'Colorant'],
      ['exfoliant', 'Exfoliant'],
      ['other', 'Other']
    ].map do |g|
      db_type_name = g[0]
      pretty_type_name = g[1]

      [
        pretty_type_name,
        all_ingredients.filter{|i| i.ingredient_type == db_type_name }.map{|i| [i.name, i.id]}
      ]
    end
  end

  def grouped_ingredient_select_options
    all_ingredients = Ingredient.order(name: :asc).to_a

    # safe_join([
    #   tag.option('first',value: 'first', data:{foo:'bar'}),
    #   tag.option('first',value: 'first')
    # ])

    optgroups = [
      ['oil', 'Oil'],
      ['lye', 'Lye'],
      ['water', 'Water'],
      ['scent', 'Scent'],
      ['colorant', 'Colorant'],
      ['exfoliant', 'Exfoliant'],
      ['other', 'Other']
    ].map do |g|
      db_type_name = g[0]
      pretty_type_name = g[1]

      tag.optgroup(label: pretty_type_name) do
        options = all_ingredients
          .filter{|i| i.ingredient_type == db_type_name }
          .map{|i| tag.option(i.name, value: i.id, data: {
            'default-cost-per-unit': i.default_cost_per_unit&.round(2),
            'default-unit': i.unit || 'oz'
            })}
        safe_join(options)
      end
    end

    safe_join(optgroups)
  end
end
