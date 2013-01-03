require 'ember/version'

module Ember
  module Generators
    class RouteGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js route"

      def create_route_files
        file_path = File.join('app/assets/javascripts/routes', class_path, "#{file_name}_route.js")
        template 'route.js', file_path
      end
    end
  end
end
