require 'ember/version'

module Ember
  module Generators
    class ControllerGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js controller"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_controller_files

        engine_extension = "js.#{options[:javascript_engine]}".sub('js.js','js')

        file_path = File.join('app/assets/javascripts/controllers', class_path, "#{file_name}_controller.#{engine_extension}")

        if options.array?
          template "array_controller.#{engine_extension}", file_path
        elsif options.object?
          template "object_controller.#{engine_extension}", file_path
        else
          template "controller.#{engine_extension}", file_path
        end
      end

    end
  end
end
