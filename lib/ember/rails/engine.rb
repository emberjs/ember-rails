require 'ember/handlebars/template'
require 'active_model_serializers'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      rake_tasks do
        load File.expand_path("../ember.tasks", __FILE__)
      end

      config.before_configuration do
        # set up a Handlebars configuration options object
        config.handlebars = ActiveSupport::OrderedOptions.new
        # Precompile Handlebars templates in production
        config.handlebars.precompile = ::Rails.env.production?
        # Expect templates to be located in templates by default
        config.handlebars.templates_root = "templates"
        # Expect template paths to be separated by slashes by default
        config.handlebars.templates_path_separator = '/'
      end

      initializer "ember_rails.setup", :group => :all do |app|
        # Enable filters if the relevant libraries are present
        require 'ember/filters/slim' if defined? Slim
        require 'ember/filters/haml' if defined? Haml

        # Register the Handlebars template engine with Sprockets
        app.assets.register_engine '.handlebars', Ember::Handlebars::Template
        app.assets.register_engine '.hbs', Ember::Handlebars::Template
        app.assets.register_engine '.hjs', Ember::Handlebars::Template

        # Add the gem's vendored ember to the end of the asset search path
        app.config.assets.paths << Ember::Rails.ember_path
      end
    end
  end
end
