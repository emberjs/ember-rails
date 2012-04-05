module EmberRails
  module Handlebars
    class Template < Tilt::Template
      def self.default_mime_type
        'application/javascript'
      end

      def prepare; end

      def evaluate(scope, locals, &block)
        template = mustache_to_handlebars(scope, data)

        if Rails.configuration.handlebars.precompile
          func = EmberRails::Handlebars.compile(template)
          "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}] = Ember.Handlebars.template(#{func});\n"
        else
          "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}] = Ember.Handlebars.compile(#{indent(template).inspect});\n"
        end
      end

      private

      def mustache_to_handlebars(scope, template)
        if scope.pathname.to_s =~ /\.mustache\.(handlebars|hjs)/
          template.gsub(/\{\{(\w[^\}\}]+)\}\}/){ |x| "{{unbound #{$1}}}" }
        else
          template
        end
      end

      def template_path(path)
        path = path.split('/')
        path.delete(Rails.configuration.handlebars.template_root)
        path.join(Rails.configuration.handlebars.template_path_separator)
      end

      def indent(string)
        string.gsub(/$(.)/m, "\\1  ").strip
      end
    end
  end
end
