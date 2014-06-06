require 'rails_helper'

RSpec.describe DateRange do
  let(:date) { Date.today }

  subject { DateRange.new date }

  it { should be_a DateRange }

  it { expect(subject.month).to eq date.beginning_of_month..date.end_of_month }
end
