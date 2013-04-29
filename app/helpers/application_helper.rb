module ApplicationHelper
  def current_date
    @current_date ||= DateFactory.build params
  end

  def months
    %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)
  end

  def money sum
    Money.new sum
  end
end
