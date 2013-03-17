require 'spec_helper'

describe Year do
  before { Date.stub_chain('today.year') { 2013 } }

  subject { Year.new 2012 }

  its(:to_i) { should eq 2012 }

  its(:to_s) { should eq '2012' }

  its(:current?) { should be_false }

  it { expect(Year.new(2013).current?).to be_true }

  it { expect(Year.current).to eq 2013 }

  it { expect { Year.new(2014).to raise_error Year::Invailid, 'available_values 2008..2013' } }

  it { expect(Year.all).to have(6).years }

  it { should eq Year.new 2012 }
end
