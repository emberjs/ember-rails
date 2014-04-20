require 'rails'
require 'ember/rails/version'
require 'ember/rails/engine'
require 'ember/source'
require 'ember/data/source'
require 'handlebars/source'

module Ember
  module Rails
    class Railtie < ::Rails::Railtie
      config.ember = ActiveSupport::OrderedOptions.new

      generators do |app|
        app ||= ::Rails.application # Rails 3.0.x does not yield `app`

        app.config.generators.assets = false

        ::Rails::Generators.configure!(app.config.generators)
        ::Rails::Generators.hidden_namespaces.uniq!
        require "generators/ember/resource_override"
      end

      initializer "ember_rails.setup_vendor", :after => "ember_rails.setup", :group => :all do |app|
        variant = app.config.ember.variant || (::Rails.env.production? ? :production : :development)
        ext = variant == :production ? ".prod.js" : ".js"

        #Allow for over-rides and updates, empty /bundler to avoid duplicate files
        ember_path = app.root.join("vendor/assets/ember/#{variant}")
        bundled_path = ember_path.join("bundler")
        FileUtils.mkdir_p(bundled_path)
        FileUtils.rm_rf(Dir.glob("#{bundled_path}/*"))

        # Check for over-rides, else store the bundled ember and ember-data in /bundler
        if !File.exist?(ember_path.join("ember.js"))
          FileUtils.cp(::Ember::Source.bundled_path_for("ember#{ext}"), 
                       bundled_path.join("ember.js"))
        end
        if !File.exist?(ember_path.join("ember-data.js"))
          FileUtils.cp(::Ember::Data::Source.bundled_path_for("ember-data#{ext}"), 
                       bundled_path.join('ember-data.js'))
        end

        app.assets.prepend_path(ember_path)
        app.assets.append_path(bundled_path)

        # Make the handlebars.js and handlebars.runtime.js bundled
        # in handlebars-source available.
        app.assets.append_path(File.expand_path('../', ::Handlebars::Source.bundled_path))
      end

      initializer "ember_rails.es5_default", :group => :all do |app|
        if defined?(Closure::Compiler) && app.config.assets.js_compressor == :closure
          Closure::Compiler::DEFAULT_OPTIONS[:language_in] = 'ECMASCRIPT5'
        end
      end
    end
  end
end
