module ApplicationHelper
  def current_date
    @current_date ||= DateFactory.build params
  end

  def months
    %w(Січень Лютий Березень Квітень Травень Червень Липень Серпень Вересень Жовтень Листопад Грудень)
  end

  def money sum
    number_with_delimiter '%.2f' % Money.new(sum).to_f
  end

  def cashes
    Cash.order(:name).decorate
  end
end
