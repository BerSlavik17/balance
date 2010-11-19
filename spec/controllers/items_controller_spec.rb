require 'spec_helper'

describe ItemsController do
  it { should be_a_kind_of(InheritedResources::Base) }

  it { subject.mimes_for_respond_to.should include(:js) }
  it { subject.mimes_for_respond_to[:html].should == { :only => [:index] } }

  describe 'GET index as JS' do
    before { get :index, :format => :js }

    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { should render_template(:index) }
    it { should assign_to(:items) }
    it { should assign_to(:cashes) }
    it { should assign_to(:consolidates) }
  end

  describe 'GET index as HTML' do
    before { get :index }

    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should respond_with_content_type(:html) }
    it { should assign_to(:cashes) }
  end
end
