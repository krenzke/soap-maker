namespace :data do

  desc "Export data to file"
  task export: [:environment] do
    data = {}
    [BatchLineItem, Ingredient].each do |klass|
      data[klass.name] = klass.all.map(&:attributes)
    end

    data['Batch'] = Batch.all.map do |b|
      b.attributes.merge({
        notes: b.notes.present? ? b.notes.to_s : nil
      })
    end

    File.open('export.json', 'w') { |f| f << data.to_json }
  end

  desc "Import data from file"
  task import: [:environment] do
    Batch.destroy_all
    Ingredient.destroy_all

    data = JSON.parse(File.read('export.json'))

    indexed_ingredients = data['Ingredient'].index_by{|i| i['id']}

    data['Ingredient'].each do |ingredient_data|
      Ingredient.create!(
        name: ingredient_data['name'],
        ingredient_type: ingredient_data['ingredient_type'],
        default_cost_per_unit: ingredient_data['default_cost_per_unit'],
        unit: ingredient_data['unit'],
      )
    end

    data['Batch'].each do |batch_data|
      batch = Batch.create!(
        name: batch_data['name'],
        manufactured_on: batch_data['manufactured_on'],
        units_produced: batch_data['units_produced']
      )
      
      batch.notes.update(body: batch_data['notes']) if batch_data['notes']

      line_items = data['BatchLineItem'].filter{|li| li['batch_id'] == batch_data['id']}
      line_items.each do |li|
        ingredient = Ingredient.find_by(name: indexed_ingredients[li['ingredient_id']]['name'])

        batch.batch_line_items.create(
          ingredient_id: ingredient.id,
          quantity: li['quantity'],
          cost_per_unit: li['cost_per_unit'],
          quantity_unit: li['quantity_unit'],
          seq: li['seq']
        )
      end
    end
  end
end