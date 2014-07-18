require "rails/generators"
require "rails/generators/rails/resource/resource_generator"
require "generators/ember/controller_generator"
require "generators/ember/view_generator"

module Rails
  module Generators
    ResourceGenerator.class_eval do

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :with_template, :type => :boolean, :default => false, :desc => "Create template for this view"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def add_ember
        say_status :invoke, "ember:model", :white
        with_padding do
          invoke "ember:model"
        end

        say_status :invoke, "ember controller and view (singular)", :white
        with_padding do
          invoke "ember:view", [singular_name], options.merge(:object => true)
        end

        @_invocations[Ember::Generators::ControllerGenerator].delete "create_controller_files"
        @_invocations[Ember::Generators::ViewGenerator].delete "create_view_files"

        say_status :invoke, "ember controller and view (plural)", :white
        with_padding do
          invoke "ember:view", [plural_name], options.merge(:array => true)
        end
      end
    end
  end
end


