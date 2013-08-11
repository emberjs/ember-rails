module Ember
  module Generators
    module GeneratorHelpers

      def ember_path
        if rails_engine?
          options[:ember_path] || "app/assets/javascripts/#{engine_name}"
        else
          options[:ember_path] || "app/assets/javascripts"
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
    end
  end
end
