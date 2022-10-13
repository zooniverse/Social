# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zooniverse_social/version'

Gem::Specification.new do |spec|
  spec.name          = 'zooniverse_social'
  spec.version       = ZooniverseSocial::VERSION
  spec.authors       = ['Michael Parrish']
  spec.email         = ['michael@zooniverse.org']

  spec.summary       = 'Social media aggregation service for the Zooniverse'
  spec.description   = 'Social media aggregation service for the Zooniverse'
  spec.homepage      = 'https://github.com/zooniverse/Social'
  spec.license       = 'Apache 2'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'puma'
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'twitter', '~> 5.16'
  spec.add_runtime_dependency 'faraday', '~> 0.9'
  spec.add_runtime_dependency 'concurrent-ruby', '~> 1.0'
  spec.add_runtime_dependency 'concurrent-ruby-ext', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'rack-test', '~> 0.6'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'pry'
end
