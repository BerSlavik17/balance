class CashDecorator < Draper::Decorator
  delegate_all

  def sum
    h.money Money.new(source.sum).to_f
  end
end
