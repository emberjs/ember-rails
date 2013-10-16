require 'generators/ember/generator_helpers'
require 'net/http'
require 'uri'
require 'fileutils'


module Ember
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      class InvalidChannel < ::Thor::Error; end
      class ConflictingOptions < ::Thor::Error; end
      class Deprecated < ::Thor::Error; end

      ::InvalidChannel = InvalidChannel
      ::ConflictingOptions = ConflictingOptions
      ::Deprecated = Deprecated

      class EmberGenerator
        def ember
          super()
        end
      end

      desc "Install Ember.js into your vendor folder"
      class_option :head, :type => :boolean, :default => false, :desc => "Download Ember.js & Ember data from canary channel. This is deprecated. Use channel instead."
      class_option :channel, :type => :string, :required => false, :desc => "Ember release channel Choose between 'release', 'beta' or 'canary'"
      class_option :ember_only, :type => :boolean, :required => false, :desc => "Only download Ember."
      class_option :ember_data_only, :type => :boolean, :required => false, :desc => "Onky download ember-data"

      def initialize(args = [], options = {}, config = {})
        super(args, options, config)
        check_options
        process_options
      end


      def ember
        unless options.ember_data_only?
          get_ember_js_for(:development)
          get_ember_js_for(:production)
        end
      end

      def ember_data
        begin
          unless options.ember_only?
            get_ember_data_for(:development)
            get_ember_data_for(:production)
          end
        rescue Thor::Error
          say('WARNING: no ember-data files on this channel yet' , :yellow)
        end
      end

    private

      def get_ember_data_for(environment)
        create_file "vendor/assets/ember/#{environment}/ember-data.js" do
          fetch "#{base_url}/#{channel}/ember-data.js", "vendor/assets/ember/#{environment}/ember-data.js"
        end
      end

      def get_ember_js_for(environment)
        create_file "vendor/assets/ember/#{environment}/ember.js" do
          fetch "#{base_url}/#{channel}/ember.js", "vendor/assets/ember/#{environment}/ember.js"
        end
      end

      def check_options
        if options.head? 
          say('WARNING: --head option is deprecated in favor of --channel=cannary' , :yellow)
        end
        if options.head? && options.channel?
          say 'ERROR: conflicting options. --head and --channel. Use either --head or --channel=<channel>', :red
          raise ConflictingOptions
        end
        if options.channel? && !%w(release beta canary).include?(options[:channel])
          say 'ERROR: channel can either be release, beta or canary', :red
          raise InvalidChannel
        end
      end

      def process_options
        if options.head? 
          @channel = :canary
        end
      end

      def base_url
        'http://builds.emberjs.com'
      end

      def channel
        if options.channel
          @channel ||= options[:channel]
        else
          @channel ||= :release
        end
      end


      def fetch(from, to)
        message = "#{from} -> #{to}"
        say_status("downloading:", message , :green)

        uri = URI(from)
        output = StringIO.new
        output.puts "// Fetched from: " + uri.to_s
        output.puts "// Fetched on: " + Time.now.utc.iso8601.to_s
        output.puts Net::HTTP.get(uri).force_encoding("UTF-8")
        output.rewind
        content = output.read
        if content.include?('404')
          say "ERROR: Error reading the content from the channel with url #{from}." , :red
          raise raise Thor::Error
        end
        content
      end
    end
  end
end
