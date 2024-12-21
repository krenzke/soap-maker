Fabricator(:ingredient_purchase) do
  ingredient
  source { ['Whole Foods', 'Smart and Final'].sample }
  purchased_on { rand(100).days.ago }
  total_quantity_oz { rand(100) }
  total_cost { rand(100) }
end