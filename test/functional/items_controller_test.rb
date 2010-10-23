require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  should route(:get, '/items').to(:action => :index)
  should route(:post, '/items').to(:action => :create)
  should route(:get, '/items/1/edit').to(:action => :edit, :id => 1)
  should route(:put, '/items/1').to(:action => :update, :id => 1)

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
    should('assert assigns(:cashes)'){ assert assigns(:cashes) }
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

  context 'GET edit as JS' do
    setup do
      @item = Factory :item
      get :edit, :id => @item.id, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:edit)
    should('assert assigns(:item)'){ assert assigns(:item).is_a?(Item) }
  end

  context 'PUT update as JS' do
    setup do
      @item = Factory :item
      put :update, :id => @item.id, :item => { :summa => '56' }, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:update)
    should('assert assigns(:item)'){ assert assigns(:item).is_a?(Item) }
    should('sum equal 56.0'){ assert_equal 56.0, assigns(:item).sum }
  end
end
