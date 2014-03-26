class Cash < ActiveRecord::Base
  validates :name, :sum, presence: true

  validates :sum, numericality: { greater_than_or_equal_to: 0 }

  class << self
    def at_end
      Item.income.sum(:sum) - Item.expense.sum(:sum)
    end

    def balance
      (sum(:sum) - at_end).round(2)
    end
  end
end
