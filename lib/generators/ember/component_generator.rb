require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js component and component template\nCustom Ember Components require at least two descriptive names separated by a dash. Use CamelCase or dash-case to name your component.\n\nExample,\n\trails generate ember:component PostChart [options]\n\trails generate ember:component post-chart [options]"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def create_component_files
        dashed_file_name = file_name.dasherize
        comp_path = File.join(ember_path, 'components', class_path, "#{dashed_file_name}.#{engine_extension}")
        template "component.#{engine_extension}", comp_path

        templ_path = File.join(ember_path, 'templates/components', class_path, "#{dashed_file_name}.hbs")
        template "component.template.hbs", templ_path

      end

    end
  end
end
