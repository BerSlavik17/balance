require 'spec_helper'

describe DateRange do
  let(:date) { Date.today }

  subject { DateRange.new date }

  it { should be_a DateRange }

  its(:month) { should eq date.beginning_of_month..date.end_of_month }
end
