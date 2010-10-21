module ApplicationHelper
  def sum sum
    sum = sum.to_f
    sum = sum.abs if sum > -0.01 && sum < 0
    number_with_delimiter '%.2f' % sum.to_f, :delimiter => '&nbsp;'
  end
end

__END__

  def transliterate value
    Russian::Transliteration.transliterate(value).downcase.gsub(/[^a-z]+/, '_')
  end

  def path_for item
    %Q(/#{item.year}/#{item.month}/#{item.day}/#{item.category_url})
  end
