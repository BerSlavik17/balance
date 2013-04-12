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
end
