require 'ember/version'

module Ember
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("../../templates", __FILE__)
      argument :attributes, :type => :array, :default => [], :banner => "field[:type] field[:type] ..."

      desc "Creates a new Ember.js model"

      def create_model_files
        template 'model.js', File.join('app/assets/javascripts/models', class_path, "#{file_name}.js")
      end

    private

      def parse_attributes!
        self.attributes = (attributes || []).map do |attr|
          name, type = attr.split(':')
          type = 'string' if type == 'text'
          { name: name, type: type }
        end
      end
    end
  end
end
