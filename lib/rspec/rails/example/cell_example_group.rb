module RSpec::Rails
  # Lets you call #render_cell in Rspec2. Move your cell specs to <tt>spec/cells/</tt>.
  module CellExampleGroup
    VERSION = "0.0.1"

    extend ActiveSupport::Concern
    extend RSpec::Rails::ModuleInclusion

    include RSpec::Rails::RailsExampleGroup
    include Cell::TestCase::TestMethods
    include RSpec::Rails::ViewRendering
    include RSpec::Rails::BrowserSimulators

    webrat do
      include Webrat::Matchers
      include Webrat::Methods
    end

    capybara do
      include Capybara
      begin
        include Capybara::RSpec::StringMatchers
      rescue NameError
        # Read more in the source file
        require 'rspec_cells/capybara/string_matchers'
        include RSpecCells::Capybara::StringMatchers
      end
    end

    module InstanceMethods
      attr_reader :controller, :routes
    end

    included do
      metadata[:type] = :cell
      before do # called before every it.
        @routes = ::Rails.application.routes
        ActionController::Base.allow_forgery_protection = false
        setup # defined in Cell::TestCase.
      end
      subject { controller }
    end

    # RSpec.configure &include_self_when_dir_matches('spec','cells')  # adds a filter to Configuration that includes this module in matching groups.

    RSpec.configure do |c|
      c.include self, :example_group => { :file_path => /spec\/cells/ }
    end

  end
end
