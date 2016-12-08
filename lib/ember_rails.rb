require 'rails'
require 'ember/source'
require 'ember/data/source'
require 'ember/rails/version'
require 'ember/rails/engine'
require 'ember/data/active_model/adapter/source'

# Use handlebars if it possible. Because it is an optional feature.
begin
  require 'handlebars/source'
rescue LoadError => e
  raise e unless ['cannot load such file -- handlebars/source', 'no such file to load -- handlebars/source'].include?(e.message)
end

module Ember
  module Rails
    class Railtie < ::Rails::Railtie
      config.ember = ActiveSupport::OrderedOptions.new
      config.ember.module_prefix = 'ember-app'
      config.ember.prefix_files = %w(store router)
      config.ember.prefix_dirs = %w(
        models
        controllers
        views
        routes
        components
        helpers
        mixins
        services
        initializers
        instance-initializers
        serializers
        adapters
        transforms
      )

      generators do |app|
        app.config.generators.assets = false

        ::Rails::Generators.configure!(app.config.generators)
        ::Rails::Generators.hidden_namespaces.uniq!
        require "generators/ember/resource_override"
      end

      def configure_assets(app)
        if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
          # Rails 4.x
          config.assets.configure do |env|
            yield env
          end
        else
          # Rails 3.2
          yield app.assets
        end
      end

      initializer "ember_rails.setup_vendor_on_locale", :after => "ember_rails.setup", :group => :all do |app|
        variant = app.config.ember.variant || (::Rails.env.production? ? :production : :development)

        # Allow a local variant override
        ember_path = app.root.join("vendor/assets/ember/#{variant}")

        configure_assets app do |env|
          env.prepend_path(ember_path.to_s) if ember_path.exist?
        end
      end

      initializer "ember_rails.copy_vendor_to_local", :after => "ember_rails.setup", :group => :all do |app|
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
        FileUtils.cp(::Ember::Data::ActiveModel::Adapter::Source.bundled_path_for("active-model-adapter.js"), tmp_path.join("active-model-adapter.js"))

        configure_assets app do |env|
          env.append_path tmp_path
        end
      end

      initializer "ember_rails.setup_vendor", :after => "ember_rails.copy_vendor_to_local", :group => :all do |app|
        configure_assets app do |env|
          env.append_path ::Ember::Source.bundled_path_for(nil)
          env.append_path ::Ember::Data::Source.bundled_path_for(nil)
          env.append_path ::Ember::Data::ActiveModel::Adapter::Source.bundled_path_for(nil)
          env.append_path File.expand_path('../', ::Handlebars::Source.bundled_path) if defined?(::Handlebars::Source)
        end
      end

      initializer "ember_rails.setup_ember_template_compiler", :after => "ember_rails.setup_vendor", :group => :all do |app|
        configure_assets app do |env|
          ember_template_compiler, _ = env.resolve('ember-template-compiler.js')
          if env.valid_asset_uri?(ember_template_compiler)
            ember_template_compiler, _ = env.parse_asset_uri(ember_template_compiler)
          end
          Ember::Handlebars::Template.setup_ember_template_compiler(ember_template_compiler)
        end
      end

      initializer "ember_rails.setup_ember_cli_assets", :after => "ember_rails.setup_vendor", :group => :all do |app|
        configure_assets app do |env|
          env.append_path Ember::CLI::Assets.root
        end
      end

      initializer "ember_rails.setup_ember_handlebars_template", :after => "ember_rails.setup_vendor", :group => :all do |app|
        configure_assets app do |env|
          Ember::Handlebars::Template.setup env
        end
      end

      initializer "ember_rails.setup_ember_es6_template", :after => "ember_rails.setup_vendor", :group => :all do |app|
        configure_assets app do |env|
          Ember::ES6Template.setup env
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
