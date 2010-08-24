require 'test_helper'

class CashTest < ActiveSupport::TestCase
  test 'at_begin' do
    assert_equal Setting.at_begin.value.to_f, Cash.at_begin
  end

  test 'at_end' do
    fill_db

    assert_equal (100 + 9 - 5 - 6), Cash.at_end
  end

  test 'balans' do
    fill_db

    assert_equal (Cash.sum(:sum) - Cash.at_end), Cash.balans
  end

  private
  def fill_db
    food   = Factory :category, :name => 'food',   :income => false 
    sex    = Factory :category, :name => 'sex',    :income => false
    salary = Factory :category, :name => 'salary', :income => true 

    Setting.set 'at_begin', '100'
    
    Factory :item, :summa => '5.00', :category => food
    Factory :item, :summa => '6.00', :category => sex
    Factory :item, :summa => '9.00', :category => salary
  end
end
