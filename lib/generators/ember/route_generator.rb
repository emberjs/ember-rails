require 'ember/version'

module Ember
  module Generators
    class RouteGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js route"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"


      def create_route_files
        engine_extension = "js.#{options[:javascript_engine]}".sub('js.js','js')
        file_path = File.join('app/assets/javascripts/routes', class_path, "#{file_name}_route.#{engine_extension}")
        template "route.#{engine_extension}", file_path
      end
    end
  end
end
