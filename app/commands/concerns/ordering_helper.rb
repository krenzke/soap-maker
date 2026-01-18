# frozen_string_literal: true

module OrderingHelper
  extend ActiveSupport::Concern

  def apply_order(scope, sort_param)
    match = self.class.ordering_parser_regex.match(sort_param)
    attr_name, dir = match ? [match[:attr_name], match[:dir]] : default_order_name_and_dir

    order_data = self.class.orderable_attributes[attr_name.to_sym]
    order_clause = if order_data.is_a?(Hash)
                     scope = scope.joins(order_data[:joins]) if order_data[:joins]
                     [order_data[:column] => dir]
                   else
                     [order_data => dir]
                   end
    scope.order(order_clause)
  end

  def default_order_name_and_dir
    return @default_order_name_and_dir if @default_order_name_and_dir

    default_option = self.class.default_order_attribute
    @default_order_name_and_dir = if default_option.ends_with?('_asc')
                                    [default_option[0..-5].to_sym, :asc]
                                  elsif default_option.ends_with?('_desc')
                                    [default_option[0..-6].to_sym, :desc]
                                  else
                                    [default_option.to_sym, :desc]
                                  end
  end

  module ClassMethods
    attr_reader :orderable_attributes, :default_order_attribute

    # process inputs
    # :name, :created_at, price: {column: '...'}  becomes
    # {name: :name, created_at: :created_at, price: {column: '...'}}
    # basically put everthing in a hash for consistent data lookup
    def order_with(*attrs)
      default = nil
      @orderable_attributes = attrs.reduce({}) do |acc, attr|
        case attr
        when Hash
          default = attr[:default] if attr[:default].present?

          acc = acc.merge(attr.except(:default))
        when Symbol, String
          acc[attr.to_sym] = attr
        end
        acc
      end
      @default_order_attribute = default || @orderable_attributes.keys.first
    end

    def ordering_parser_regex
      @ordering_parser_regex ||= /(?<attr_name>#{orderable_attributes.keys.join('|')})_(?<dir>asc|desc)/
    end
  end
end
