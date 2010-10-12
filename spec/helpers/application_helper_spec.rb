require 'spec_helper'

describe ApplicationHelper do
  describe 'sum' do
    subject { sum(40_000.690000) }

    it { should == '40&nbsp;000.69' }
  end
end

