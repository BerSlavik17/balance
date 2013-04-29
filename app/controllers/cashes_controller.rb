class CashesController < InheritedResources::Base
  respond_to :js

  helper_method :cashes

  private
  def collection
    cashes
  end
end
