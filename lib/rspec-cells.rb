module RSpec
  module Cells
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "rspec/cells/tasks.rake"
      end

      initializer 'cells.rspec' do |app|
        require 'rspec/cells'
      end
    end
  end
end
