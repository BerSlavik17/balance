require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "routing" do
    options = { :controller => 'items', :action => 'index', :year => '2010' }
    
    assert_recognizes(options, '/2010')
    assert_recognizes(options.merge(:category => 'sex'), '/2010/sex')

    assert_recognizes(options.merge(:month => '6'), '/2010/6')
    assert_recognizes(options.merge(:month => '6', :category => 'f_ood'), '/2010/6/f_ood')

    assert_recognizes(options.merge(:month => '6', :day => '17'), '/2010/6/17')
    assert_recognizes(options.merge(:month => '6', :day => '17', :category => 'salary'), '/2010/6/17/salary')
  end

  test 'index' do
    Factory :item

    get :index

    assert_response :success
    assert assigns(:items)
  end
end
