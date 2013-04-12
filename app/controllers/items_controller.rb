class ItemsController < ApplicationController
  helper_method :collection, :resource, :build_resource

  before_filter :build_resource, only: :create

  def create
    if resource.save
      render :create
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
    @items ||= ItemsDecorator.new Item.search
  end

  def build_resource
    @item ||= Item.new params[:item]
  end

  def resource
    @item ||= ItemDecorator.find params[:id]
  end
end
