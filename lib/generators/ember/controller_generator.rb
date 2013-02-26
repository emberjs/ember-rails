require 'ember/version'

module Ember
  module Generators
    class ControllerGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js controller"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_controller_files
        file_path = File.join(ember_path, 'controllers', class_path, "#{file_name}_controller.js")
        if options.array?
          template 'array_controller.js', file_path
        elsif options.object?
          template 'object_controller.js', file_path
        else
          template 'controller.js', file_path
        end
      end
    end
  end
end
