require 'ember/rails/version'
require 'ember/version'
require 'ember/handlebars/version'
require 'ember/rails/engine'

module Ember
  module Rails
    class Railtie < ::Rails::Railtie
      config.ember = ActiveSupport::OrderedOptions.new

      initializer "ember_rails.setup_vendor", :after => "ember_rails.setup", :group => :all do |app|
        # Add the gem's vendored ember to the end of the asset search path
        variant = app.config.ember.variant
        ember_path = app.root.join("vendor/assets/ember/#{variant}")
        app.config.assets.paths.unshift(ember_path.to_s) if ember_path.exist?
      end

      initializer "ember_rails.find_ember", :after => "ember_rails.setup_vendor", :group => :all do |app|
        config.ember.ember_location = location_for(app, "ember.js")
        config.ember.handlebars_location = location_for(app, "handlebars.js")
      end

      def location_for(app, file)
        path = app.config.assets.paths.find do |dir|
          Pathname.new(dir).join(file).exist?
        end

        File.join(path, file) if path
      end
    end
  end
end
