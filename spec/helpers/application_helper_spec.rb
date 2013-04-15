require 'spec_helper'

describe ApplicationHelper do
  describe '#current_date' do
    subject { helper.current_date }

    it { should eq Date.today }

    context do
      before { helper.stub params: { year: '2011' } }

      its(:year) { should eq 2011 }
    end

    context do
      before { helper.stub params: { month: '11' } }

      its(:month) { should eq 11 }
    end

    context do
      before { helper.stub params: { day: '17' } }

      its(:day) { should eq 17 }
    end
  end

  describe '#months' do
    subject { helper.months }

    it { should eq %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь) }
  end
end

