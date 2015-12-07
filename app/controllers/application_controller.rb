class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :collection, :resource

  rescue_from ActionController::UnknownFormat do |exception|
    render 'public/404', status: :not_found, layout: false, formats: [:html]
  end

  def new
    initialize_resource
  end

  def create
    build_resource

    render :errors, status: :unprocessable_entity unless resource.save
  end

  def update
    render :errors, status: :unprocessable_entity unless resource.update resource_params
  end
end
