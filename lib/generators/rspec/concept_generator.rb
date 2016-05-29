require 'rails/generators'
require 'generators/rspec'

# ensure that we can see the test-libraries like Capybara
Bundler.require :test if Bundler

module Rspec
  module Generators
    class ConceptGenerator < Base
      source_root File.expand_path('../templates', __FILE__)
      argument :actions, type: :array, default: []
      class_option :e, type: :string, desc: 'The template engine'

      def concept_name
        class_path.empty? ? "'#{file_path}/cell'" : %{"#{file_path}/cell"}
      end

      def create_concept_spec_file
        template "concept_spec.erb", File.join("spec/concepts/#{file_path}_concept_spec.rb")
      end

      def template_engine
        (options[:e] || Rails.application.config.app_generators.rails[:template_engine] || 'erb').to_s
      end
    end
  end
end
