require 'spec_helper'

describe DateFactory do
  describe '.build' do
    before { Date.stub today: Date.new(2013, 3, 31) }

    context do
      subject { DateFactory.build }

      it { should eq Date.new 2013, 3, 1 }
    end

    context do
      subject { DateFactory.build year: '2011' }

      its(:year) { should eq 2011 }
    end

    context do
      subject { DateFactory.build month: '11' }

      its(:month) { should eq 11 }
    end

    context do
      subject { DateFactory.build day: '17' }

      its(:day) { should eq 17 }
    end

    context do
      subject { DateFactory.build year: 2013, month: 2 }

      it { should eq Date.new 2013, 2, 1 }
    end
  end
end
