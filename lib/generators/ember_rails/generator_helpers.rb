module EmberRails
  module Generators
    module GeneratorHelpers
      
      def ember_path
        "app/assets/javascripts/ember"
      end

      def application_name
        if defined?(Rails) && Rails.application
          Rails.application.class.name.split('::').first
        else
          "app"
        end
      end

      def app_namespace
        application_name.camelize
      end

      def default_value(type)
        if type == :boolean
          "false"
        else
          "null"
        end
      end

    end
  end
end