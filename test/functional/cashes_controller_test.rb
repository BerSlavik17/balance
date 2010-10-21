require 'test_helper'

class CashesControllerTest < ActionController::TestCase
  should route(:post, '/cashes').to(:action => :create)

  context 'POST create as JS' do
    setup do
      post :create, :cash => Factory.attributes_for(:cash), :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should('assigns cash'){ assert assigns(:cash) }
    should('assigns(:cash) is a Cash'){ assert assigns(:cash).is_a?(Cash) }
  end
end
