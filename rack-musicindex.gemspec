# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/musicindex/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["TODO: Write your name"]
  gem.email         = ["TODO: Write your email address"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
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
