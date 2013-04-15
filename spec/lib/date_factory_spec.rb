require 'spec_helper'

describe DateFactory do
  describe '.build' do
    context do
      subject { DateFactory.build }

      it { should eq Date.today }
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
  end

end
