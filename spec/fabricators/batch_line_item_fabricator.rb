Fabricator(:batch_line_item) do
  batch
  ingredient_purchase
  quantity_oz { rand(100) }
  seq { 1 }
end