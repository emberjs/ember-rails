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
        Haml::Engine.new(data).render(nil, {:h => view_context, :helpers => view_context})
      end

      def view_context
        Thread.current[:current_view_context] ||= build_view_context
      end

      def build_view_context
        ApplicationController.new.view_context.tap do |context|
          context.controller.request ||= ActionController::TestRequest.new
          context.request            ||= context.controller.request
          context.params             ||= {}
        end
      end

    end
  end
end
