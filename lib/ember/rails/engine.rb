require 'ember/handlebars/template'
require 'active_model_serializers'
require 'sprockets/railtie'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new

      config.handlebars.precompile = true
      config.handlebars.templates_root = "templates"
      config.handlebars.templates_path_separator = '/'
      config.handlebars.output_type = :global
      config.handlebars.ember_template = Ember::VERSION =~ /\A1.[0-9]\./ ? 'Handlebars' : 'HTMLBars'

      config.before_initialize do |app|
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.handlebars', Ember::Handlebars::Template
        Sprockets.register_engine '.hbs', Ember::Handlebars::Template
        Sprockets.register_engine '.hjs', Ember::Handlebars::Template
      end
    end
  end
end
