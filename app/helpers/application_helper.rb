module ApplicationHelper
  def sum sum
    sum = sum.to_f
    sum = sum.abs if sum > -0.01 && sum < 0
    number_with_delimiter '%.2f' % sum.to_f, :delimiter => '&nbsp;'
  end

  def date date
    I18n.l(date) if date.is_a?(Date)
  end
end

