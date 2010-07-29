class CashesController < ApplicationController
  before_filter :find_cash, :only => [:edit, :update, :destroy]

  def update
    if @cash.update_attributes params[:cash]
      redirect_to items_path
    else
      render :edit
    end
  end

  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new params[:cash]

    if @cash.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @cash.destroy
    redirect_to root_path
  end

  private
  def find_cash
    @cash = Cash.find params[:id]
  end
end
