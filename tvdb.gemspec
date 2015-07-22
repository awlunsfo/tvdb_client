# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tvdb/version'

Gem::Specification.new do |spec|
  spec.name          = "tvdb"
  spec.version       = TVDB::VERSION
  spec.authors       = ["Aaron Lunsford"]
  spec.email         = ["awlunsfo@gmail.com"]
  spec.summary       = %q{Ruby client for the TVDB API}
  spec.description   = %q{Ruby library for interacting with the TVDB's REST API}
  spec.homepage      = "https://github.com/awlunsfo/tvdb.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency 'siliconsalad-settingslogic',   '~> 2.0.9'
  spec.add_dependency 'multi_json',                   '~> 1.10.1'
  spec.add_dependency 'faraday'
  spec.add_dependency 'rake',                         '~> 10.1.0'
  spec.add_dependency 'semantic',                     '~> 1.3.1'
  spec.add_dependency 'highline',                     '~> 1.7.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency 'guard',                      '~> 2.6.1'
  spec.add_development_dependency 'guard-rspec',                '~> 4.3.1'
  spec.add_development_dependency 'terminal-notifier',          '~> 1.6.2'
  spec.add_development_dependency 'terminal-notifier-guard',    '~> 1.6.4'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'guard-spork',                '~> 1.5.1'
  spec.add_development_dependency 'spork',                      '~> 0.9.2'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec',                      '~> 3.1.0'
  spec.add_development_dependency 'simplecov',                  '~> 0.9.0'
  spec.add_development_dependency 'webmock',                    '~> 1.18.0'
  spec.add_development_dependency 'sinatra'
end
