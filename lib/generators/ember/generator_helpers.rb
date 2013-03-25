module Ember
  module Generators
    module GeneratorHelpers

      def ember_path
        options[:ember_path] || "app/assets/javascripts"
      end

      def application_name
        if defined?(::Rails) && ::Rails.application
          ::Rails.application.class.name.split('::').first
        else
          "app"
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
