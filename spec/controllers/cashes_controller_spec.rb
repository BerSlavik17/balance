require 'spec_helper'

describe CashesController do
  it { should have_helper_method :collection }

  describe 'GET index as JS' do
    before { get :index, format: :js }

    it { should render_template :index }

    it { should respond_with_content_type :js }
  end
end
