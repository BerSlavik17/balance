class DateRange
  def initialize date
    @date = date
  end

  def month
    @date.beginning_of_month..@date.end_of_month
  end
end
