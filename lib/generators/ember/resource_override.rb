require "rails/generators"
require "rails/generators/rails/resource/resource_generator"
require "generators/ember/controller_generator"
require "generators/ember/view_generator"

module Rails
  module Generators
    ResourceGenerator.class_eval do
      class_option :ember, aliases: '-e', desc: 'force ember resource to generate', optional: true, type: 'boolean', default: false, banner: '--ember'

      def add_ember
        if options.ember
          say_status :invoke, "ember:model", :white
          with_padding do
            invoke "ember:model"
          end

          say_status :invoke, "ember controller and view (singular)", :white
          with_padding do
            invoke "ember:view", [singular_name], :object => true
          end

          @_invocations[Ember::Generators::ControllerGenerator].delete "create_controller_files"
          @_invocations[Ember::Generators::ViewGenerator].delete "create_view_files"

          say_status :invoke, "ember controller and view (plural)", :white
          with_padding do
            invoke "ember:view", [plural_name], :array => true
          end
        end
      end
    end
  end
end


