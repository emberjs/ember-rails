require 'sprockets'
require 'sprockets/engines'
require 'barber'

module Ember
  module Handlebars
    class Template < Tilt::Template
      def self.default_mime_type
        'application/javascript'
      end

      def prepare; end

      def evaluate(scope, locals, &block)
        target = template_target(scope)
        raw = handlebars?(scope)

        if raw
          template = data
        else
          template = mustache_to_handlebars(scope, data)
        end

        if configuration.precompile
          if raw
            template = precompile_handlebars(template)
          else
            template = precompile_ember_handlebars(template)
          end
        else
          if raw
            template = compile_handlebars(data)
          else
            template = compile_ember_handlebars(template)
          end
        end

        "#{target} = #{template}\n"
      end

      private

      def handlebars?(scope)
        scope.pathname.to_s =~ /\.raw\.(handlebars|hjs|hbs)/
      end

      def template_target(scope)
        "Ember.TEMPLATES[#{template_path(scope.logical_path).inspect}]"
      end

      def compile_handlebars(string)
        "Handlebars.compile(#{indent(string).inspect});"
      end

      def precompile_handlebars(string)
        Barber::FilePrecompiler.call(string)
      end

      def compile_ember_handlebars(string)
        "Ember.Handlebars.compile(#{indent(string).inspect});"
      end

      def precompile_ember_handlebars(string)
        Barber::Ember::FilePrecompiler.call(string)
      end

      def mustache_to_handlebars(scope, template)
        if scope.pathname.to_s =~ /\.mustache\.(handlebars|hjs|hbs)/
          template.gsub(/\{\{(\w[^\}\}]+)\}\}/){ |x| "{{unbound #{$1}}}" }
        else
          template
        end
      end

      def template_path(path)
        root = configuration.templates_root

        if root.kind_of? Array
          root.each do |root|
            path.sub!(/#{Regexp.quote(root)}\//, '')
          end
        else
          unless root.empty?
            path.sub!(/#{Regexp.quote(root)}\/?/, '')
          end
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
