require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class AdapterGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js adapter"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def create_adapter_files
        file_path = File.join(ember_path, 'adapters', class_path, "#{file_name}.#{engine_extension}")
        template "adapter.#{engine_extension}", file_path
      end
    end
  end
end
