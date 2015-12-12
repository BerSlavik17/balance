require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  it { should route(:post, '/items').to(action: :create) }

  it { should route(:get, '/items/1/edit').to(action: :edit, id: 1) }

  it { should route(:put, '/items/1').to(action: :update, id: 1) }

  it { should route(:get, '/2011').to(action: :index, year: '2011') }

  it { should route(:get, '/2011').to(action: :index, year: '2011') }

  it { should route(:get, '/2013/02').to(action: :index, year: '2013', month: '02') }

  it { should route(:get, '/2010/food').to(action: :index, year: '2010', category: 'food') }

  it { should route(:get, '/2009/04/salary').to(action: :index, year: '2009', month: '04', category: 'salary') }

  it { should have_helper_method :collection }

  it { should have_helper_method :resource }

  it { should have_helper_method :items }

  it { should have_helper_method :consolidates }

  describe '#index.js' do
    before { xhr :get, :index, format: :js }

    it { should render_template :index }
  end

  describe '#create.js' do
    let(:item) { double }

    let(:params) do
      {
        'date' => '2014-04-22',
        'formula' => '2+2',
        'category_id' => 1,
        'description' => 'Buys'
      }
    end

    before { expect(Item).to receive(:new).with(params).and_return(item) }

    context do
      before { expect(item).to receive(:save).and_return(true) }

      before { post :create, item: params, format: :js }

      it { should render_template :create }
    end

    context do
      before { expect(item).to receive(:save).and_return(false) }

      before { post :create, item: params, format: :js }

      it { should render_template :new }
    end
  end

  describe '#items' do
    let(:item) { stub_model Item }

    let(:date) { Date.today }

    let(:date_range) { date.beginning_of_month..date.end_of_month }

    before do
      #
      # Item.search(date_range, nil).includes(:category)
      #
      expect(Item).to receive(:search).with(date_range, nil) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:category)
        end
      end
    end

    it { expect { subject.send :items, date_range }.to_not raise_error }
  end

  describe '#update.js' do
    let(:item) { stub_model Item }

    let(:params) do
      {
        'date' => '2014-04-22',
        'formula' => '2+2',
        'category_id' => 1,
        'description' => 'Buys'
      }
    end

    before { expect(Item).to receive(:find).with('1').and_return(item) }

    before { expect(item).to receive(:update!).with(params) }

    before { put :update, id: 1, item: params, format: :js }

    it { should render_template :update }
  end

  describe '#destroy.js' do
    let(:item) { stub_model Item }

    before { expect(Item).to receive(:find).with('13') { item } }

    before { expect(item).to receive(:destroy) }

    before { delete :destroy, id: 13, format: :js }

    it { should render_template :destroy }
  end
end
