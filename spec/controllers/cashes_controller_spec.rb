require 'spec_helper'

describe CashesController do
  it { should be_a_kind_of(InheritedResources::Base) }

  it { subject.mimes_for_respond_to.should include(:js) }

  describe 'POST create as JS' do
    describe 'with valid attributes' do
      before { post :create, :cash => Factory.build(:cash).attributes, :format => 'js' }

      it { should respond_with(:success) }
      it { should render_template(:create) }
      it { should assign_to(:cash).with_kind_of(Cash) }
    end

    describe 'with invalid attributes' do
      before { post :create, :cash => {}, :format => 'js' }

      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should assign_to(:cash).with_kind_of(Cash) }
    end
  end
end
