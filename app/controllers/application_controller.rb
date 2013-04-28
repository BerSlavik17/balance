class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def cashes
    @cashes ||= Draper::CollectionDecorator.new Cash.order(:name)
  end
end
