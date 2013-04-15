require 'spec_helper'

describe DateRange do
  let(:date) { Date.new }

  before { DateFactory.should_receive(:build).with(year: '2013', month: '06', day: '27') { date } }

  subject { DateRange.build year: '2013', month: '06', day: '27' }

  it { should eq date.beginning_of_month..date.end_of_month }
end
