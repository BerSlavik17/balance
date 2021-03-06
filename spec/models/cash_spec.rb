require 'rails_helper'

RSpec.describe Cash, type: :model do
  it { should be_a ActsAsHasFormula }

  it { should validate_presence_of :name }

  it { should validate_presence_of :formula }

  describe '.at_end' do
    before do
      #
      # Item.income.sum(:sum) -> 10
      #
      expect(Item).to receive(:income) do
        double.tap { |a| expect(a).to receive(:sum).with(:sum) { 10 } }
      end
    end

    before do
      #
      # Item.expense.sum(:sum) -> 6.5
      #
      expect(Item).to receive(:expense) do
        double.tap { |b| expect(b).to receive(:sum).with(:sum) { 6.5 } }
      end
    end

    it { expect(Cash.at_end).to eq 3.5 }
  end

  describe '.balance' do
    before do
      expect(Cash).to receive(:sum).with(:sum) { 24 }

      expect(Cash).to receive(:at_end) { 19.8 }
    end

    it { expect(Cash.balance).to eq 4.2 }
  end
end
