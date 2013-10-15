require 'generators/ember/generator_helpers'
require 'net/http'
require 'uri'
require 'fileutils'

module Ember
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Install Ember.js into your vendor folder"
      class_option :head, :type => :boolean, :default => false, :desc => "Download latest Ember.js from GitHub and fetch it into your project"
      class_option :release, :type => :string, :required => false, :desc => "Release type of ember. Choose between 'head', 'beta' or 'canary'"


      def release_type
        if options.head? && options.release
          say_status('conflicting options', '--head prevailed over --release option' , :red)
        end
        if options.head?
          ''
        else
          options['release'] + '/'
        end
      end

      def fetch_ember
        fetch "http://builds.emberjs.com/#{release_type}ember-latest.js", 'vendor/assets/ember/development/ember.js'
        fetch "http://builds.emberjs.com/#{release_type}ember-latest.min.js", 'vendor/assets/ember/production/ember.js'
      end

      def fetch_ember_data
        fetch "http://builds.emberjs.com/#{release_type}ember-data-latest.js", 'vendor/assets/ember/development/ember-data.js'
        fetch "http://builds.emberjs.com/#{release_type}ember-data-latest.min.js", 'vendor/assets/ember/production/ember-data.js'
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
          output.puts Net::HTTP.get(uri).force_encoding("UTF-8")
        end
      end
    end
  end
end
