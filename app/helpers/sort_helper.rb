# frozen_string_literal: true

module SortHelper
  def sort_url(sort_dir, params)
    params = params.to_unsafe_h if params.respond_to?(:to_unsafe_h)
    params = params.merge(only_path: true)

    url_for(params.merge(sort: sort_dir))
  end

  def sort_link(attr_name, params)
    case params[:sort]
    when "#{attr_name}_asc"
      link_to sort_url("#{attr_name}_desc", params) do
        icon(:arrow_upward, class: 'h-4 w-4')
      end
    when "#{attr_name}_desc"
      link_to sort_url("#{attr_name}_asc", params) do
        icon(:arrow_downward, class: 'h-4 w-4')
      end
    else
      link_to sort_url("#{attr_name}_asc", params) do
        icon(:swap_vert, class: 'h-4 w-4')
      end
    end
  end
end
