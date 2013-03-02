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
  s.add_dependency "railties", [">= 3.1"]
  s.add_dependency "barber", [">= 0.4.1"]
  s.add_dependency "ember-source"
  s.add_dependency "ember-data-source"

  s.add_development_dependency "bundler", [">= 1.2.2"]
  s.add_development_dependency "appraisal"
  s.add_development_dependency "tzinfo"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "vendor/**/*"]

  s.require_paths = ["lib"]

  # Temporary notification for AMS transition to Gemfile
  s.post_install_message = <<POSTINSTALL
# Ember-Rails Release Notes #

If you're upgrading from ember-rails 0.11.1 or earlier, please be aware of the
ActiveModelSerializers changes that are part of this update:

ActiveModelSerializers will no longer be a hard dependency of ember-rails and
will not be require'd automatically.  Please add the following line to your
Gemfile to continue using ActiveModelSerializers with ember-rails:

    gem "active_model_serializers"

In new applications, running the bootstrap generator will append this
dependency statement to your Gemfile for you:

    rails g ember:bootstrap

Read more about using ember-rails at https://github.com/emberjs/ember-rails
POSTINSTALL
end
