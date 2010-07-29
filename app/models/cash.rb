class Cash < ActiveRecord::Base
  def self.at_begin
    195193.96
  end

  def self.at_end
    # округлим до двух знаков после точки
    ('%.2f' % (self.at_begin + Item.income.sum(:sum) - Item.expense.sum(:sum))).to_f
  end

  def sum
    '%.2f' % self[:sum]
  end

  def self.balans
    self.sum(:sum) - self.at_end
  end
end
