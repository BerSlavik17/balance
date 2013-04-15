module ApplicationHelper
  def current_date
    Date.today.change year: (params[:year] ? params[:year].to_i : nil),
      month: (params[:month] ? params[:month].to_i : nil),
      day: (params[:day] ? params[:day].to_i : nil)
  end

  def months
    %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)
  end
end
