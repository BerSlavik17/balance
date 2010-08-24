class Cash < ActiveRecord::Base
  def self.at_begin
    Setting.at_begin.value.to_f #195193.96
  end

  def self.at_end
    # округлим до двух знаков после точки
    ('%.2f' % (self.at_begin + Item.income.sum(:sum) - Item.expense.sum(:sum))).to_f
  end

  def self.balans
    self.sum(:sum) - self.at_end
  end
end
