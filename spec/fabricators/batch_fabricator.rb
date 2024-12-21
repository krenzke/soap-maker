Fabricator(:batch) do
  transient ingredients: 3 # integer or collection of existing ingredients
  name { FFaker::AnimalUS.common_name }
  manufactured_on { rand(100).days.ago }
  units_produced { rand(20) + 1 }

  after_create do |batch, transients|
    transients[:ingredients].times { Fabricate(:batch_line_item, batch:) }
  end
end
