class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :fill_current_year_month_and_day

  private
  def fill_current_year_month_and_day
    today = Date.today
    @day   = (params[:day]   || today.day).to_i
    @month = (params[:month] || today.month).to_i
    @year  = (params[:year]  || today.year).to_i
  end
end
