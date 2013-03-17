# encoding: utf-8
module RSpec
  module Matchers
    # = have_helper_method
    # 
    # it { should have_helper_method :collection }
    #
    def have_helper_method method
      HaveHelperMethod.new method
    end

    class HaveHelperMethod < RSpec::Matchers::BuiltIn::BaseMatcher
      def initialize method
        @method = method.to_sym
      end

      def match _, actual
        actual._helper_methods.include? @method
      end

      def failure_message_for_should
        "expected #{ @actual.class.name } to have helper method #{ @method.inspect }"
      end
    end
  end
end
