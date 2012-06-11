require 'ember/handlebars/template'
require 'active_model_serializers'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new

      config.handlebars.precompile = true
      config.handlebars.templates_root = "templates"
      config.handlebars.templates_path_separator = '/'

      initializer "ember_rails.setup", :group => :all do |app|
        require 'ember/filters/slim' if defined? Slim
        require 'ember/filters/haml' if defined? Haml

        app.assets.register_engine '.handlebars', Ember::Handlebars::Template
        app.assets.register_engine '.hbs', Ember::Handlebars::Template
        app.assets.register_engine '.hjs', Ember::Handlebars::Template

        # Add the gem's vendored ember to the end of the asset search path
        variant = app.config.ember.variant

        if variant.nil?
          warn "[EMBER-RAILS] `ember.variant` was not found in your current environment"
        end

        ember_path = File.expand_path("../../../../vendor/ember/#{variant}", __FILE__)
        app.config.assets.paths.unshift ember_path
      end
    end
  end
end
