class ItemsController < ApplicationController
  respond_to :js, :html
  
  before_filter :find_item, 
    :only  => [:edit, :update, :destroy]

  def index
    @cashes = Cash.scoped

    respond_to do |format|
      format.js do
        @items = Item.search_by params
        @consolidates = Item.consolidates params
      end

      format.html
    end
  end

  def create
    @item = Item.create params[:item]

    respond_with @item.save
  end

  def edit
    respond_with @item
  end

  def update
    @item.update_attributes params[:item]

    respond_with @item
  end

  def destroy
    @item.destroy

    respond_with @item
  end

  private
  def find_item
    @item = Item.find params[:id]
  end
end
