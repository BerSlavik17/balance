require 'spec_helper'

describe Cash do
  it { should allow_mass_assignment_of :name }

  it { should allow_mass_assignment_of :sum }

  it { should validate_presence_of :name }

  it { should validate_presence_of :sum }
  
  it { should validate_numericality_of :sum }

  it { should_not allow_value(-0.5).for(:sum) }

  its(:class) { should be_paranoid }

  describe '.at_end' do
    before do
      Item.should_receive(:income) { double.tap { |a| a.should_receive(:sum).with(:sum) { 10 } } }

      Item.should_receive(:expense) { double.tap { |b| b.should_receive(:sum).with(:sum) { 6.5 } } }
    end

    it { expect(Cash.at_end).to eq 3.5 }
  end

  describe '.balance' do
    before do
      Cash.should_receive(:sum).with(:sum) { 24 }

      Cash.should_receive(:at_end) { 19.8 }
    end

    it { expect(Cash.balance).to eq 4.2 }
  end
end
