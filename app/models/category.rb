class Category < ActiveRecord::Base
  scope :income, -> { where('income IN(?)', [1, true]) }

  scope :expense, -> { where('income IN(?)', [0, false]) }

  scope :visible, -> { where visible: true }

  before_save :assign_slug

  private
  def assign_slug
    self.slug = Russian::Transliteration.transliterate(self.name).downcase.gsub(/[^a-z]+/, '_')
  end

  class << self
    def group_by_income
      [
        ['Видатки', visible.expense.pluck(:name, :id)],
        ['Надходження', visible.income.pluck(:name, :id)]
      ]
    end
  end
end
