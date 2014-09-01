module RSpec
  module Cells
    # Lets you call #render_cell in Rspec2. Move your cell specs to <tt>spec/cells/</tt>.
    module ExampleGroup
      extend ActiveSupport::Concern

      include RSpec::Rails::RailsExampleGroup
      include RSpec::Rails::ViewRendering
      include RSpec::Rails::Matchers::RedirectTo
      include RSpec::Rails::Matchers::RenderTemplate
      include RSpec::Rails::Matchers::RoutingMatchers

      def cell_class
        described_class.to_s.underscore.gsub('_cell','')
      end

      attr_reader :routes

      # @private
      def routes=(routes)
        @routes = routes
      end

      def extract_state_ivars_for(cell)
        before  = cell.instance_variables
        yield
        after   = cell.instance_variables

        Hash[(after - before).collect do |var|
          next if var =~ /^@_/
          [var[1, var.length].to_sym, cell.instance_variable_get(var)]
        end.compact]
      end


      included do
        subject { cell }

        def cell(name = cell_class, *args, &block)
          Cell::Rails.cell_for(name, @cell, *args).tap do |cell|
            cell.instance_eval &block if block_given?
          end
        end


        def render_cell(name, state, *args)
          subject_cell = cell(name, *args)
          @view_assigns = extract_state_ivars_for(subject_cell) do
            @last_invoke = subject_cell.render_state(state, *args)
          end
          Capybara.string(@last_invoke)
        end

        def render_state(state, *args)
          render_cell(cell_class, state, *args)
        end


        around do |ex|
          previous_allow_forgery_protection_value = ActionController::Base.allow_forgery_protection
          begin
            ActionController::Base.allow_forgery_protection = false
            ex.call
          ensure
            ActionController::Base.allow_forgery_protection = previous_allow_forgery_protection_value
          end
        end

        before do
          @cell ||= Class.new(ActionController::Base).new
          @request    ||= ::ActionController::TestRequest.new
          @response   = ::ActionController::TestResponse.new
          @cell.request = @request
          @cell.response = @response
          @cell.params = {}
          self.routes = ::Rails.application.routes
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.include RSpec::Cells::ExampleGroup, :file_path => /spec\/cells/
  c.include RSpec::Cells::ExampleGroup, :type => :cell
  c.include Capybara::DSL, :type => :cell
end
