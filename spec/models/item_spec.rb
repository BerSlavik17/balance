require 'spec_helper'

describe Item do
  it { should have_db_column(:deleted_at).of_type(:time) }

  describe 'category_name' do
    subject { Factory :item }

    it { should respond_to :category_name }
    it { subject.category_name.should == subject.category.name }
  end

  describe 'consolidates' do
    before {
      @food   = Factory :category, :name => 'food'
      @sex    = Factory :category, :name => 'sex'
      @salary = Factory :category, :name => 'salary', :income => true

      Factory :item, :date => Date.new(2010,9,1), :summa => '43.00', :category => @sex
      Factory :item, :date => Date.today.beginning_of_month, :summa => '15.00', :category => @food
      Factory :item, :date => Date.today.end_of_month, :summa => '20.00', :category => @food
      Factory :item, :date => Date.today, :summa => '400', :category => @salary
      Factory :item, :date => Date.today, :summa => '16.90', :category => @sex
    }

    describe 'for default date' do
      subject { Item.consolidates }

      def consolidates
        [
          { :category_name => @salary.name, :sum => 400, :income => @salary.income?, :category_url => 'salary' }, 
          { :category_name => @food.name, :sum => 15.0 + 20.0, :income => @food.income?, :category_url => 'food' }, 
          { :category_name => @sex.name, :sum => 16.9, :income => @sex.income?, :category_url => 'sex' } 
        ]
      end

      it { should == consolidates }
    end

    describe 'for custom date' do
      subject { Item.consolidates(:month => 9, :year => 2010) }

      def consolidates
        [{ :category_name => @sex.name, :sum => 43.0, :income => @sex.income?, :category_url => 'sex' }]
      end
      
      it { should == consolidates }
    end
  end

  describe 'destroy' do
    before {
      @one    = Factory :item
      @two    = Factory :item
      @three  = Factory :item

      @two.destroy
    }
    
    subject { Item.scoped }

    it 'should not select' do
      should == [@one, @three]
    end
  end
end
