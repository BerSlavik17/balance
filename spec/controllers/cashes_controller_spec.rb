require 'rails_helper'

RSpec.describe CashesController, type: :controller do
  describe 'new.js' do
    before { xhr :get, :new, format: :js }

    it { should render_template :new }
  end

  describe 'create.js' do
    before { @cash = stub_model Cash }

    before { expect(Cash).to receive(:new).with('name' => 'Food', sum: 43.28).and_return(@cash) }

    context do
      before { expect(@cash).to receive(:save).and_return(true) }

      before { post :create, cash: { name: 'Food', sum: 43.28 }, format: :js }

      it { should render_template :create }
    end

    context do
      before { expect(@cash).to receive(:save).and_return(false) }

      before { post :create, cash: { name: 'Food', sum: 43.28 }, format: :js }

      it { should render_template :new }
    end
  end

  describe 'edit.js' do
    before { xhr :get, :edit, id: 47, format: :js }

    it { should render_template :edit }
  end

  describe 'update.js' do
    let(:cash) { stub_model Cash }

    before { expect(Cash).to receive(:find).with('61').and_return(cash) }

    context do
      before { expect(cash).to receive(:update_attributes).with('name' => 'Stuff').and_return(true) }

      before { patch :update, id: 61, cash: { name: 'Stuff' }, format: :js }

      it { should render_template :update }
    end

    context do
      before { expect(cash).to receive(:update_attributes).with('name' => 'Stuff').and_return(false) }

      before { patch :update, id: 61, cash: { name: 'Stuff' }, format: :js }

      it { should render_template :edit }
    end
  end

  describe 'destroy.js' do
    let(:cash) { stub_model Cash }

    before { expect(Cash).to receive(:find).with('87').and_return(cash) }

    before { expect(cash).to receive(:destroy).and_return(true) }

    before { delete :destroy, id: 87, format: :js }

    it { should render_template :destroy }
  end
end
