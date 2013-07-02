require 'spec_helper'

describe CashesController do
  it { should be_a InheritedResources::Base }

  its(:mimes_for_respond_to) { should include :js }

  it { should have_helper_method :cashes }

  describe '#resource_params' do
    let(:params) { { cash: { name: 'Bank', sum: 10_000, foo: 'foo' } } }

    before { controller.stub params: ActionController::Parameters.new(params) }

    subject { controller.send :resource_params }

    it { should be_permitted }

    its([:name]) { should eq 'Bank' }

    its([:sum]) { should eq 10_000 }

    it { should_not have_key :foo }
  end
end
