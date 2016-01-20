require 'rspec/core/rake_task'

namespace :spec do
  desc "Run the code examples in spec/cells"
  RSpec::Core::RakeTask.new("cells") do |t|
    t.pattern = "./spec/cells/**/*_spec.rb"
    t.rspec_opts = '--tag cell'
  end

  desc "Run the code examples in spec/concepts"
  RSpec::Core::RakeTask.new("concepts") do |t|
    t.pattern = "./spec/concepts/**/*_spec.rb"
    t.rspec_opts = '--tag cell'
  end
end
