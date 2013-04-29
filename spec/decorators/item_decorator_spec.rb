require 'spec_helper'

describe ItemDecorator do
  let(:item) { Item.new }

  subject { ItemDecorator.new item }

  its(:category_name) { should be_nil }

  context 'stub category' do
    before { subject.stub category: double(name: 'Food') }

    its(:category_name) { should eq 'Food' }
  end

  context do
    before { item.sum = 100_200.34 }

    its(:money) { should eq '100 200.34' }
  end

  context 'stub sum' do
    before { item.stub sum: 145.6 }

    its(:money) { should eq '145.60' }
  end

  context do
    let(:date) { Date.new 2013, 5, 17 }

    before { item.date = date }

    its(:date) { should eq '17.05.2013' }
  end
end
