module Units
  # db_string => display_string
  UNIT_TYPES = {
    'oz' => 'Ounces',
    'g' => 'Grams',
    'lb' => 'Pounds',
    'tsp' => 'tsp',
    'tbl' => 'Tbl',
  }.freeze

  def self.valid_db_types
    UNIT_TYPES.keys
  end
end