require 'generators/cells/base'


module Rspec
  module Generators
    # @private
    class CellGenerator < Cells::Generators::Base
      def self.source_root
        File.expand_path('../templates', __FILE__)
      end

      def create_cell_spec
        template 'cell_spec.erb', File.join('spec/cells', class_path, "#{file_name}_cell_spec.rb")
      end

      private
      def cell_name
        class_name.underscore
      end
    end
  end
end
