require 'ember/version'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated Handlebars template"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_view_files
        template 'view.js', File.join('app/assets/javascripts/views', class_path, "#{file_name}_view.js")
        template 'view.handlebars', File.join('app/assets/javascripts/templates', class_path, "#{file_name}.handlebars")
        invoke('ember:controller', [ file_name ], options)
        invoke('ember:route', [ file_name ], options)
      end

    end
  end
end
