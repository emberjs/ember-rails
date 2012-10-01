require 'ember/version'

module Ember
  module Generators
    class ControllerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js controller"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"
      class_option :coffeescript, :type => :boolean, :default => false, :desc => "Generate as coffeescript files"

      def create_controller_files
        file_path = File.join('app/assets/javascripts/controllers', class_path, "#{file_name}_controller.js")
        if options.array?
          generate_template_for 'array_controller.js', file_path
        elsif options.object?
          generate_template_for 'object_controller.js', file_path
        else
          generate_template_for 'controller.js', file_path
        end
      end

      private
      def generate_template_for(template_name, file_path)
        template_name += ".coffee" if options.coffeescript?
        file_path     += ".coffee" if options.coffeescript?
        template template_name, file_path
      end
    end
  end
end
