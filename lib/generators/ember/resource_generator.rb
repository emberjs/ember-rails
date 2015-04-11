require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ResourceGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js router, controller, view and template"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :skip_route, :type => :boolean, :default => false, :desc => "Don't create route"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.Controller to represent a single object"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"


      def create_resource_files

        invoke('ember:route', [ name ], options) unless options[:skip_route]
        invoke('ember:controller', [ name ], options)
        invoke('ember:view', [ name ], options)
        invoke('ember:template', [ name ], options) 
      end

    end
  end
end
