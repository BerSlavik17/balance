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
    @item = ItemDecorator.new Item.new params[:item]
  end

  def items date_range
    @items ||= Draper::CollectionDecorator.new Item.search(date_range).includes(:category)
  end

  def consolidates
    @consolidates ||= Consolidate.by DateRange.new(DateFactory.build params).month
  end
end
