module Ember
  module Generators
    module GeneratorHelpers

      def ember_path
        if options[:ember_path]
          options[:ember_path]
        elsif rails_engine?
          "app/assets/javascripts/#{engine_name}"
        elsif configuration.ember_path
          configuration.ember_path
        else
          "app/assets/javascripts"
        end
      end

      def rails_engine?
        defined?(ENGINE_PATH)
      end

      def engine_name
        ENGINE_PATH.split('/')[-2]
      end

      def application_name
        if options[:app_name]
          options[:app_name]
        elsif rails_engine?
          engine_name
        elsif configuration.app_name
          configuration.app_name
        elsif defined?(::Rails) && ::Rails.application
          ::Rails.application.class.name.split('::').first
        else
          "App"
        end
      end

      def class_name
        (class_path + [file_name]).map!{ |m| m.camelize }.join()
      end

      def handlebars_template_path
        File.join(class_path, file_name).gsub(/^\//, '')
      end

      def engine_extension
        @engine_extension ||= "js.#{options[:javascript_engine]}".sub('js.js','js')
      end

      def configuration
        if defined?(::Rails) && ::Rails.configuration
          ::Rails.configuration.ember
        end
      end
    end
  end
end
