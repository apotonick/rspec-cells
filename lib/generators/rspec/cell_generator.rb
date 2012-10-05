require 'generators/cells/base'

module Rspec
  module Generators
    class CellGenerator < ::Cells::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def cell_name
        class_path.empty? ? ":#{file_path}" : %{"#{file_path}"}
      end

      def create_cell_spec_file
        template "cell_spec.erb", File.join("spec/cells/#{file_path}_cell_spec.rb")
      end
    end
  end
end
