require 'test_helper'

class CashTest < ActiveSupport::TestCase
  should have_db_column(:deleted).of_type(:boolean).with_options(:default => false)

  should validate_presence_of(:name)
  should validate_presence_of(:sum)
  should validate_numericality_of(:sum)
  should_not allow_value(-0.5).for(:sum)

  context 'Cash::at_begin' do
    should 'equal Setting::at_begin' do
      assert_equal Setting::at_begin, Cash::at_begin
    end
  end

  context 'Cash::balance' do
    setup do
      Factory :cash, :sum => 40_000.69
    end

    should 'equal 40_000.69' do
      assert_equal 40_000.69, Cash::balance
    end
  end

  context 'Cash::at_end' do
    setup do
      category = Factory :category, :income => true 
      Factory :item, :summa => '40000.69', :category => category
    end

    should 'equal 40_000.69' do
      assert_equal 40_000.69, Cash::at_end
    end
  end

  context 'Cash::scoped' do
    setup do
      @one    = Factory :cash
      @two    = Factory :cash, :deleted => true
      @three  = Factory :cash
    end

    should 'not select deleted cashes' do
      assert_equal [@one, @three], Cash::scoped
    end
  end
end
