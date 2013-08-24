require 'generators/ember/generator_helpers'
require 'net/http'
require 'uri'
require 'fileutils'
require 'zlib'

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
          fetch 'http://builds.emberjs.com/ember-data-latest.js', 'vendor/assets/ember/development/ember-data.js'
          fetch 'http://builds.emberjs.com/ember-data-latest.min.js', 'vendor/assets/ember/production/ember-data.js'
        end
      end

    private

      def fetch(from, to)
        message = "#{from} -> #{to}"
        say_status("downloading:", message , :green)

        uri = URI(from)

        FileUtils.mkdir_p File.dirname(to)

        open(to, 'w+') do |output|
          output.puts "// Fetched from: " + uri.to_s
          output.puts "// Fetched on: " + Time.now.utc.iso8601.to_s
          output.puts get_raw_data(uri)
        end
      end

      def get_raw_data(uri)
        response = Net::HTTP.get_response(uri)
        output   = if response["content-encoding"] == 'gzip'
                     Zlib::GzipReader.new(StringIO.new(response.body), encoding: "ASCII-8BIT").read
                   else
                     response.body
                   end

        output.force_encoding("UTF-8")
      end
    end
  end
end
