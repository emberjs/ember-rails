require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ServiceGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js service"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :ember_path, :type => :string, :aliases => "-d", :desc => "Custom ember app path"
      class_option :app_name, :type => :string, :aliases => "-n", :desc => "Custom ember app name"

      def create_service_files
        file_path = File.join(ember_path, 'services', class_path, "#{file_name.dasherize}.#{engine_extension}")

        template "service.#{engine_extension}", file_path
      end
    end
  end
end
