module DateRange
  class << self
    def build params={}
      date = DateFactory.build params

      date.beginning_of_month..date.end_of_month
    end
  end
end
