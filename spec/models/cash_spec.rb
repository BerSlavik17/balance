require 'spec_helper'

describe Cash do
  pending 'fixme' do
  it { should have_db_column(:deleted_at).of_type(:time) }

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

  describe 'destroy' do
    before {
      @one    = Factory :cash
      @two    = Factory :cash
      @three  = Factory :cash

      @two.destroy
    }

    subject { Cash.scoped }

    it { should == [@one, @three] }
  end
  end
end
