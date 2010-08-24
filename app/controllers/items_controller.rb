require 'date_range'

class ItemsController < ApplicationController
  before_filter :group_categories, 
    :only => [:index, :new, :create, :edit]
  
  before_filter :find_item, 
    :only  => [:edit, :update, :destroy]

  before_filter :build_item, 
    :only => [:index, :new]

  def index
    @cashes   = Cash.all
    @at_end   = Cash.at_end  
    @balans   = Cash.balans
    
    @at_begin = Setting.at_begin.value

    range = DateRange.new params
    @items = Item.where(:date => range.range).includes(:category).order('date DESC')
    
    month = DateRange.new(:year => @year, :month => @month).range
    @consolidates = Item.consolidate month

    if params[:category]
      @items = @items.where('categories.url=?', params[:category])
    end

    if params[:day] || params[:category]
      render :day
    else
      @items = @items.select('SUM(sum) AS sum, date, category_id').group('date, category_id')
      render :month
    end
  end

  def create
    @item = Item.new params[:item]

    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def update
    if @item.update_attributes params[:item]
      redirect_to items_path
    else
      render :edit
    end
  end

  private
  def group_categories
    @categories = Category.group_by_income
  end

  def find_item
    @item = Item.find params[:id]
  end

  def build_item
    @item = Item.new
  end
end
