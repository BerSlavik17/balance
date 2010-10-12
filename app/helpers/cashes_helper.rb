module CashesHelper
  include ApplicationHelper

  def cash2hash cash
    {
      :id => @cash.id,
      :sum => '%.2f' % @cash.sum,
      :name => @cash.name,
      :deleted => @cash.deleted?
    }
  end
end
