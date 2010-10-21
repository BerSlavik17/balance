require 'test_helper'

class CashesControllerTest < ActionController::TestCase
  should route(:post, '/cashes').to(:action => :create)
  should route(:get, '/cashes/1/edit').to(:action => :edit, :id => 1)
  should route(:get, '/cashes/new').to(:action => :new)
  should route(:get, '/at_begin').to(:action => :at_begin)
  should route(:put, '/update_at_begin').to(:action => :update_at_begin)

  context 'POST create as JS' do
    setup do
      post :create, :cash => Factory.attributes_for(:cash), :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:create)
    should('assigns cash'){ assert assigns(:cash) }
    should('assigns(:cash) is a Cash'){ assert assigns(:cash).is_a?(Cash) }
  end

  context 'GET edit as JS' do
    setup do
      @cash = Factory :cash
      get :edit, :id => @cash.id, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:edit)
    should('assigns(:cash) is a Cash'){ assert assigns(:cash).is_a?(Cash) }
  end

  context 'GET new as JS' do
    setup do
      get :new, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:new)
    should('assigns(:cash) is a Cash'){ assert assigns(:cash).is_a?(Cash) }
  end

  context 'PUT update as JS' do
    setup do
      @cash = Factory :cash
      put :update, :id => @cash.id, :cash => Factory.attributes_for(:cash), :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:update)
    should('assigns(:cash) is a Cash'){ assert assigns(:cash).is_a?(Cash) }
  end

  context 'GET at_begin as JS' do
    setup do
      get :at_begin, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:at_begin)
    should('by default Cash::at_begin is 0.0'){ assert_equal 0.0, assigns(:at_begin) }
  end

  context 'PUT update_at_begin as JS' do
    setup do
      put :update_at_begin, :cash => { :name => 'at_begin', :sum => '42.69' }, :format => 'js'
    end

    should respond_with(:success)
    should respond_with_content_type(:js)
    should render_template(:update_at_begin)
    should('update Cash::at_begin'){ assert_equal 42.69, Cash::at_begin }
  end
end
