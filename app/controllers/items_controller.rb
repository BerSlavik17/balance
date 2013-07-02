class ItemsController < InheritedResources::Base
  include InheritedResources::DSL

  respond_to :html, :js

  helper_method :items, :cashes, :consolidates

  create! do |success, failure|
    failure.js { render :new }
  end

  private
  def collection
    items DateRange.new(DateFactory.build params).month
  end

  def resource
    @item ||= ItemDecorator.find params[:id]
  end

  def build_resource
    @item = ItemDecorator.new Item.new resource_params
  end

  def items date_range
    @items ||= Draper::CollectionDecorator.new Item.search(date_range, params[:category]).includes(:category)
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
