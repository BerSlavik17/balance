require 'spec_helper'

describe Cash do
  it { should have_db_column(:deleted).of_type(:boolean).with_options(:default => false) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sum) }
  it { should validate_numericality_of(:sum) }
  it { should_not allow_value(-0.5).for(:sum) }
  
  describe 'balance' do
    before :each do
      Factory :cash, :sum => 40_000.69
    end

    subject { Cash.balance }

    it { should == 40_000.69 }
  end

  describe 'at_end' do
    before :each do
      income = Factory :category, :income => true
      Factory :item, :summa => '40000.69', :category => income
    end

    subject { Cash.at_end }

    it { should == 40_000.69 }
  end

  describe 'at_begin' do
    subject { Cash.at_begin }

    it { should == Setting.at_begin }
  end

  describe 'deleted' do
    before :each do
      @one    = Factory :cash
      @two    = Factory :cash, :deleted => true
      @three  = Factory :cash
    end

    subject { Cash.all }

    it 'should not select' do
      should =~ [@one, @three]
    end
  end
end

