require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class TemplateGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js template"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"


      def create_template_files
        template 'template.handlebars', File.join('app/assets/javascripts/templates', class_path, "#{file_name}.handlebars")
      end

    end
  end
end
