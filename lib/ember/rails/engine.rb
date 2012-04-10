require 'ember/handlebars/template'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new
      config.handlebars.precompile = ::Rails.env.production?
      config.handlebars.templates_root = nil
      config.handlebars.templates_path_separator = '/'

      initializer :setup_ember_rails, :group => :all do |app|
        app.assets.register_engine '.handlebars', Ember::Handlebars::Template
        app.assets.register_engine '.hbs', Ember::Handlebars::Template
        app.assets.register_engine '.hjs', Ember::Handlebars::Template
      end
    end
  end
end
