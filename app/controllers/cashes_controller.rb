class CashesController < ApplicationController
  helper_method :resource, :cashes

  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new(resource_params).decorate

    respond_to do |format|
      format.js do
        resource.save ? render(:create) : render(:new)
      end
    end
  end

  def update
    respond_to do |format|
      format.js do
        if resource.update_attributes(resource_params)
          render :update
        else
          render :edit
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        resource.destroy

        render :destroy
      end
    end
  end

  private
  def resource
    @cash ||= Cash.find(params[:id]).decorate
  end

  def resource_params
    params.require(:cash).permit(:sum, :name)
  end
end
