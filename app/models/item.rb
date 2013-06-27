class Item < ActiveRecord::Base
  attr_accessible :date, :formula, :category_id, :description

  belongs_to :category

  validates :date, :category_id, :formula, presence: true

  scope :income, -> { includes(:category).where('categories.income' => true) }

  scope :expense, -> { includes(:category).where('categories.income' => false) }

  before_validation :calculate_sum

  acts_as_paranoid

  private
  def calculate_sum
    self.sum = Money.new(formula).to_f
  end

  class << self
    def search date_range, slug=nil
      if slug
        where 'categories.slug' => slug
      else
        self
      end.includes(:category).where(date: date_range).order('date DESC')
    end
  end
end
