class ItemsController < ApplicationController
  respond_to :js, :html
  
  before_filter :find_item, 
    :only  => [:edit, :update, :destroy]

  def index
    @items = Item.where(:date => DateRange::month(params)).order('date DESC').includes(:category)
    @cashes       = Cash.scoped
    @consolidates = Item.consolidates params

    respond_with @items
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
