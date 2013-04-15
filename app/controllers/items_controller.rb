class ItemsController < InheritedResources::Base
  respond_to :html, :js

  private
  def collection
    @items ||= ItemsDecorator.new Item.search DateRange.build(params)
  end

  def resource
    @item ||= ItemDecorator.find params[:id]
  end
end
