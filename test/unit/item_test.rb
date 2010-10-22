require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should belong_to :category

  should have_db_column(:deleted).of_type(:boolean).with_options(:default => false)

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
  
  context 'Item#category_name' do
    subject { Factory :item }

    should('have instance method category_name'){ assert subject.respond_to?(:category_name) }
    should('item.category_name equal item.category.name'){ assert_equal subject.category.name, subject.category_name }
  end

  context 'Item::consolidates' do
    setup do
      @food   = Factory :category, :name => 'food'
      @sex    = Factory :category, :name => 'sex'
      @salary = Factory :category, :name => 'salary', :income => true

      Factory :item, :date => Date.new(2010,9,1), :summa => '43.00', :category => @sex
      Factory :item, :date => Date.today.beginning_of_month, :summa => '15.00', :category => @food
      Factory :item, :date => Date.today.end_of_month, :summa => '20.00', :category => @food
      Factory :item, :date => Date.today, :summa => '400', :category => @salary
      Factory :item, :date => Date.today, :summa => '16.90', :category => @sex
    end

    context 'for default date' do
      setup do
        @consolidates = [
          { :category_name => @salary.name, :sum => 400, :income => @salary.income? }, 
          { :category_name => @food.name, :sum => 15.0 + 20.0, :income => @food.income? }, 
          { :category_name => @sex.name, :sum => 16.9, :income => @sex.income? } 
        ]
      end

      should(''){ assert_equal @consolidates, Item.consolidates }
    end

    context 'for custom date' do
      setup do 
        @consolidates = [
          { :category_name => @sex.name, :sum => 43.0, :income => @sex.income? }
        ]
      end
      
      should(''){ assert_equal @consolidates, Item.consolidates(:month => 9, :year => 2010) }
    end
  end

  context 'Item::default_scope' do
    setup do
      one    = Factory :item
      two    = Factory :item, :deleted => true
      three  = Factory :item

      @items = [one, three]
    end

    should('not select deleted items'){ assert_same_elements @items, Item.all }
  end
end
