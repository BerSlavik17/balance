module ApplicationHelper
  def current_month
    Month.new params[:month] || Month.current
  end

  def current_year
    Year.new params[:year] || Year.current
  end
end
