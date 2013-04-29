class DateFactory
  def self.build params={}
    Date.today.change year: (params[:year] ? params[:year].to_i : nil),
      month: (params[:month] ? params[:month].to_i : nil),
      day: (params[:day] ? params[:day].to_i : 1)
  end
end
