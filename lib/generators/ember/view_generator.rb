require 'ember/version'
require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated Handlebars template"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :skip_template, :type => :boolean, :default => true, :desc => "Skip template creation"

      def create_view_files
        template "view.#{engine_extension}", File.join('app/assets/javascripts/views', class_path, "#{file_name}_view.#{engine_extension}")

        invoke('ember:template', [ name ], options) unless options[:skip_template]
      end

    end
  end
end
