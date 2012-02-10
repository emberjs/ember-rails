require 'generators/ember_rails/generator_helpers'

module EmberRails
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      include EmberRails::Generators::GeneratorHelpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates an ember model"

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      def create_ember_model
        template "model.coffee", "#{ember_path}/models/#{file_name}.js.coffee"
      end

    end
  end
end