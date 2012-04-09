require 'sprockets'
require 'sprockets/engines'
require 'ember-rails/hjs_template'

require "ember-rails/slim" if defined? Slim
require "ember-rails/haml" if defined? Haml

module EmberRails
  autoload :HamlFilter, 'ember-rails/haml_filter'

  class Engine < Rails::Engine
    initializer 'ember_rails conditionaly_initialize_haml_filter'do
      EmberRails::HamlFilter if defined? Haml
    end
  end

  # Registers the HandlebarsJS template engine so that
  # an asset file having the extension ".hjs" is processed
  # by the asset pipeline and converted to javascript code.
  Sprockets.register_engine '.hjs', HjsTemplate
  Sprockets.register_engine '.handlebars', HjsTemplate
end

