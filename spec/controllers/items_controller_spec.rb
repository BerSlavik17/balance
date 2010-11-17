require 'spec_helper'

describe ItemsController do
  render_views

  before { Factory :item }

  describe 'GET index as JSON' do
    before :each do
      @items = 2.times.map { Factory :item }
      get :index, :format => :json
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { @items.should =~ assigns(:items) }
  end

  describe 'GET index as HTML' do
    before :each do
      get :index
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:html) }
    it { should assign_to(:categories) }
    it { should assign_to(:cashes) }
    it { should assign_to(:at_begin) }
  end

  describe 'POST create as JSON' do
    before :each do
      post :create, :item => Factory.build(:item).attributes, :format => 'json'
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { should assign_to(:item).with_kind_of(Item) }
  end

  describe 'GET consolidates as JSON' do
    before :each do
      get :consolidates, :format => 'json'
    end

    it { should respond_with(:success) }
    it { should respond_with_content_type(:json) }
    it { should assign_to(:consolidates) }
  end

  describe 'with instance' do
    before :each do
      @item = Factory :item
    end

    describe 'GET edit as JSON' do
      before :each do
        get :edit, :id => @item.id, :format => 'json'
      end
    
      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { assigns(:item).should == @item }
      it { response.should render_template(:edit) }
    end

    describe 'PUT update as JSON' do
      before :each do
        put :update, :id => @item.id, :item => { :summa => '3+2' }, :format => 'json'
      end

      it { should respond_with(:success) }
      it { should respond_with_content_type(:json) }
      it { response.should render_template(:update) }
      it { assigns(:item).sum.should == 5.0 }
      it { assigns(:item).summa.should == '3+2' }
    end
  end

  describe 'DELETE destroy as JS' do
    before { delete :destroy, :id => Item.first, :format => 'js' }

    it { should respond_with(:success) }
    it { should render_template(:destroy) }
    it { assigns(:item).deleted?.should be true }
  end
end

