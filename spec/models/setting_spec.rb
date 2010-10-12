require 'spec_helper'

describe Setting do
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:value) }

  describe 'with instance' do
    before :each do
      @setting = Factory :setting, :key => 'foo', :value => 'bar'
    end

    it { should validate_uniqueness_of(:key) }

    describe 'get' do 
      describe '"key" as String' do
        subject { Setting.get('foo') }

        it { should == 'bar' }
      end

      describe ':key as Symbol' do
        subject { Setting.get(:foo) }

        it { should == 'bar' }
      end

      describe 'not exists key' do
        subject { Setting.get(:baz) }

        it { should == nil }
      end
    end
  end

  describe 'at_begin' do
    subject { Setting.at_begin }

    describe 'with key "at_begin"' do
      before :each do
        Factory :setting, :key => 'at_begin', :value => '42.69'
      end

      it { should == 42.69 } 
    end

    describe 'without key "at_begin"' do
      it { should == 0.00 }
    end
  end
end

