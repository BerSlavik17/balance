require 'rails_helper'

RSpec.describe ItemDecorator do
  let(:item) { Item.new }

  subject { ItemDecorator.new item }

  it { expect(subject.category_name).to be nil }

  context 'stub category' do
    before { allow(subject).to receive(:category) { double name: 'Food' } }

    it { expect(subject.category_name).to eq 'Food' }
  end

  context do
    before { item.sum = 100_200.34 }

    it { expect(subject.money).to eq '100 200.34' }
  end

  context 'stub sum' do
    before { allow(item).to receive(:sum) { 145.6 } }

    it { expect(subject.money).to eq '145.60' }
  end

  context do
    let(:date) { Date.new 2013, 5, 17 }

    before { item.date = date }

    it { expect(subject.date).to eq '17.05.2013' }
  end
end
