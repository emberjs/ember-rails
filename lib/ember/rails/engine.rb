require 'ember/handlebars/template'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new

      config.handlebars.precompile = true
      config.handlebars.templates_root = "templates"
      config.handlebars.templates_path_separator = '/'

      config.before_initialize do |app|
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.handlebars', Ember::Handlebars::Template
        Sprockets.register_engine '.hbs', Ember::Handlebars::Template
        Sprockets.register_engine '.hjs', Ember::Handlebars::Template
      end
    end
  end
end
