module DateRange
  def self.month params={}
    date = parse(params)

    (date.beginning_of_month..date.end_of_month)
  end

  private
  def self.parse params={}
    year  = params[:year]  || Date.today.year
    month = params[:month] || Date.today.month

    date = begin
      Date.parse [year, month, 1].join('.')
    rescue ArgumentError
      Date.today
    end
  end
end
