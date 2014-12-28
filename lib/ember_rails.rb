require 'rails'
require 'ember/source'
require 'ember/data/source'
require 'ember/rails/version'
require 'ember/rails/engine'
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

        # Copy over the desired ember and ember-data bundled in
        # ember-source and ember-data-source to a tmp folder.
        tmp_path = app.root.join("tmp/ember-rails")
        FileUtils.mkdir_p(tmp_path)

        if variant == :production
          ember_ext = ".prod.js"
        else
          ember_ext = ".debug.js"
          ember_ext = ".js" unless File.exist?(::Ember::Source.bundled_path_for("ember#{ember_ext}")) # Ember.js 1.9.0 or earlier has no "ember.debug.js"
        end
        FileUtils.cp(::Ember::Source.bundled_path_for("ember#{ember_ext}"), tmp_path.join("ember.js"))
        ember_data_ext = variant == :production ? ".prod.js" : ".js"
        FileUtils.cp(::Ember::Data::Source.bundled_path_for("ember-data#{ember_data_ext}"), tmp_path.join("ember-data.js"))

        app.assets.append_path(tmp_path)

        # Make the handlebars.js and handlebars.runtime.js bundled
        # in handlebars-source available.
        app.assets.append_path(File.expand_path('../', ::Handlebars::Source.bundled_path))

        # Allow a local variant override
        ember_path = app.root.join("vendor/assets/ember/#{variant}")
        app.assets.prepend_path(ember_path.to_s) if ember_path.exist?
      end

      initializer "ember_rails.es5_default", :group => :all do |app|
        if defined?(Closure::Compiler) && app.config.assets.js_compressor == :closure
          Closure::Compiler::DEFAULT_OPTIONS[:language_in] = 'ECMASCRIPT5'
        end
      end
    end
  end
end
