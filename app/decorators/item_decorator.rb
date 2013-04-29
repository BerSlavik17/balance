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
end
