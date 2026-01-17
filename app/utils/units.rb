module Units
  # db_string => display_string
  UNIT_TYPES = {
    'oz' => 'ounces',
    'g' => 'grams',
    'lb' => 'pounds',
    'tsp' => 'tsp',
    'tbl' => 'Tbl',
    'ml' => 'ml',
  }.freeze

  def self.valid_db_types
    UNIT_TYPES.keys
  end
end