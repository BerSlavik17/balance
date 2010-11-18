class CashesController < ApplicationController
  respond_to :js, :html

  before_filter :find_cash, :only => [:edit, :update, :destroy]

  def index
    @cashes = Cash.scoped

    respond_with @cashes
  end

  def update
    @cash.update_attributes params[:cash]

    respond_with @cash
  end

  def new
    @cash = Cash.new

    respond_with @cash
  end

  def create
    @cash = Cash.new params[:cash]

    @cash.save

    respond_with @cash do |format|
      format.js do
        if @cash.errors.empty?
          render :create
        else
          render :error
        end
      end
    end
  end

  def destroy
    @cash.destroy
  end

  def at_end
    @at_end = Cash.at_end

    respond_with @at_end 
  end

  def balance
    @balance = Cash.balance

    respond_with @balance
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
