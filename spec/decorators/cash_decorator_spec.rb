require 'spec_helper'

describe CashDecorator do
  let(:cash) { stub_model Cash }

  subject { CashDecorator.new cash }

  context do
    before { cash.sum = 1234.5 }

    its(:sum) { should eq '1 234.50' }
  end
end
