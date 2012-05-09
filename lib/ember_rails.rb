require 'ember/rails/version'
require 'ember/version'
require 'ember/handlebars/version'
require 'ember/rails/engine'

module Ember
  module Rails
    # Create a map from Rails environments to versions of Ember.
    mattr_accessor :map

    # By default, production and test will both use minified Ember.
    # Add mappings in your environment files like so:
    #   Ember::Rails.map["staging"] = "production"
    # To use ember-spade, map development to spade:
    #   Ember::Rails.map["development"] = "spade"
    self.map ||= {"test" => "production"}

    def self.ember_locations
      @ember_locations ||= [
        # Application vendored Ember
        ::Rails.root.join("vendor/ember"),
        # Ember-rails vendored Ember
        File.expand_path("../../vendor/ember", __FILE__)
      ]
    end

    # Returns the asset path containing Ember for the current Rails
    # environment. Defaults to development if no other version is found.
    def self.ember_path
      @ember_path ||= begin
        # Check for an enviroment mapping
        mapped_dir = Ember::Rails.map[::Rails.env]

        # List of locations where Ember might be
        ember_options = ember_locations.map do |ember_root|
          [ # Get the location, either mapped or based on Rails.env
            File.join(ember_root, mapped_dir || ::Rails.env),
            # Fall back on development if we couldn't find another version
            File.join(ember_root, "development") ]
        end.flatten

        ember_options.first{|ember_path| File.exist?(ember_path) }
      end
    end
  end
end
