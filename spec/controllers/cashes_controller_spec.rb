require 'spec_helper'

describe CashesController do
  it { should have_helper_method :resource }

  it { should have_helper_method :cashes }

  describe 'GET new as JS' do
    before { get :new, format: :js }

    it { should render_template :new }

    its(:resource) { should be_a Cash }
  end

  describe 'GET new as HTML' do
    before { get :new }

    it { should respond_with :not_found }
  end

  describe 'POST create as JS' do
    let(:cash) { stub_model Cash, save: true }

    before { Cash.stub new: cash }

    before { post :create, cash: { name: '', sum: 0.0 }, format: :js }

    it { should render_template :create }

    it { should respond_with_content_type :js }

    its(:resource_params) { should be_permitted }
  end

  describe 'POST create as JS with invalid attributes' do
    let(:cash) { stub_model Cash, save: false }

    before { Cash.stub new: cash }

    before { post :create, cash: { name: '' }, format: :js }

    it { should render_template :new }

    it { should respond_with_content_type :js }
  end

  describe 'GET edit as JS' do
    let(:cash) { stub_model Cash }

    before { Cash.stub(:find).with('47') { cash } }

    before { get :edit, id: 47, format: :js }

    it { should render_template :edit }

    it { should respond_with_content_type :js }

    its(:resource) { should eq cash }
  end

  describe 'PUT update as JS' do
    let(:cash) { stub_model Cash, save: true }

    before { Cash.stub(:find).with('61') { cash } }

    before { put :update, id: 61, cash: { name: '' }, format: :js }

    it { should render_template :update }

    it { should respond_with_content_type :js }
  end

  describe 'PUT update as JS with invalid attributes' do
    let(:cash) { stub_model Cash, save: false }

    before { Cash.stub(:find).with('73') { cash } }

    before { put :update, id: 73, cash: { name: '' }, format: :js }

    it { should render_template :edit }

    it { should respond_with_content_type :js }
  end

  describe 'DELETE destroy as JS' do
    let(:cash) { Cash.new.tap { |c| c.stub(:persisted?) { true } } }

    before { Cash.stub(:find).with('87') { cash } }

    before { cash.should_receive(:destroy) { true } }

    before { delete :destroy, id: 87, format: :js }

    it { should render_template :destroy }

    it { should respond_with_content_type :js }
  end
end
