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
        if variant = app.config.ember.variant
          # Copy over the desired ember, ember-data, and handlebars bundled in
          # ember-source, ember-data-source, and handlebars-source to a tmp folder. 
          tmp_path = app.root.join("tmp/ember-rails")
          ext = variant == :production ? ".prod.js" : ".js"
          FileUtils.mkdir_p(tmp_path)
          FileUtils.cp(::Ember::Source.bundled_path_for("ember#{ext}"), tmp_path.join("ember.js"))
          FileUtils.cp(::Ember::Data::Source.bundled_path_for("ember-data#{ext}"), tmp_path.join("ember-data.js"))
          app.assets.append_path(tmp_path)

          # Make the handlebars.js and handlebars.runtime.js bundled
          # in handlebars-source available.
          app.assets.append_path(File.expand_path('../', ::Handlebars::Source.bundled_path))

          # Allow a local variant override
          ember_path = app.root.join("vendor/assets/ember/#{variant}")
          app.assets.prepend_path(ember_path.to_s) if ember_path.exist?

        else
          warn "No ember.js variant was specified in your config environment."
          warn "You can set a specific variant in your application config in "
          warn "order for sprockets to locate ember's assets:"
          warn ""
          warn "    config.ember.variant = :development"
          warn ""
          warn "Valid values are :development and :production"
        end
      end

      initializer "ember_rails.es5_default", :group => :all do |app|
        if defined?(Closure::Compiler) && app.config.assets.js_compressor == :closure
          Closure::Compiler::DEFAULT_OPTIONS[:language_in] = 'ECMASCRIPT5'
        end
      end
    end
  end
end
