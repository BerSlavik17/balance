require 'rails_helper'

RSpec.describe CashesController, type: :controller do
  describe 'new.js' do
    before { xhr :get, :new, format: :js }

    it { should render_template :new }
  end

  describe 'create.js' do
    let(:cash) { double }

    let(:params) { { 'name' => 'Food', 'formula' => '43.28 + 18.02' } }

    before { expect(Cash).to receive(:new).with(params).and_return(cash) }

    before { expect(cash).to receive(:save!) }

    before { post :create, cash: params, format: :js }

    it { should render_template :create }
  end

  describe 'edit.js' do
    before { xhr :get, :edit, id: 47, format: :js }

    it { should render_template :edit }
  end

  describe 'update.js' do
    let(:cash) { double }

    let(:params) { { 'name' => 'Food', 'formula' => '43.28 + 18.03' } }

    before { expect(Cash).to receive(:find).with('1').and_return(cash) }

    before { expect(cash).to receive(:update!).with(params) }

    before { patch :update, id: 1, cash: params, format: :js }

    it { should render_template :update }
  end

  describe 'destroy.js' do
    let(:cash) { double }

    before { expect(Cash).to receive(:find).with('1').and_return(cash) }

    before { expect(cash).to receive(:destroy).and_return(true) }

    before { delete :destroy, id: 1, format: :js }

    it { should render_template :destroy }
  end
end
