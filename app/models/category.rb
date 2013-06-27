class Category < ActiveRecord::Base
  scope :income, -> { where('income IN(?)', [1, true]) }

  scope :expense, -> { where('income IN(?)', [0, false]) }

  def self.group_by_income
    [
      [I18n.t(:expense), self.expense.map{ |c| [c.name, c.id]}],
      [I18n.t(:income), self.income.map{ |c| [c.name, c.id] }]
    ]
  end

  before_save :make_url

  private
  def make_url
    self.url = Russian::Transliteration.transliterate(self.name).downcase.gsub(/[^a-z]+/, '_')
  end
end
