module ItemsHelper
  include ApplicationHelper

  def as_hash item
    { 
      :id => item.id,
      :date => I18n.l(item.date),
      :category_name => item.category_name,
      :sum => sum(item.sum),
      :description => item.description
    }
  end
end
