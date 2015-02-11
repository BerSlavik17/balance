class ItemsController < ApplicationController
  helper_method :items, :consolidates

  def create
    @item = Item.new resource_params

    render :new unless resource.save
  end

  def update
    render :edit unless resource.update_attributes resource_params
  end

  def destroy
    resource.destroy
  end

  private
  def collection
    items DateRange.new(DateFactory.build params).month
  end

  def resource
    @item ||= Item.find(params[:id]).decorate
  end

  def items date_range
    @items ||= Item.search(date_range, params[:category]).includes(:category).decorate
  end

  def consolidates
    @consolidates ||= Consolidate.by DateRange.new(DateFactory.build params).month
  end

  def resource_params
    params.require(:item).permit(:date, :formula, :category_id, :description)
  end

  def update_resource object, attributes
    object.update_attributes attributes
  end
end
