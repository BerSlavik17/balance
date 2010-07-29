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

  def self.consolidate range
    where(:date => range).select('SUM(sum) AS sum, category_id').joins(:category).order('categories.income DESC').group(:category_id)
  end

  private
  def calculate_sum
    self.sum = eval(self.summa.gsub(/[^0-9\+\-\.]/, ''))
  end
end
