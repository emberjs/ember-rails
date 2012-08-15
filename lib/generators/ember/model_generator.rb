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
      EMBER_TYPE_LOOKUP = {
        nil       => 'string',

        binary:      'string',
        string:      'string',
        text:        'string',
        boolean:     'boolean',
        date:        'date',
        datetime:    'date',
        time:        'date',
        timestamp:   'date',
        decimal:     'number',
        float:       'number',
        integer:     'number',
        primary_key: 'number'
      }

      def parse_attributes!
        self.attributes = (attributes || []).map do |attr|
          name, type = attr.split(':')
          key = type.try(:to_sym)
          ember_type = EMBER_TYPE_LOOKUP[key] || type

          { name: name, type: ember_type }
        end
      end
    end
  end
end
