class Cash < ActiveRecord::Base
  acts_as_paranoid

  validates :name, :sum, :presence => true

  validates :sum, :numericality => { :greater_than_or_equal_to => 0 }

  def self.at_begin
    Setting.at_begin
  end

  def self.at_end
    self.at_begin + Item.income.sum(:sum) - Item.expense.sum(:sum)
  end

  def self.balance
    self.sum(:sum) - self.at_end
  end
end
