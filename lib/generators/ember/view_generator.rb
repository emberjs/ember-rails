require 'ember/version'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated Handlebars template"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"

      def create_view_files
        template 'view.js', File.join('app/assets/javascripts/views', class_path, "#{file_name}_view.js")
        template 'view.handlebars', File.join('app/assets/javascripts/templates', class_path, "#{file_name}.handlebars")
        generate 'ember:controller', file_name, "--array" if options[:array]
        generate 'ember:controller', file_name unless options[:array]
      end

    end
  end
end
