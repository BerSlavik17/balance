require 'spec_helper'

describe ItemsController do
  before { Item.stub find: item }

  let(:item) { stub_model Item }

  it { should route(:post, '/items').to(action: :create) }

  it { should route(:get, '/items/1/edit').to(action: :edit, id: 1) }

  it { should route(:put, '/items/1').to(action: :update, id: 1) }

  it { should have_helper_method :collection }

  it { should have_helper_method :build_resource }

  it { should have_helper_method :resource }

  its(:build_resource) { should be_a Item }
    
  describe 'GET index' do
    before { get :index }

    it { should render_template :index }
  end

  describe 'POST create as JS' do
    before { Item.any_instance.stub save: true }

    before { post :create, format: :js }

    it { should render_template :create }

    it { should respond_with_content_type :js }
  end

  describe 'POST create as JS with invalid attributes' do
    before { Item.any_instance.stub save: false }

    before { post :create, format: :js }

    it { should render_template :new }

    it { should respond_with_content_type :js }
  end

  describe 'GET edit' do
    before { get :edit, id: item }

    it { should render_template :edit }

    its(:resource) { should eq item }
  end

  describe 'PUT update' do
    before { item.stub update_attributes: true }

    before { put :update, id: item }

    it { should redirect_to :root }
  end

  describe 'PUT update with invalid attributes' do
    before { item.stub update_attributes: false }

    before { put :update, id: item }

    it { should render_template :edit }
  end
end
