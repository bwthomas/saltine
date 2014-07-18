# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saltine/version"

Gem::Specification.new do |s|
  s.name        = "saltine"
  s.version     = Saltine::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Blake Thomas"]
  s.email       = ["bwthomas@gmail.com"]
  s.homepage    = "https://github.com/bwthomas/saltine"
  s.summary     = %q{Add a little salt}
  s.description = %q{Add a little salt}
  s.license     = 'MIT'

  s.rubyforge_project = "saltine"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'prime-numbers'

  s.add_development_dependency 'rspec', '~>2.6.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'
end
