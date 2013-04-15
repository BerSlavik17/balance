require 'spec_helper'

describe ApplicationHelper do
  describe '#months' do
    subject { helper.months }

    it { should eq %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь) }
  end

  describe '#current_date' do
    let(:date) { Date.new 2013, 6, 27 }

    before { helper.stub params: { year: '2013', month: '06', day: '27' } }

    before { DateFactory.should_receive(:build).with(year: '2013', month: '06', day: '27') { date } }

    subject { helper.current_date }

    it { should eq date }
  end
end

