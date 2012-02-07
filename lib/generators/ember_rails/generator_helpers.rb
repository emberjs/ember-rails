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

    end
  end
end