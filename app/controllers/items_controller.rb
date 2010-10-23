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
    @item = Item.new params[:item]

    if @item.save
      respond_with @item
    else
      render :error
    end
  end

  def edit
    respond_with @item
  end

  def update
    if @item.update_attributes params[:item]
      render :update
    else
      render :error
    end
  end

  def consolidates
    @consolidates = Item.consolidates params

    respond_with @consolidates
  end

  private
  def find_item
    @item = Item.find params[:id]
  end
end
