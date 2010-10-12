class ItemsController < ApplicationController
  respond_to :json
  
  before_filter :find_item, 
    :only  => [:edit, :update, :destroy]

  before_filter :build_item, 
    :only => [:index, :new]

  def index
    @items = Item.get_all_by_date(params).order('date DESC').includes(:category)

    respond_with(@items) do |format|
      format.html {
        @categories = Category.group_by_income
        @cashes     = Cash.scoped
        @at_begin   = Setting.at_begin.value
        
        render
      }
      format.json
    end
  end

  def create
    @item = Item.new params[:item]

    @item.save

    respond_with @item
  end

  def edit
    respond_with @item
  end

  def update
    @item.update_attributes params[:item]

    respond_with @item
  end

  def consolidates
    @consolidates = Item.consolidates params

    respond_with @consolidates
  end

  private
  def find_item
    @item = Item.find params[:id]
  end

  def build_item
    @item = Item.new
  end
end
