class Cash < ActiveRecord::Base
  default_scope where(:deleted => false)

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
