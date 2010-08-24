require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  should validate_presence_of(:key)
  should validate_presence_of(:value)

  context 'Setting' do
    setup do
      Factory :setting
    end

    should validate_uniqueness_of(:key)
  end

  test 'set' do
    key   = 'key'
    value = 'value'

    # Если ключ не найден то создаем новую запись
    assert_equal false, Setting.exists?(:key => key)
    assert setting = Setting.set(key, value)
    assert_equal setting, Setting.get(key)
    assert_equal value, setting.value

    # Если ключ существует то обновляем значение
    assert_equal true, Setting.exists?(:key => key)
    assert setting = Setting.set(key, 'new value')
    assert_equal setting, Setting.get(key)
    assert_equal 'new value', setting.value
  end

  test 'get' do
    setting = Factory(:setting, :key => 'key', :value => 'value')

    assert_equal setting, Setting.get('key')
  end

  test 'at_begin' do
    # если в Setting существует ключ at_begin возвращаеем его
    Factory :setting, :key => 'at_begin', :value => '42.69'
    assert setting = Setting.at_begin
    assert_equal 'at_begin', setting.key
    assert_equal '42.69', setting.value
    
    # если такого ключа нету то создаем новый с значением "0"
    Setting.delete_all :key => 'at_begin'
    assert_equal false, Setting.exists?(:key => 'at_begin')

    assert setting = Setting.at_begin
    assert_equal 'at_begin', setting.key
    assert_equal '0', setting.value
  end
end
