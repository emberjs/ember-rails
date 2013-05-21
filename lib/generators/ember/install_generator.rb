require 'generators/ember/generator_helpers'
require 'net/http'
require 'uri'
require 'fileutils'

module Ember
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Install Ember.js into your vendor folder"
      class_option :head, :type => :boolean, :default => false, :desc => "Download latest Ember.js from GitHub and fetch it into your project"

      def fetch_ember
        if options.head?
          fetch 'http://builds.emberjs.com/ember-latest.js', 'vendor/assets/ember/development/ember.js'
          fetch 'http://builds.emberjs.com/ember-latest.min.js', 'vendor/assets/ember/production/ember.js'
        end
      end

      def fetch_ember_data
        if options.head?
          fetch 'http://builds.emberjs.com/ember-data-latest.js', 'vendor/assets/ember/development/ember.js'
          fetch 'http://builds.emberjs.com/ember-data-latest.min.js', 'vendor/assets/ember/production/ember.js'
        end
      end

    private

      def fetch(from, to)
        message = "#{from} -> #{to}"
        say_status("downloading:", message , :green)

        uri = URI(from)

        FileUtils.mkdir_p File.dirname(to)

        open(to, 'w+') do |output|
          output.puts Net::HTTP.get(uri).force_encoding("UTF-8")
        end
      end
    end
  end
end
