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
    self.map ||= {"test" => "production"}

    # Returns the asset path containing Ember for the current Rails
    # environment. Defaults to development if no other version is found.
    def self.ember_path
      @ember_path ||= begin
        # Check for an enviroment mapping
        mapped_dir = Ember::Rails.map[::Rails.env]

        # Get the location, either mapped or based on Rails.env
        ember_root = File.expand_path("../../vendor/ember", __FILE__)
        ember_path = File.join(ember_root, mapped_dir || ::Rails.env)

        # Fall back on development if we couldn't find another version
        unless File.exist?(ember_path)
          ember_path = File.join(ember_root, "development")
        end

        ember_path
      end
    end
  end
end
