module RSpec::Rails
  # Lets you call #render_cell in Rspec2. Move your cell specs to <tt>spec/cells/</tt>.
  module CellExampleGroup
    extend ActiveSupport::Concern
    extend RSpec::Rails::ModuleInclusion

    include RSpec::Rails::RailsExampleGroup
    include Cell::TestCase::TestMethods
    include RSpec::Rails::ViewRendering

    if defined?(Webrat)
      include Webrat::Matchers
      include Webrat::Methods
    end

    if defined?(Capybara)
      include Capybara
      begin
        include Capybara::RSpec::StringMatchers
      rescue NameError
        # do this till capybara 0.4.2 is out.
        require 'rspec/cells/capybara/string_matchers'
        include RSpec::Cells::Capybara::StringMatchers
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

      # we always render views in rspec-cells, so turn it on.
      render_views
      subject { controller }
    end

    RSpec.configure do |c|
      c.include self, :example_group => { :file_path => /spec\/cells/ }
    end

  end
end
