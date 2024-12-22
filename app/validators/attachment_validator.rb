# frozen_string_literal: true

class AttachmentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    return unless values.attached?

    Array(values).each do |value|
      # check size
      if options[:max_size].present? && options[:max_size] < value.blob.byte_size
        record.errors.add(attribute, :max_size_error,
                          max_size: ActiveSupport::NumberHelper.number_to_human_size(options[:max_size]))
      end

      # check for images
      record.errors.add(attribute, :not_an_image) if options[:image] && !value.content_type.start_with?('image/')

      # check for content type
      valid_content_type = case options[:content_type]
                           when Regexp
                             options[:content_type].match(value.content_type)
                           when Array
                             options[:content_type].include?(value.content_type)
                           when String
                             options[:content_type] == value.content_type
                           else # nothing specified, so it passes by default
                             true
                           end

      record.errors.add(attribute, :content_type) unless valid_content_type
    end
  end
end
