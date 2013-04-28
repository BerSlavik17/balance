require 'spec_helper'

describe ItemDecorator do
  let(:item) { Item.new }

  subject { ItemDecorator.new item }

  its(:category_name) { should be_nil }

  context 'stub category' do
    before { subject.stub category: double(name: 'Food') }

    its(:category_name) { should eq 'Food' }
  end

  its(:money) { should eq '0.00' }

  context 'stub sum' do
    before { item.stub sum: 145.6 }

    its(:money) { should eq '145.60' }
  end

  context do
    let(:date) { Date.new 2013, 5, 17 }

    before { item.date = date }

    its(:year) { should eq 2013 }

    its(:month) { should eq '05' }

    its(:day) { should eq '17' }
  end
end
