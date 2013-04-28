class CashesController < ApplicationController
  helper_method :collection

  private
  def collection
    cashes
  end
end
