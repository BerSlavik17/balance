class CashesController < ApplicationController
  helper_method :collection

  private
  def collection
    @cashes ||= CashesDecorator.new Cash.scoped
  end
end
