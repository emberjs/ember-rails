require 'tilt/template'

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
      template = data.dup
      template.gsub!(/"/, '\\"')
      template.gsub!(/\r?\n/, '\\n')
      template.gsub!(/\t/, '\\t')
      "SC.TEMPLATES[\"#{scope.logical_path}\"] = SC.Handlebars.compile(\"#{template}\");\n"
    end
  end
end
