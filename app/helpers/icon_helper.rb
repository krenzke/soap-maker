# frozen_string_literal: true

module IconHelper
  def icon(name, opts = {})
    content_tag(:span, name, { style: "font-family:'Material Symbols Outlined'" }.merge(opts))
  end
end
