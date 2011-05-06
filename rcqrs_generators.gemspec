# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rcqrs_generators/version"

Gem::Specification.new do |s|
  s.name        = "rcqrs_generators"
  s.version     = RcqrsGenerators::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Stefano"]
  s.email       = ["virtualstaticvoid@gmail.com"]
  s.summary     = %q{Rails 3 generators supporting the RCQRS Rails 3 plugin}
  s.description = "Rails 3 generators supporting the RCQRS Rails 3 plugin. Please see the README for more information."
  s.homepage    = "https://github.com/virtualstaticvoid/rcqrs-generators"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]

  s.extra_rdoc_files = [
    'LICENSE',
    'README.md'
  ]

end

