class CategoriesController < ApplicationController
  def destroy
    resource.destroy

    redirect_to :categories
  end

  private
  def collection
    @collection ||= Category.all
  end

  def initialize_resource
    @resource = Category.new
  end

  def build_resource
    @resource = Category.new resource_params
  end

  def resource
    @resource ||= Category.find params[:id]
  end

  def resource_params
    params.require(:category).permit(:name, :visible)
  end
end
