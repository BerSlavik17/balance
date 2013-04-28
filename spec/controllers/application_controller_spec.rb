require 'spec_helper'

describe ApplicationController do
  describe '#cashes' do
    let(:cash) { stub_model Cash }

    before { Cash.should_receive(:order).with(:name) { [cash] } }

    it { expect(subject.send :cashes).to be_a Draper::CollectionDecorator }
  end
end
