class Month
  include Comparable

  MONTHS = (1..12)

  def initialize month
    @month = month.to_i

    raise Invalid, 'available values 1..12' unless MONTHS.include? @month
  end

  def to_i
    @month
  end
  
  def to_s
    '%02d' % to_i
  end

  def current?
    @month == self.class.current
  end

  def name
    I18n.t(:months)[to_i]
  end

  def <=> another
    to_i <=> another.to_i
  end

  class << self
    def current
      Date.today.month
    end

    def all
      MONTHS.map { |month| new month }
    end
  end

  class Invalid < StandardError; end
end
