require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  should route(:get, '/items').to(:action => :index)
  should route(:post, '/items').to(:action => :create)

  test "routing" do
    options = { :controller => 'items', :action => 'index', :year => '2010' }
    
    assert_recognizes(options, '/2010')
    assert_recognizes(options.merge(:category => 'sex'), '/2010/sex')

    assert_recognizes(options.merge(:month => '6'), '/2010/6')
    assert_recognizes(options.merge(:month => '6', :category => 'f_ood'), '/2010/6/f_ood')

    assert_recognizes(options.merge(:month => '6', :day => '17'), '/2010/6/17')
    assert_recognizes(options.merge(:month => '6', :day => '17', :category => 'salary'), '/2010/6/17/salary')
  end

  context 'GET index as HTML' do
    setup do
      Factory :item
      get :index
    end

    should respond_with(:success)
    should render_template(:index)
    should respond_with_content_type(:html)
    should('assert assigns(:items)'){ assert assigns(:items) }
    should('assert assigns(:cashes)'){ assert assigns(:cashes) }
    should('assert assigns(:categories)'){ assert assigns(:categories) }
    should('assert assigns(:consolidates)'){ assert assigns(:consolidates) }
  end

  context 'GET index as JS' do
    setup do
      Factory :item
      get :index, :format => 'js'
    end

    should respond_with(:success)
    should render_template(:index)
    should respond_with_content_type(:js)
    should('assert assigns(:items)'){ assert assigns(:items) }
    should('assert assigns(:cashes)'){ assert assigns(:cashes) }
    should('assert assigns(:categories)'){ assert assigns(:categories) }
    should('assert assigns(:consolidates)'){ assert assigns(:consolidates) }
  end

  context 'POST create as JS' do
    setup do
      post :create, :item => Factory.build(:item).attributes, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:create)
    should('assert assigns(:item)'){ assert assigns(:item).is_a?(Item) }
  end
end
