require 'ember/handlebars/template'

module Ember
  module Rails
    class Engine < ::Rails::Engine
      config.handlebars = ActiveSupport::OrderedOptions.new
      config.handlebars.precompile = ::Rails.env.production?
      config.handlebars.templates_root = nil
      config.handlebars.templates_path_separator = '/'

      initializer :setup_ember_rails, :group => :all do |app|

        require 'ember/filters/slim' if defined? Slim
        require 'ember/filters/haml' if defined? Haml

        app.assets.register_engine '.handlebars', Ember::Handlebars::Template
        app.assets.register_engine '.hbs', Ember::Handlebars::Template
        app.assets.register_engine '.hjs', Ember::Handlebars::Template

        assets_path = File.expand_path(File.join(__FILE__, '../../../../vendor/assets/javascripts'))

        if ::Rails.env.production?
          app.assets.append_path File.join(assets_path, 'production')
        else
          app.assets.append_path File.join(assets_path, 'development')
        end
      end
    end
  end
end
