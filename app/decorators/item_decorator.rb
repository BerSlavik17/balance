class ItemDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :category, prefix: true, allow_nil: true

  decorates_finders

  def money
    Money.new source.sum
  end

  def date
    I18n.l(source.date, format: '%d.%m.%Y') if source.date
  end
end
