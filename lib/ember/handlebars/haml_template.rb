require 'sprockets'
require 'sprockets/engines'
require 'ember/handlebars/source'

module Ember
  module Handlebars
    class HamlTemplate < Tilt::Template

      def self.default_mime_type
        'application/javascript'
      end

      def prepare; end

      def evaluate(scope, locals, &block)
        Haml::Engine.new(data).render
      end

    end
  end
end
