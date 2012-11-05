# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ember/rails/version"

Gem::Specification.new do |s|
  s.name        = "ember-rails"
  s.version     = Ember::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Keith Pitt", "Rob Monie", "Joao Carlos", "Paul Chavard"]
  s.email       = ["me@keithpitt.com", "paul@chavard.net"]
  s.homepage    = "https://github.com/emberjs/ember-rails"
  s.summary     = "Ember for Rails 3.1+"

  s.add_dependency "execjs", [">= 1.2"]
  s.add_dependency "railties", ["~> 3.1"]
  s.add_dependency "active_model_serializers"
  s.add_dependency "barber"

  s.add_development_dependency "rails", ["~> 3.1"]

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "vendor/**/*"]

  s.require_paths = ["lib"]
end
