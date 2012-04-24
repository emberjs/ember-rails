require 'ember/handlebars/source'

module Ember
  module Handlebars
    class Template < Tilt::Template
      def self.default_mime_type
        'application/javascript'
      end

      def prepare; end

      def evaluate(scope, locals, &block)
        if scope.pathname.to_s =~ /\.raw\.(handlebars|hjs|hbs)/
          "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}] = Handlebars.compile(#{indent(data).inspect});\n"
        else
          template = mustache_to_handlebars(scope, data)

          if configuration.precompile
            func = Ember::Handlebars.compile(template)
            "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}] = Ember.Handlebars.template(#{func});\n"
          else
            "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}] = Ember.Handlebars.compile(#{indent(template).inspect});\n"
          end
        end
      end

      private

      def mustache_to_handlebars(scope, template)
        if scope.pathname.to_s =~ /\.mustache\.(handlebars|hjs|hbs)/
          template.gsub(/\{\{(\w[^\}\}]+)\}\}/){ |x| "{{unbound #{$1}}}" }
        else
          template
        end
      end

      def template_path(path)
        root = configuration.templates_root

        unless root.blank?
          path.gsub!(/^#{Regexp.quote(root)}\/?/, '')
        end

        path = path.split('/')

        path.join(configuration.templates_path_separator)
      end

      def configuration
        ::Rails.configuration.handlebars
      end

      def indent(string)
        string.gsub(/$(.)/m, "\\1  ").strip
      end
    end
  end
end
