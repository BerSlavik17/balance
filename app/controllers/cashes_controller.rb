class CashesController < InheritedResources::Base
  respond_to :js

  helper_method :cashes

  private
  def collection
    cashes
  end

  def resource_params
    params.require(:cash).permit(:name, :sum)
  end

  def update_resource object, attributes
    object.update_attributes attributes
  end
end
