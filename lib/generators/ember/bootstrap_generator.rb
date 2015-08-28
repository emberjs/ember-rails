require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts"

      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :skip_git, :type => :boolean, :aliases => "-g", :default => false, :desc => "Skip Git keeps"
      class_option :javascript_engine, :desc => "Engine for JavaScripts (js for JavaScript, coffee for CoffeeScript, etc)"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def inject_ember
        begin
          if javascript_engine == 'es6'
            inject_into_application_file('es6') # Don't use `.module.es6`.
          else
            inject_into_application_file(engine_extension)
          end
        rescue Exception => e
          inject_into_application_file('js')
        end
      end

      def create_dir_layout
        %W{models controllers views routes helpers components templates templates/components mixins adapters}.each do |dir|
          empty_directory "#{ember_path}/#{dir}"
          create_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def create_app_file
        template "app.#{engine_extension}", "#{ember_path}/#{application_name.underscore.dasherize}.#{engine_extension}"
      end

      def create_router_file
        template "router.#{engine_extension}", "#{ember_path}/router.#{engine_extension}"
      end

      def create_adapter_file
        template "application_adapter.#{engine_extension}", "#{ember_path}/adapters/application.#{engine_extension}"
      end

      def create_env_file
        template "environment.#{engine_extension}", "#{ember_path}/environment.#{engine_extension}"
      end

      private

      def inject_into_application_file(safe_extension)
        application_file = "application.#{safe_extension}"
        full_path = Pathname.new(destination_root).join(ember_path, application_file)

        if full_path.exist?
          injection_options = get_options_from_contents(full_path.read)

          inject_into_file(full_path.to_s, injection_options) do
            context = instance_eval('binding')
            source  = File.expand_path(find_in_source_paths(application_file))
            ERB.new(::File.binread(source), nil, '-', '@output_buffer').result(context)
          end
        else
          template application_file, full_path
        end
      end

      def get_options_from_contents(contents)
        if contents =~ regex = /^.*require_tree.*$/
                                {:before => regex}
                              elsif contents =~ regex = /^\s*$/
                                {:before => regex}
                              else
                                regex = /\z/
                                {:after => regex}
                              end
      end
    end
  end
end
