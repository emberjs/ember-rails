require 'ember/handlebars/template'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new

      config.handlebars.precompile = true
      config.handlebars.templates_root = "templates"
      config.handlebars.templates_path_separator = '/'

      initializer "ember_rails.setup", :after => :append_assets_path, :group => :all do |app|
        sprockets = if ::Rails::VERSION::MAJOR == 4
          Sprockets.respond_to?('register_engine') ? Sprockets : app.assets
        else
          app.assets
        end

        sprockets.register_engine '.handlebars', Ember::Handlebars::Template
        sprockets.register_engine '.hbs', Ember::Handlebars::Template
        sprockets.register_engine '.hjs', Ember::Handlebars::Template
      end
    end
  end
end
