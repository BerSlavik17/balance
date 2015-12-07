class CashesController < ApplicationController
  def destroy
    resource.destroy
  end

  private
  def initialize_resource
    @cash = Cash.new
  end

  def build_resource
    @cash = Cash.new resource_params
  end

  def resource
    @cash ||= Cash.find params[:id]
  end

  def resource_params
    params.require(:cash).permit(:sum, :name)
  end
end
