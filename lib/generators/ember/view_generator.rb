require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated Handlebars template"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :with_template, :type => :boolean, :default => false, :desc => "Create template for this view"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def create_view_files
        file_path = File.join(ember_path, 'views', class_path, "#{file_name.dasherize}.#{engine_extension}")
        template "view.#{engine_extension}", file_path
        invoke('ember:template', [ name ], options) if options[:with_template]
      end

    end
  end
end
