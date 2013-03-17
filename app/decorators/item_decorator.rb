class ItemDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :category, prefix: true, allow_nil: true

  decorates_finders

  def money
    Money.new source.sum
  end

  def date
    I18n.l source.date, format: '%d.%m.%Y'
  end

  class << self
    def search *args
      decorate_collection source_class.search *args
    end
  end
end
