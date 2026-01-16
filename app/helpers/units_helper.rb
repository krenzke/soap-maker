module UnitsHelper
  def unit_select_options
    Units::UNIT_TYPES.to_a.map(&:reverse).sort_by(&:first)
  end
end
