class CashDecorator < Draper::Decorator
  delegate_all

  def sum
    h.number_with_delimiter Money.new(source.sum)
  end
end
