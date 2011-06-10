# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sproutcore-rails/version"

Gem::Specification.new do |s|
  s.name        = "sproutcore-rails"
  s.version     = SproutCoreRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joao Carlos"]
  s.email       = ["contact@kiskolabs.com"]
  s.homepage    = "https://github.com/kiskolabs/sproutcore-rails"
  s.summary     = "SproutCore 2 for Rails 3.1."

  s.add_development_dependency "rails", [">= 3.1.0.rc3"]

  s.files = %w(README.md) + Dir["lib/**/*", "vendor/**/*"]

  s.require_paths = ["lib"]
end
