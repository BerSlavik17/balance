class CashesController < ApplicationController
  respond_to :js

  before_filter :find_cash, :only => [:edit, :update, :destroy]

  def update
    @cash.update_attributes params[:cash]

    respond_with @cash
  end

  def new
    @cash = Cash.new

    respond_with @cash
  end

  def create
    @cash = Cash.create params[:cash]

    respond_with @cash
  end

  def destroy
    @cash.destroy
  end

  def edit
    respond_with @cash
  end

  def at_begin
    @at_begin = Cash.at_begin

    respond_with @at_begin
  end

  def update_at_begin
    @at_begin = Setting::set :at_begin, params[:cash][:sum]
    
    respond_with @at_begin
  end

  private
  def find_cash
    @cash = Cash.find params[:id]
  end
end
