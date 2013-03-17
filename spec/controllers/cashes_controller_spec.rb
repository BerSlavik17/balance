require 'spec_helper'

describe CashesController do
  it { should have_helper_method :collection }

  its(:collection) { should be_a CashesDecorator }

  describe 'GET index as JS' do
    before { get :index, format: :js }

    it { should render_template :index }

    it { should respond_with_content_type :js }
  end
end
