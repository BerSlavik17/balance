require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'sum' do
    assert_equal number_with_delimiter('%.2f' % 5), sum(5)
  end

  test 'transliterate' do
    assert_equal 'nepredvidennye_rashody', transliterate('Непредвиденные расходы')
  end
end

