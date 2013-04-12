module RSpec
  module Rails
    module Matchers
      module ActionController
        # = have_helper_method
        # 
        # it { should have_helper_method :collection }
        #
        def have_helper_method method
          HaveHelperMethod.new method
        end

        # = respond_with_content_type
        # 
        # it { should respond_with_content_type :js }
        #
        def respond_with_content_type content_type
          RespondWithContentType.new self, content_type
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

        class RespondWithContentType < RSpec::Matchers::BuiltIn::BaseMatcher
          def initialize controller, content_type
            @controller = controller

            @content_type = Mime::Type.lookup_by_extension(content_type.to_s).to_s
          end

          def response_content_type
            @controller.response.content_type.to_s
          end

          def matches? _
            response_content_type == @content_type
          end

          def failure_message_for_should
            %Q(expected respond with content type "#{ @content_type }") +
            %Q( but respond with content_type "#{ response_content_type }")
          end
        end
      end
    end
  end
end
