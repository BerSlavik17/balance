class Year
  include Comparable

  def self.current
    Date.today.year
  end

  YEARS = 2008..(self.current)

  def initialize year
    @year = year.to_i

    raise Invalid, "available values #{ YEARS }" unless YEARS.include? @year
  end

  def to_i
    @year
  end

  def to_s
    @year.to_s
  end

  def current?
    @year == self.class.current
  end

  def <=> another
    to_i <=> another.to_i
  end

  class << self
    def all
      YEARS.map { |year| new year }
    end
  end

  class Invalid < StandardError; end
end
