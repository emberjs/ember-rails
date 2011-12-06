require 'tilt/template'
require "execjs"

module SproutCoreRails

  # = Sprockets engine for HandlebarsJS templates
  class HjsTemplate < Tilt::Template

    def self.default_mime_type
      'application/javascript'
    end

    def initialize_engine
    end

    def prepare
    end

    # Generates Javascript code from a HandlebarsJS template.
    # The SC template name is derived from the lowercase logical asset path
    # by replacing non-alphanum characheters by underscores.
    def evaluate(scope, locals, &block)
      "SC.TEMPLATES[\"#{scope.logical_path}\"] = Handlebars.template(#{precompile(data)});\n"
    end

    private

      def precompile(template)
        runtime.call("SproutCoreRails.precompile", template)
      end

      def runtime
        Thread.current[:hjs_runtime] ||= ExecJS.compile(sproutcore)
      end

      def sproutcore
        [ "sproutcore-precompiler.js", "sproutcore-core.js" ].map do |name|
          File.read(File.expand_path(File.join(__FILE__, "..", "..", "..", "vendor/assets/javascripts/#{name}")))
        end.join("\n")
      end

  end

end
