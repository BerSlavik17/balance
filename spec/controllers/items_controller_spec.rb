require 'spec_helper'

describe ItemsController do
  it { should be_a InheritedResources::Base }

  its(:mimes_for_respond_to) { should include :html }
  
  its(:mimes_for_respond_to) { should include :js }

  it { should route(:post, '/items').to(action: :create) }

  it { should route(:get, '/items/1/edit').to(action: :edit, id: 1) }

  it { should route(:put, '/items/1').to(action: :update, id: 1) }

  it { should route(:get, '/2011').to(action: :index, year: '2011') }
  
  it { should route(:get, '/2011').to(action: :index, year: '2011') }

  it { should route(:get, '/2013/02').to(action: :index, year: '2013', month: '02') }

  it { should route(:get, '/2012/03/17').to(action: :index, year: '2012', month: '03', day: '17') }

  it { should route(:get, '/2010/food').to(action: :index, year: '2010', category: 'food') }

  it { should route(:get, '/2009/04/salary').to(action: :index, year: '2009', month: '04', category: 'salary') }

  it { should route(:get, '/2008/05/17/food').
    to(action: :index, year: '2008', month: '05', day: '17', category: 'food') }

  it { should have_helper_method :items }

  it { should have_helper_method :cashes }

  it { should have_helper_method :consolidates }

  describe 'POST create as JS with invalid attributes' do
    before { Item.any_instance.should_receive(:save) { false } }

    before { post :create, format: :js }

    it { should respond_with_content_type :js }

    its(:resource) { should be_a ItemDecorator }
  end

  describe '#items' do
    let(:item) { stub_model Item }

    let(:date) { Date.today }

    let(:date_range) { date.beginning_of_month..date.end_of_month }

    before do
      #
      # stub: Item.search(date_range).includes(:category)
      #
      Item.should_receive(:search).with(date_range) do
        double.tap { |a| a.should_receive(:includes).with(:category) { [item] } }
      end
    end

    it { expect(subject.send :items, date_range).to be_a Draper::CollectionDecorator }
  end
end
