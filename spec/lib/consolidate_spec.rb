require 'rails_helper'

RSpec.describe Consolidate do
  describe '.initialize' do
    subject { Consolidate.new name: 'Food', sum: 5.42, slug: 'food', income: false, year: 2013, month: 5 }

    it { expect(subject.name).to eq 'Food' }

    it { expect(subject.sum).to eq 5.42 }

    it { expect(subject.slug).to eq 'food' }

    it { expect(subject.income?).to be false }

    it { expect(subject.year).to eq 2013 }

    it { expect(subject.month).to eq '05' }
  end

  describe '.by' do
    let(:category) { stub_model Category, name: 'Food', slug: 'food' }

    let(:item) { stub_model Item, category: category, sum: 0.0 }

    let(:date_range) { DateRange.new(Date.today).month }

    before do
      #
      # Item.includes(:category).where(date: date_range).select('SUM(sum) AS sum, category_id').group(:category_id)
      #
      expect(Item).to receive(:includes).with(:category) do
        double.tap do |a|
          expect(a).to receive(:where).with(date: date_range) do
            double.tap do |b|
              expect(b).to receive(:select).with('SUM(sum) AS sum, category_id') do
                double.tap { |c| expect(c).to receive(:group).with(:category_id) { [item] } }
              end
            end
          end
        end
      end
    end

    it { expect { Consolidate.by date_range }.to_not raise_error }
  end

  it { expect(subject.to_partial_path).to eq 'consolidates/consolidate' }
end
