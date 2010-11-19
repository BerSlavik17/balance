class CashesController < InheritedResources::Base
  respond_to :js

  def create
    super do |format|
      format.js do
        render :new unless @cash.valid?
      end
    end
  end
end
