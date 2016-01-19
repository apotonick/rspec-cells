module RSpec
  module Concepts
    module ExampleGroup
      extend ActiveSupport::Concern

      include RSpec::Rails::RailsExampleGroup
      include Cell::Testing
      include ActionController::UrlFor

      attr_reader :routes

      def method_missing(method, *args, &block)
        # Send the route helpers to the application router.
        if route_defined?(method)
          controller.send(method, *args, &block)
        else
          super
        end
      end

      def route_defined?(method)
        return false unless @routes

        if @routes.named_routes.respond_to?(:route_defined?) # Rails > 4.2.
          @routes.named_routes.route_defined?(method)
        else
          @routes.named_routes.helpers.include?(method)
        end
      end

      included do
        metadata[:type] = :cell

        before do # called before every it.
          @routes = ::Rails.application.routes
          ActionController::Base.allow_forgery_protection = false
        end

        # add Example::controller and ::controller_class.
        extend RSpec::Cells::ExampleGroup::Controller
        let (:controller_class) {  }
        let (:controller) { controller_for(controller_class) }
      end


      module Controller
        def controller(name) # DSL for test, e.g. `controller SongsController`.
          let (:controller_class) { name }
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.include RSpec::Concepts::ExampleGroup, :file_path => /spec\/concepts/
  c.include RSpec::Concepts::ExampleGroup, :type => :concept

  Cell::Testing.capybara = true if Object.const_defined?(:"Capybara")
end
