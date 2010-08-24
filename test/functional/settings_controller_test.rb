require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  include Rails.application.routes.url_helpers

  should route(:get, '/at_begin').to(:action => :at_begin)

  test 'route' do
    assert_equal '/at_begin', at_begin_path
  end

  test 'at_begin' do
    # at_begin позволяет править только значение at_begin в Setting
    
    # если такого ключа в Setting не существует то создаем его
    assert_equal false, Setting.exists?(:key => 'at_begin')

    get :at_begin

    assert_response :success
    assert_template :at_begin
    assert setting = assigns(:setting)
    assert_equal 'at_begin', setting.key
    # по-умолчанию значение равно "0"
    assert_equal '0', setting.value

    # если запись существует то просто извлекаем ее
    assert setting.update_attribute :value, 'something'

    get :at_begin

    assert_response :success
    assert_template :at_begin
    assert_equal 'at_begin', assigns(:setting).key
    assert_equal 'something', assigns(:setting).value
  end

  test 'update' do
    setting = Factory :setting, :key => 'at_begin', :value => 'foo bar baz'
    
    put :update, :id => setting.id, :setting => { :value => 'bla-bla-bla' }

    assert_redirected_to items_path
  end
end
