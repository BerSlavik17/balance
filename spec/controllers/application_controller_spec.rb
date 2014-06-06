require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#cashes' do
    let(:cash) { stub_model Cash }

    before { expect(Cash).to receive(:order).with(:name) { [cash] } }

    it { expect(subject.send :cashes).to be_a Draper::CollectionDecorator }
  end
end
