require 'rails_helper'

RSpec.describe CashesController, type: :controller do
  it { should have_helper_method :resource }

  it { should have_helper_method :cashes }

  describe 'GET new as JS' do
    before { xhr :get, :new, format: :js }

    it { should render_template :new }

    it { expect(subject.send :resource).to be_a Cash }
  end

  describe 'POST create as JS' do
    before { @cash = stub_model Cash, save: true }

    before { allow(Cash).to receive(:new) { @cash } }

    before { post :create, cash: { name: '', sum: 0.0 }, format: :js }

    it { should render_template :create }

    it { should respond_with_content_type :js }

    it { expect(subject.send :resource).to be_a CashDecorator }

    it { expect(subject.send :resource_params).to be_permitted }
  end

  describe 'POST create as JS with invalid attributes' do
    before { @cash = stub_model Cash, save: false }

    before { allow(Cash).to receive(:new) { @cash } }

    before { post :create, cash: { name: '' }, format: :js }

    it { should render_template :new }

    it { should respond_with_content_type :js }
  end

  describe 'GET edit as JS' do
    let(:cash) { stub_model Cash }

    before { allow(Cash).to receive(:find).with('47') { cash } }

    before { xhr :get, :edit, id: 47, format: :js }

    it { should render_template :edit }

    it { should respond_with_content_type :js }

    it { expect(subject.send :resource).to eq cash }
  end

  describe 'PUT update as JS' do
    let(:cash) { stub_model Cash, save: true }

    before { allow(Cash).to receive(:find).with('61') { cash } }

    before { put :update, id: 61, cash: { name: '' }, format: :js }

    it { should render_template :update }

    it { should respond_with_content_type :js }
  end

  describe 'PUT update as JS with invalid attributes' do
    let(:cash) { stub_model Cash, save: false }

    before { allow(Cash).to receive(:find).with('73') { cash } }

    before { put :update, id: 73, cash: { name: '' }, format: :js }

    it { should render_template :edit }

    it { should respond_with_content_type :js }
  end

  describe 'DELETE destroy as JS' do
    let(:cash) { Cash.new.tap { |c| allow(c).to receive(:persisted?) { true } } }

    before { allow(Cash).to receive(:find).with('87') { cash } }

    before { expect(cash).to receive(:destroy) { true } }

    before { delete :destroy, id: 87, format: :js }

    it { should render_template :destroy }

    it { should respond_with_content_type :js }
  end
end
