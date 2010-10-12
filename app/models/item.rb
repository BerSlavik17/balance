require 'date_range'

class Item < ActiveRecord::Base
  delegate :year, :month, :day, :to => :date
  delegate :url, :name, :income, :to => :category, :prefix => true

  scope :income, 
    includes(:category).where('categories.income IN(?)', [1, true])

  scope :expense,
    includes(:category).where('categories.income IN(?)', [0, false])

  belongs_to :category

  validates :date, :sum, :category_id, :presence => true

  validates :summa, :format => { :with => /^[0-9\+\-\.]+$/ }

  before_validation :calculate_sum

  def self.consolidates params={}
    range = DateRange.new(params).range

    items = where(:date => range)
    items = items.select('SUM(sum) AS sum, category_id, categories.name AS c_name, categories.income AS income')
    items = items.group(:category_id)
    items = items.joins(:category)
    items = items.order('categories.income DESC')
    
    items.map do |item|
      { :category_name => item.c_name, :sum => item.sum, :income => item.income? }
    end
  end

  def self.get_all_by_date params={}
    where(:date => DateRange.new(params).range)
  end

  private
  def calculate_sum
    #FIXME: "не ломаться" когда тип значение summa отличное от String
    self.sum = eval(self.summa.gsub(/[^0-9\+\-\.]/, ''))
  end
end

