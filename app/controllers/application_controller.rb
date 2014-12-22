class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :collection, :resource

  rescue_from ActionController::UnknownFormat do |exception|
    render 'public/404', status: :not_found, layout: false, formats: [:html]
  end
end
