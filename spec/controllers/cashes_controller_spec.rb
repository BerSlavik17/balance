require 'spec_helper'

describe CashesController do
  render_views 

  before { @cash = Factory :cash }

  describe 'POST create as JS' do
    before :each do
      post :create, :cash => Factory.attributes_for(:cash), :format => 'js'
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { should render_template(:create) }
  end

  describe 'DELETE destroy as JS' do
    before { delete :destroy, :id => @cash.id, :format => 'js' }

    it { should respond_with(:success) }
    it { should render_template(:destroy) }
    it { @cash.reload.deleted_at.should_not be nil }
  end

  describe 'PUT update as JS' do
    before { put :update, :id => @cash.id, :cash => { :name => 'two', :sum => 54.87 }, :format => 'js' }

    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { assigns(:cash).sum.should == 54.87 }
    it { assigns(:cash).name.should == 'two' }
    it { response.should render_template(:update) }
  end

  describe 'GET edit as JS' do
    before { get :edit, :id => @cash.id, :format => 'js' } 

    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { assigns(:cash).should == @cash }
    it { response.should render_template(:edit) }
  end
end
