module RSpec
  module Concepts
    module Caching
      extend ActiveSupport::Concern

      module ClassMethods
        def enable_concepts_caching!
          before :each do
            ActionController::Base.perform_caching = true
          end
          after :each do
            ActionController::Base.perform_caching = false
          end
        end

        def disable_concepts_caching!
          before :each do
            ActionController::Base.perform_caching = false
          end
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.include RSpec::Concepts::Caching, type: :concepts
end
