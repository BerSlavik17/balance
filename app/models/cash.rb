class Cash < ActiveRecord::Base
  include ActsAsHasFormula

  validates :name, :formula, presence: true

  class << self
    def at_end
      Item.income.sum(:sum) - Item.expense.sum(:sum)
    end

    def balance
      (sum(:sum) - at_end).round(2)
    end
  end
end
