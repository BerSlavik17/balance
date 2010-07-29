require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :category

  test "calculate sum from summa before save" do
    item = Factory(:item, :summa => '5+6')
    assert_equal  11.0, item.sum
    assert_equal '5+6', item.summa

    item.update_attributes! :summa => '8.5-7.2'
    assert_equal  1.3.to_s, item.sum.to_s
    assert_equal '8.5-7.2', item.summa

    assert_raise ActiveRecord::RecordInvalid do
      item.update_attributes! :summa => '2+format c:3'
    end

    assert_raise ActiveRecord::RecordInvalid do
      item.update_attributes! :summa => ''
    end
  end
end
