require 'spec_helper'

describe Item do
  it { should validate_presence_of :date }

  it { should validate_presence_of :category_id }

  it { should belong_to :category }

  its(:class) { should be_paranoid }

  describe '.search' do
    before do
      from = Date.today.beginning_of_month

      to = Date.today.end_of_month

      #
      # Item.where(from..to).
      #   select('SUM(sum) AS sum, date, category_id').
      #   group('date, category_id').
      #   order('date DESC')
      #
      Item.should_receive(:where).with(date: from..to) do
        double.tap do |a|
          a.should_receive(:select).with('SUM(sum) AS sum, date, category_id') do
            double.tap do |b|
              b.should_receive(:group).with('date, category_id') do
                double.tap { |c| c.should_receive(:order).with('date DESC') }
              end
            end
          end
        end
      end
    end

    it { expect { Item.search }.to_not raise_error }
  end

  describe '.income' do
    before do
      Item.should_receive(:includes).with(:category) do
        double.tap { |a| a.should_receive(:where).with('categories.income' => true) }
      end
    end

    it { expect { Item.income }.to_not raise_error }
  end

  describe '.expense' do
    before do
      Item.should_receive(:includes).with(:category) do
        double.tap { |a| a.should_receive(:where).with('categories.income' => false) }
      end
    end

    it { expect { Item.expense }.to_not raise_error }
  end

  describe 'calculate_sum' do
    before do
      subject.summa = '1.8+2.4'

      subject.should_receive(:sum=).with(4.2)
    end

    it { expect { subject.send :calculate_sum }.to_not raise_error }
  end

  context 'before_validation callbacks' do
    before { subject.should_receive :calculate_sum }

    it { expect { subject.valid? }.to_not raise_error }
  end
end
