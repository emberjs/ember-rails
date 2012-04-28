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

    def self.ember_path
      @ember_path ||= begin
        mapped_dir = Ember::Rails.map[::Rails.env]
        vendored_ember = File.expand_path("../vendor/ember", __FILE__)
        File.join(vendored_ember, mapped_dir || ::Rails.env)
      end
    end
  end
end
