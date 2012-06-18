# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/musicindex/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["youpy"]
  gem.email         = ["youpy@buycheapviagraonlinenow.com"]
  gem.description   = %q{A Rack middleware to publish directries containing media files as podcast}
  gem.summary       = %q{A Rack middleware to publish directries containing media files as podcast}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rack-musicindex"
  gem.require_paths = ["lib"]
  gem.version       = Rack::Musicindex::VERSION

  gem.add_dependency('builder')
  gem.add_development_dependency('rspec', ['~> 2.8.0'])
  gem.add_development_dependency('rake')
  gem.add_development_dependency('sinatra')
  gem.add_development_dependency('rack-test')
  gem.add_development_dependency('nokogiri')
end
