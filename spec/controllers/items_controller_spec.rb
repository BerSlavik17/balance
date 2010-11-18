require 'spec_helper'

describe ItemsController do
  render_views

  before { @item = Factory :item }

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

  describe 'POST create as JS' do
    before { post :create, :item => Factory.build(:item).attributes, :format => 'js' }

    it { should respond_with(:success) }
    it { should render_template(:create) }
    it { should respond_with_content_type(:js) }
    it { should assign_to(:item).with_kind_of(Item) }
  end

  describe 'GET edit as JS' do
    before { get :edit, :id => @item.id, :format => 'js' }
  
    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { should render_template(:edit) }
    it { should assign_to(:item).with_kind_of(Item) }
  end
    
  describe 'PUT update as JS' do
    before { put :update, :id => @item.id, :item => { :summa => '3+2' }, :format => 'js' }

    it { should respond_with(:success) }
    it { should respond_with_content_type(:js) }
    it { should render_template(:update) }
    it { should assign_to(:item).with_kind_of(Item) }
    it { assigns(:item).summa.should == '3+2' }
  end

  describe 'DELETE destroy as JS' do
    before { delete :destroy, :id => Item.first, :format => 'js' }

    it { should respond_with(:success) }
    it { should render_template(:destroy) }
    it { @item.reload.deleted_at.should_not be nil }
  end
end

