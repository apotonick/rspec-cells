begin
  require 'rails/railtie'
rescue LoadError
else
  module RSpec
    module Cells
      class Railtie < ::Rails::Railtie
        rake_tasks do
          load 'rspec/cells/tasks.rake'
        end
      end
    end
  end
end
