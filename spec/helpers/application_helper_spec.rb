#encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  subject { helper }

  describe '#current_month' do
    before { Month.stub current: 8 }

    its(:current_month) { should eq Month.new 8 }

    context 'stub params' do
      before { subject.stub params: { month: '09' } }

      its(:current_month) { should eq Month.new 9 }
    end
  end

  describe '#current_year' do
    before { Year.stub current: 2013 }

    its(:current_year) { should eq Year.new 2013 }

    context 'stub params' do
      before { subject.stub params: { year: 2012 } }

      its(:current_year) { should eq Year.new 2012 }
    end
  end
end

