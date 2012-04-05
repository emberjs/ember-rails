require 'sprockets'
require 'sprockets/engines'

require "ember_rails/handlebars/source"
require "ember_rails/handlebars/template"

require "ember_rails/slim" if defined? Slim
require "ember_rails/haml" if defined? Haml

module EmberRails
  class Engine < ::Rails::Engine
    config.handlebars = ActiveSupport::OrderedOptions.new
    config.handlebars.precompile = Rails.env.production?
    config.handlebars.template_root = 'templates'
    config.handlebars.template_path_separator = '/'

    initializer :setup_ember_rails, :group => :all do |app|
      app.assets.register_engine '.handlebars', EmberRails::Handlebars::Template
      app.assets.register_engine '.hbs', EmberRails::Handlebars::Template
      app.assets.register_engine '.hjs', EmberRails::Handlebars::Template
    end
  end
end
