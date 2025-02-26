class LabelLineItem
  attr_accessor :id, :name, :description, :seq

  def initialize(id: '', name: '', description: '', seq: 0)
    @id = id
    @name = name
    @description = description
    @seq = seq.to_i
  end
end