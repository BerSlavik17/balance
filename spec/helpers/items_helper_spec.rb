require 'spec_helper'

describe ItemsHelper do
pending 'broken' do
  describe 'as_hash' do
    before :each do
      @item = Factory :item
    end

    subject { as_hash(@item) }

    def item2hash
      {
        :id => @item.id,
        :date => I18n.l(@item.date),
        :category_name => @item.category_name,
        :sum => number_with_delimiter('%.2f' % @item.sum.to_f, :delimiter => '&nbsp;'), 
        :description => @item.description
      }
    end

    it { should == item2hash }
  end
end
end
