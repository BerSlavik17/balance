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
		before { @item = Item.new }

		before { expect(Item).to receive(:new).with('date' => '2014-04-22') { @item } }

		before { expect(@item).to receive(:save) { true } }

		before { post :create, item: { date: '2014-04-22' }, format: :js }

		it { should render_template :create }
	end

  describe '#create.js with invalid attributes' do
    before { expect_any_instance_of(Item).to receive(:save) { false } }

    before { post :create, item: { foo: 'foo' }, format: :js }

		it { should render_template :new }
  end

  describe '#items' do
    let(:item) { stub_model Item }

    let(:date) { Date.today }

    let(:date_range) { date.beginning_of_month..date.end_of_month }

    before do
      #
      # stub: Item.search(date_range, nil).includes(:category)
      #
      expect(Item).to receive(:search).with(date_range, nil) do
        double.tap { |a| expect(a).to receive(:includes).with(:category) { [item] } }
      end
    end

    it { expect(subject.send :items, date_range).to be_a Draper::CollectionDecorator }
  end

	describe '#update.js' do
		let(:item) { stub_model Item }

		before { expect(Item).to receive(:find).with('10') { item } }

		before { expect(item).to receive(:update_attributes).with('date' => '2014-04-22') { true } }

		before { put :update, id: 10, item: { date: '2014-04-22' }, format: :js }

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
