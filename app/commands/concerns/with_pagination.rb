# frozen_string_literal: true

module WithPagination
  extend ActiveSupport::Concern

  def page
    page = params[:page].to_i
    page.positive? ? page : 1
  end

  def per_page
    per = params[:per_page].to_i
    per.positive? ? per : default_per_page
  end

  def default_per_page
    50
  end
end
