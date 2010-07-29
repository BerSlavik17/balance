class DateRange
  def initialize o={}
    year  = o[:year]  || Date.today.year
    month = o[:month] || Date.today.month
    day   = o[:day]

    date = begin
             Date.parse [year, month, day || 1].join('.')
           rescue ArgumentError
             Date.today
           end

    @from = day ? date : date.beginning_of_month
    @till = day ? date : date.end_of_month

    (@from..@till)
  end

  def range
    (@from..@till)
  end
end

