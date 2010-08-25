module ApplicationHelper
  def sum sum
    number_with_delimiter '%.2f' % sum.to_f, :delimiter => '&nbsp;'
  end

  def transliterate value
    Russian::Transliteration.transliterate(value).downcase.gsub(/[^a-z]+/, '_')
  end

  def path_for item
    %Q(/#{item.year}/#{item.month}/#{item.day}/#{item.category_url})
  end
end
