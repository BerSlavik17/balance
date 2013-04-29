require 'spec_helper'

describe Consolidate do
  describe '.initialize' do
    subject { Consolidate.new name: 'Food', sum: 5.42, slug: 'food', income: false, year: 2013, month: 5 }

    its(:name) { should eq 'Food' }

    its(:sum) { should eq 5.42 }

    its(:slug) { should eq 'food' }

    its(:income?) { should be_false }

    its(:year) { should eq 2013 }

    its(:month) { should eq '05' }
  end

  describe '.by' do
    let(:category) { stub_model Category, name: 'Food', slug: 'food' }

    let(:item) { stub_model Item, category: category }

    let(:date_range) { DateRange.new(Date.today).month }

    before do
      #
      # Item.includes(:category).where(date: date_range).select('SUM(sum) AS sum, category_id').group(:category_id)
      #
      Item.should_receive(:includes).with(:category) do
        double.tap do |a|
          a.should_receive(:where).with(date: date_range) do
            double.tap do |b|
              b.should_receive(:select).with('SUM(sum) AS sum, category_id') do
                double.tap { |c| c.should_receive(:group).with(:category_id) { [item] } }
              end
            end
          end
        end
      end
    end

    it { expect { Consolidate.by date_range }.to_not raise_error }
  end

  its(:to_partial_path) { should eq 'consolidates/consolidate' }
end
