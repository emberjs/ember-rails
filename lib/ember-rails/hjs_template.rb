require 'tilt/template'
require "execjs"

module EmberRails

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
    # The Ember template name is derived from the lowercase logical asset path
    # by replacing non-alphanum characheters by underscores.
    def evaluate(scope, locals, &block)
      "Ember.TEMPLATES[\"#{scope.logical_path}\"] = Handlebars.template(#{precompile(data)});\n"
    end

    private

      def precompile(template)
        runtime.call("EmberRails.precompile", template)
      end

      def runtime
        Thread.current[:hjs_runtime] ||= ExecJS.compile(ember)
      end

      def ember
        [ "ember-precompiler.js", "ember.js" ].map do |name|
          File.read(File.expand_path(File.join(__FILE__, "..", "..", "..", "vendor/assets/javascripts/#{name}")))
        end.join("\n")
      end

  end

end
