$:.unshift File.expand_path("../lib", __FILE__)
require "rspec/cells/version"

Gem::Specification.new do |s|
  s.name        = "rspec-cells"
  s.version     = RSpec::Cells::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nick Sutterer"]
  s.email       = ["apotonick@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rspec-cells"
  s.summary     = %q{Spec your cells.}
  s.description = %q{Use render_cell in your specs.}
  s.license     = 'MIT'

  s.rubyforge_project = "rspec-cells"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "railties",    ">= 3.0"
  s.add_runtime_dependency 'rspec-rails', '>= 2.14'
  s.add_runtime_dependency "cells",       ">= 3.4.0"
  s.add_runtime_dependency 'capybara', '>= 2.4.0'
  s.add_development_dependency 'ammeter',  '1.1.1'
end
