class LabelLineItem
  attr_accessor :name, :description, :seq

  def initialize(id: '', name: '', description: '', seq: 0)
    @name = name
    @description = description
    @seq = seq.to_i
  end
end