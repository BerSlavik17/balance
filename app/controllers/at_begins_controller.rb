class AtBeginsController < ApplicationController
  respond_to(:js)

  def edit
    @at_begin = Setting.at_begin

    respond_with @at_begin
  end

  def update
    @at_begin = Setting.set(:at_begin, params[:sum]).value
    
    respond_with @at_begin
  end
end
