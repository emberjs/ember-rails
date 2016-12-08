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
  s.license     = "MIT"

  s.add_dependency "railties", [">= 3.1"]
  s.add_dependency "active_model_serializers"

  s.add_dependency "jquery-rails", ">= 1.0.17"
  s.add_dependency "ember-source", ">= 1.8.0"
  s.add_dependency "ember-data-source", '>= 1.13.0'
  s.add_dependency "active-model-adapter-source", ">= 1.13.0"
  s.add_dependency "ember-handlebars-template", ">= 0.1.1", "< 1.0"
  s.add_dependency "ember-es6_template", ">= 0.4.0", "< 0.6"
  s.add_dependency "ember-cli-assets", "~> 0.0.1"

  s.add_development_dependency "bundler", [">= 1.2.2"]
  s.add_development_dependency "tzinfo"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock", "< 1.14.0"

  s.add_development_dependency "sprockets-rails"
  s.add_development_dependency "handlebars-source", "> 1.0.0", "< 3"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "safe_yaml", ">= 1.0.4"

  s.files = %w(README.md LICENSE) + Dir["app/**/*", "lib/**/*", "vendor/**/*"]

  s.require_paths = ["lib"]
end
