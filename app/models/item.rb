class Item < ActiveRecord::Base
  belongs_to :category

  validates :date, :category_id, :presence => true

  scope :income, -> { includes(:category).where('categories.income' => true) }

  scope :expense, -> { includes(:category).where('categories.income' => false) }

  acts_as_paranoid

  before_validation :calculate_sum

  private
  def calculate_sum
    self.sum = Money.new(summa).to_f
  end

  class << self
    def search
      from = Date.today.beginning_of_month

      to = Date.today.end_of_month

      where(date: from..to).select('SUM(sum) AS sum, date, category_id').group('date, category_id').
        order('date DESC')
    end
  end
end
