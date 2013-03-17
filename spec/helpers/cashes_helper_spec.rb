require 'spec_helper'

describe CashesHelper do
  pending 'broken' do
  describe 'cash2hash' do
    before :each do
      @cash = Factory :cash, :sum => '1567.8789'
    end

    subject { cash2hash(@cash) }

    def cashes
      {
        :id => @cash.id,
        :sum => '1567.88',
        :name => @cash.name,
        :deleted_at => @cash.deleted_at
      }
    end

    it { should == cashes }
  end
  end
end
