class CashesController < ApplicationController
  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new resource_params

    render :new unless resource.save
  end

  def update
    render :edit unless resource.update_attributes resource_params
  end

  def destroy
    resource.destroy
  end

  private
  def resource
    @cash ||= Cash.find params[:id]
  end

  def resource_params
    params.require(:cash).permit(:sum, :name)
  end
end
