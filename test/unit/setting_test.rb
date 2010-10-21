require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  should validate_presence_of(:key)
  should validate_presence_of(:value)

  context 'Setting instance' do
    setup do
      Factory :setting
    end

    should validate_uniqueness_of(:key)
  end

  context 'Setting::get' do
    setup do
      Factory :setting, :key => 'foo', :value => 'bar' 
    end

    should 'with key as String' do
      assert_equal 'bar', Setting::get('foo')
    end

    should 'with key as Symbol' do
      assert_equal 'bar', Setting::get(:foo)
    end

    should 'nil when to try to get unexisten key' do
      assert_equal nil, Setting::get('baz')
    end
  end

  context 'Setting::set' do
    context 'when key is unexists' do
      setup do
        Setting::set :foo, 'baz'
      end

      should('successfully create pair'){ assert_equal 'baz', Setting::get(:foo) }
    end

    context 'when key is exists' do
      setup do
        Factory :setting, :key => 'jar', :value => 'zar'
        Setting::set :jar, 'var' 
      end

      should('successfully update pair'){ assert_equal 'var', Setting::get(:jar) }
    end
  end

  context 'Setting::at_begin' do
    context 'when key "at_begin" is exists' do
      setup do
        Factory :setting, :key => 'at_begin', :value => '42.69'
      end

      should 'get 42.69' do
        assert_equal 42.69, Setting::at_begin
      end
    end

    context 'when key "at_begin" is unexists' do
      setup do
        Factory :setting
      end

      should 'get 0.00' do
        assert_equal 0.00, Setting::at_begin
      end
    end
  end
end
