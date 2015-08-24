require 'ember/handlebars/template'
require 'active_model_serializers'
require 'sprockets/railtie'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      Ember::Handlebars::Template.configure do |handlebars_config|
        config.handlebars = handlebars_config

        config.handlebars.precompile = true
        config.handlebars.templates_root = 'templates'
        config.handlebars.templates_path_separator = '/'
        config.handlebars.output_type = :global
        config.handlebars.ember_template = Ember::VERSION =~ /\A1.[0-9]\./ ? 'Handlebars' : 'HTMLBars'
      end

      config.before_initialize do |app|
        Sprockets::Engines #force autoloading

        Ember::Handlebars::Template.setup Sprockets
      end
    end
  end
end
