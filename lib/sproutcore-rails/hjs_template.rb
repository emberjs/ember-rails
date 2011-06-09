require 'tilt/template'

module SproutCoreRails
  class HjsTemplate < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def initialize_engine
    end

    def prepare
    end

    def evaluate(scope, locals, &block)
      template = data.dup
      template.gsub!(/"/, '\\"')
      template.gsub!(/\r?\n/, '\\n')
      template.gsub!(/\t/, '\\t')
      "SC.TEMPLATES[\"#{scope.logical_path.gsub(/\//, '_')}\"] = SC.Handlebars.compile(\"#{template}\");\n"
    end
  end
end
