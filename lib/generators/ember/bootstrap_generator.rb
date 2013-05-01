require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts"

      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :skip_git, :type => :boolean, :aliases => "-g", :default => false, :desc => "Skip Git keeps"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"

      def inject_ember
        begin
          inject_into_application_file(engine_extension)
        rescue Exception => e
          inject_into_application_file('js')
        end
      end


      def create_dir_layout
        %W{models controllers views routes helpers templates}.each do |dir|
          empty_directory "#{ember_path}/#{dir}"
          create_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def create_app_file
        template "app.#{engine_extension}", "#{ember_path}/#{application_name.underscore}.#{engine_extension}"
      end

      def create_router_file
        template "router.#{engine_extension}", "#{ember_path}/router.#{engine_extension}"
      end

      def create_store_file
        template "store.#{engine_extension}", "#{ember_path}/store.#{engine_extension}"
      end

      private
      def inject_into_application_file(safe_extension)
        application_file = "#{ember_path}/application.#{safe_extension}"
        inject_into_file( application_file, :before => /^.*require_tree.*$/) do
          context = instance_eval('binding')
          source  = File.expand_path(find_in_source_paths("application.#{safe_extension}"))
          ERB.new(::File.binread(source), nil, '-', '@output_buffer').result(context)
        end
      end
    end
  end
end
