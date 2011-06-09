require 'sprockets/engines'
require 'sproutcore-rails/hjs_template'

module SproutCoreRails
  class Engine < Rails::Engine
  end

  Sprockets.register_engine '.hjs', HjsTemplate
end
