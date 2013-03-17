#encoding: utf-8
require 'spec_helper'

describe Month do
  before { Date.stub_chain('today.month') { 10 } }

  subject { Month.new 4 }

  its(:to_i) { should eq 4 }

  its(:to_s) { should eq '04' }

  it { expect { Month.new nil }.to raise_error Month::Invalid, 'available values 1..12' }

  its(:current?) { should be_false }

  it { expect(Month.new(10).current?).to be_true }

  describe '#name' do
    it { expect(Month.new(1).name).to eq 'Январь' }

    (2..11).each do |month|
      it { expect(Month.new(month).name).to eq I18n.t(:months)[month] }
    end
    
    it { expect(Month.new(12).name).to eq 'Декабрь' }
  end

  it { expect(Month.all).to have(12).month }

  it { expect(Month.current).to eq 10 }

  it { should eq Month.new 4 }
end
