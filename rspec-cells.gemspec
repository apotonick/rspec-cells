$:.unshift File.expand_path("../lib", __FILE__)
require "rspec/cells/version"

Gem::Specification.new do |s|
  s.name        = "rspec-cells"
  s.version     = RSpec::Cells::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nick Sutterer"]
  s.email       = ["apotonick@gmail.com"]
  s.homepage    = "https://github.com/trailblazer/rspec-cells"
  s.summary     = %q{Spec your cells.}
  s.description = %q{Use render_cell in your specs.}
  s.license     = 'MIT'

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/trailblazer/rspec-cells/issues",
    "changelog_uri"     => "https://github.com/trailblazer/rspec-cells/blob/master/CHANGES.md",
    "documentation_uri" => "https://www.rubydoc.info/gems/rspec-cells/#{s.version}",
    "source_code_uri"   => "https://github.com/trailblazer/rspec-cells/tree/v#{s.version}",
    "wiki_uri"          => "https://github.com/trailblazer/rspec-cells/wiki",
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rspec-rails', '< 5.0'
  s.add_runtime_dependency "cells",       ">= 4.0.0", "< 6.0.0"


  s.add_development_dependency "capybara" # FIXME: please make test for Capybara run.
end
