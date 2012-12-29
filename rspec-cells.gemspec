# -*- encoding: utf-8 -*-
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

  s.rubyforge_project = "rspec-cells"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<railties>, ['>= 3.0', '< 4.1'])
  s.add_runtime_dependency(%q<rspec-rails>, ["~> 2.2"])
  s.add_runtime_dependency(%q<cells>, ["~> 3.4"])
end
