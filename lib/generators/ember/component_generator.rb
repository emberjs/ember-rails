require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js component and component template"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def create_component_files
        comp_path = File.join(ember_path, 'components', class_path, "#{file_name}_component.#{engine_extension}")
        template "component.#{engine_extension}", comp_path

        templ_path = File.join(ember_path, 'templates/components', class_path, "#{file_name}.handlebars")
        template "component.template.handlebars", templ_path

      end

    end
  end
end
