require 'ember/handlebars/template'
require 'active_model_serializers'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new
      config.handlebars.precompile = ::Rails.env.production?
      config.handlebars.templates_root = "templates"
      config.handlebars.templates_path_separator = '/'

      initializer "ember_rails.setup", :group => :all do |app|
        require 'ember/filters/slim' if defined? Slim
        require 'ember/filters/haml' if defined? Haml

        app.assets.register_engine '.handlebars', Ember::Handlebars::Template
        app.assets.register_engine '.hbs', Ember::Handlebars::Template
        app.assets.register_engine '.hjs', Ember::Handlebars::Template

        # Add the gem's vendored ember to the end of the asset search path
        app.config.assets.paths << Ember::Rails.ember_path
      end
    end
  end
end
