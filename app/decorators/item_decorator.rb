class ItemDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :category, prefix: true, allow_nil: true

  decorates_finders

  def money
    h.money Money.new(sum).to_f
  end

  def date
    h.localize(source.date, format: '%d.%m.%Y') if source.date
  end

  def year
    source.date.year
  end

  def month
    '%02d' % source.date.month
  end

  def day
    '%02d' % source.date.day
  end
end
