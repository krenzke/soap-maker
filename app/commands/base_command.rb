# frozen_string_literal: true

class BaseCommand
  extend ActiveModel::Naming
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def execute
    raise StandardError, 'Must define in child class'
  end
end
