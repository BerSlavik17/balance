class Consolidate
  include ActiveModel::Conversion

  attr_reader :name, :sum, :slug, :year

  def initialize name: nil, sum: nil, slug: nil, income: false, year: nil, month: nil
    @name = name

    @sum = sum

    @slug = slug

    @income = income

    @year = year

    @month = month
  end

  def income?
    !!@income
  end

  def month
    '%02d' % @month.to_i
  end

  class << self
    def by date_range
      Item.includes(:category).where(date: date_range).select('SUM(sum) AS sum, category_id').group(:category_id).
        map do |item|
          new name: item.category.name, sum: item.sum, slug: item.category.slug, income: item.category.income,
            year: date_range.begin.year, month: date_range.begin.month
        end.
        # TODO: spec me
        tap do |items|
          sum = items.inject(0) do |sum, item|
            sum += item.sum unless item.income?

            sum
          end

          items.push(Consolidate.new name: 'Сума витрат', sum: sum)
        end
    end
  end
end
