require 'rails_helper'

RSpec.describe CashDecorator do
  let(:cash) { stub_model Cash }

  subject { CashDecorator.new cash }

  context do
    before { cash.sum = 1234.5 }

    it { expect(subject.sum).to eq '1 234.50' }
  end
end
