module Ember
  module Handlebars
    class HamlTemplate < Template
      def evaluate(scope, locals, &block)
        haml_template = Tilt::HamlTemplate.new { data }
        @data = haml_template.render
        super
      end
    end
  end
end
