class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :collection, :resource

  rescue_from ActiveRecord::RecordInvalid do
    render :errors, status: :unprocessable_entity
  end

  def new
    initialize_resource
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update! resource_params
  end
end
