class CashesController < ApplicationController
  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new(resource_params).decorate

    render :new unless resource.save
  end

  def update
    unless resource.update_attributes resource_params
      render :edit
    end
  end

  def destroy
    resource.destroy

    render :destroy
  end

  private
  def resource
    @cash ||= Cash.find(params[:id]).decorate
  end

  def resource_params
    params.require(:cash).permit(:sum, :name)
  end
end
