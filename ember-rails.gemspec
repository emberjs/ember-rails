# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ember-rails/version"

Gem::Specification.new do |s|
  s.name        = "ember-rails"
  s.version     = EmberRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Keith Pitt", "Rob Monie", "Joao Carlos"]
  s.email       = ["me@keithpitt.com"]
  s.homepage    = "https://github.com/keithpitt/ember-rails"
  s.summary     = "Ember for Rails 3.1"

  s.add_dependency "execjs", ["~> 1.2", "~> 1.3"]
  s.add_dependency "rails", ["~> 3.1", "~> 3.2"]

  s.files = %w(README.md) + Dir["lib/**/*", "vendor/assets/**/*"]

  s.require_paths = ["lib"]
end
