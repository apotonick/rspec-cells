require 'rails/generators'
require 'generators/rspec'

# ensure that we can see the test-libraries like Capybara
Bundler.require :test if Bundler

# ensure that we can see the test-libraries like Capybara
Bundler.require :test if Bundler

module Rspec
  module Generators
    class CellGenerator < Base
      source_root File.expand_path('../templates', __FILE__)
      argument :actions, type: :array, default: []
      class_option :e, type: :string, desc: 'The template engine'

      def cell_name
        class_path.empty? ? ":#{file_path}" : %{"#{file_path}"}
      end

      def create_cell_spec_file
        template "cell_spec.erb", File.join("spec/cells/#{file_path}_cell_spec.rb")
      end
      
      def template_engine
        (options[:e] || Rails.application.config.app_generators.rails[:template_engine] || 'erb').to_s
      end
    end
  end
end
