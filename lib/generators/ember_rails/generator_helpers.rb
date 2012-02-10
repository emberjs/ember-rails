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
        case type
        when :array    then "[]"
        when :boolean  then "false"
        when :function then "->\n\t\treturn"
        when :object   then "{}"
        else "null"
        end
      end

    end
  end
end