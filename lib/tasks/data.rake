namespace :data do
  desc "Export data to file"

  task export: [:environment] do
    data = {}
    [BatchLineItem, Ingredient, IngredientPurchase].each do |klass|
      data[klass.name] = klass.all.map(&:attributes)
    end

    data['Batch'] = Batch.all.map do |b|
      b.attributes.merge({
        notes: b.notes.present? ? b.notes.to_s : nil
      })
    end

    File.open('export.json', 'w') { |f| f << data.to_json }
  end
end