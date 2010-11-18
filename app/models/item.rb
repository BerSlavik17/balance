class Item < ActiveRecord::Base
  acts_as_paranoid

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
    items = where(:date => DateRange::month(params))
    items = items.select('SUM(sum) AS sum, category_id, categories.name AS c_name, categories.income AS income, categories.url AS url')
    items = items.group(:category_id)
    items = items.joins(:category)
    items = items.order('categories.income DESC')
    
    items.map do |item|
      { :category_name => item.c_name, :sum => item.sum, :income => item.income?, :category_url => item.url }
    end
  end

  def self.search_by params={}
    items = where :date => DateRange::month(params)

    if params[:category]
      items = items.where(:category_id => Category.find_by_url(params[:category]))
    end

    items = items.order('date DESC')
    items = items.includes('category')
  end

  private
  def calculate_sum
    #FIXME: "не ломаться" когда тип значение summa отличное от String
    self.sum = eval(self.summa.gsub(/[^0-9\+\-\.]/, ''))
  end
end

