require 'spec_helper'

describe Cash do
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
end

