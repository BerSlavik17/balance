class ItemsController < ApplicationController
  helper_method :collection, :build_resource, :resource

  def create
    if build_resource.save
      redirect_to :items
    else
      render :new
    end
  end

  def update
    if resource.update_attributes params[:item]
      redirect_to :root
    else
      render :edit
    end
  end

  private
  def collection
    @items ||= ItemDecorator.search
  end

  def build_resource
    @item ||= Item.new params[:item]
  end

  def resource
    @item ||= ItemDecorator.find params[:id]
  end
end
