require 'ember/version'
require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated Handlebars template"
      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"



      def create_view_files

        engine_extension = "js.#{options[:javascript_engine]}".sub('js.js','js')

        template "view.#{engine_extension}", File.join('app/assets/javascripts/views', class_path, "#{file_name}_view.#{engine_extension}")

        template 'view.handlebars', File.join('app/assets/javascripts/templates', class_path, "#{file_name}.handlebars")

        invoke('ember:controller', [ name ], options)
        
        puts name

      end

    end
  end
end
