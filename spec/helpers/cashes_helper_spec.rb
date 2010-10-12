require 'spec_helper'

describe CashesHelper do
  describe 'cash2hash' do
    before :each do
      @cash = Factory :cash, :sum => '1567.8789'
    end

    subject { cash2hash(@cash) }

    def make_hash
      {
        :id => @cash.id,
        :sum => '1567.88',
        :name => @cash.name,
        :deleted => @cash.deleted?
      }
    end

    it { should == make_hash }
  end
end
