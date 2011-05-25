require 'spec_helper'

describe AtBeginsController do
  its(:mimes_for_respond_to) { should include(:js) }

  it { should route(:get, '/at_begin/edit').to(:action => :edit) }

  describe 'GET edit as JS' do
    before { get :edit, :format => :js }

    it { should render_template(:edit) }
  end

  describe 'PUT update as JS' do
    before { put :update, :sum => 42.69, :format => :js }

    it { should render_template(:update) }
    it { Setting.at_begin.should == 42.69 }
  end
end
