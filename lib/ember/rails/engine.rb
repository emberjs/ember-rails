require 'ember/handlebars/template'
require 'active_model_serializers'
require 'ember/es6_template'
require 'ember/cli/assets'

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

        app.assets = Sprockets if app.assets.nil? # Compatible with Rails 3.2
      end

      config.before_initialize do |app|
        Ember::Handlebars::Template.setup app.assets
      end

      config.before_initialize do |app|
        Ember::ES6Template.setup app.assets
      end

      config.after_initialize do |app|
        Ember::ES6Template.configure do |ember_config|
          ember_config.module_prefix = config.ember.module_prefix
          ember_config.prefix_files = config.ember.prefix_files
          ember_config.prefix_dirs = config.ember.prefix_dirs
        end
      end
    end
  end
end
