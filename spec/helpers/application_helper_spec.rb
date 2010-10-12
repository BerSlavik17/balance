require 'spec_helper'

describe ApplicationHelper do
  describe 'sum' do
    describe 'greater than zero' do
      subject { sum(40_000.690000) }

      it { should == '40&nbsp;000.69' }
    end

    describe 'greater than -0.01 and less than 0' do
      subject { sum(-0.001) }

      it { should == '0.00' }
    end

    describe 'less or equal -0.01 and less than 0' do
      subject { sum(-0.01) }

      it { should == '-0.01' }
    end
  end
end

