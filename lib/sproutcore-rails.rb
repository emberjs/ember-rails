require 'sprockets/engines'
require 'sproutcore-rails/hjs_template'

module SproutCoreRails
  class Engine < Rails::Engine
  end

  # Registers the HandlebarsJS template engine so that
  # an asset file having the extension ".hjs" is processed
  # by the asset pipeline and converted to javascript code.
  Sprockets.register_engine '.hjs', HjsTemplate
  Sprockets.register_engine '.handlebars', HjsTemplate
end
