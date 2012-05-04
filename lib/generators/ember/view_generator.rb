require 'ember/version'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)
      argument :controller_name, :type => :string, :required => true, :desc => "The controller name for this view"
      
      desc "Creates a new Ember.js view and associated Handlebars template"
      
      def create_model_files
        template 'view.js', File.join('app/assets/javascripts/views/' + controller_name, class_path, "#{file_name}_view.js")
        template 'view.handlebars', File.join('app/assets/javascripts/templates/' + controller_name, class_path, "#{file_name}.handlebars")
      end
      
    end
  end
end
