class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::UnknownFormat do |exception|
    render 'public/404', status: :not_found, layout: false, formats: [:html]
  end

  private
  def cashes
    Draper::CollectionDecorator.new Cash.order(:name)
  end
end
