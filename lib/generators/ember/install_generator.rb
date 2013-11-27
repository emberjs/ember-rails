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
      class InsufficientOptions < ::Thor::Error; end

      ::InvalidChannel = InvalidChannel
      ::ConflictingOptions = ConflictingOptions
      ::Deprecated = Deprecated
      ::InsufficientOptions = InsufficientOptions

      desc "Install Ember.js into your vendor folder"
      class_option :head,
        :type => :boolean, 
        :default => false, 
        :desc => "Download Ember.js & Ember data from canary channel. This is deprecated. Use channel instead."
      class_option :channel,
        :type => :string,
        :required => false,
        :desc => "Ember release channel Choose between 'release', 'beta' or 'canary'"
      class_option :ember_only, 
        :type => :boolean, 
        :required => false, 
        :desc => "Only download Ember.",
        :aliases => '--ember'
      class_option :ember_data_only,
        :type => :boolean, 
        :required => false, 
        :desc => "Only download ember-data", 
        :aliases => '--ember-data'
      class_option :tag,
        :type => :string,
        :required => false, 
        :desc => "Download taged release use syntax v1.0.0-beta.3/ember-data & v1.0.0-rc.8/ember"

      def initialize(args = [], options = {}, config = {})
        super(args, options, config)
        check_options
        process_options
      end


      def ember
        begin
          unless options.ember_data_only?
            get_ember_js_for(:development)
            get_ember_js_for(:production)
          end
        rescue Thor::Error
          say('WARNING: no ember files on this channel or tag' , :yellow)
        end
      end

      def ember_data
        begin
          unless options.ember_only?
            get_ember_data_for(:development)
            get_ember_data_for(:production)
          end
        rescue Thor::Error
          say('WARNING: no ember-data files on this channel or tag' , :yellow)
        end
      end

    private


      def get_ember_data_for(environment)
        # temporarily using a variable here until a stable release of
        # ember-data is released so that installing with ember-data
        # *just works*.
        chan = if channel == :release
          say_status("downloading:", 'Ember Data is not available on the :release channel. Falling back to beta channel.' , :yellow)          
          :beta
        else
          channel
        end
        create_file "vendor/assets/ember/#{environment}/ember-data.js" do
          fetch "#{base_url}/#{chan}/#{file_name_for('ember-data', environment)}", "vendor/assets/ember/#{environment}/ember-data.js"
        end
      end

      def get_ember_js_for(environment)

        create_file "vendor/assets/ember/#{environment}/ember.js" do
          fetch "#{base_url}/#{channel}/#{file_name_for('ember', environment)}", "vendor/assets/ember/#{environment}/ember.js"
        end
      end

      def file_name_for(component,environment)
        case environment
        when :production
          "#{component}.min.js"
        when :development
          "#{component}.js"
        end
      end

      def check_options
        if options.head?
          say('WARNING: --head option is deprecated in favor of --channel=canary' , :yellow)
        end
        if options.head? && options.channel?
          say 'ERROR: conflicting options. --head and --channel. Use either --head or --channel=<channel>', :red
          raise ConflictingOptions
        end
        if options.channel? && !%w(release beta canary).include?(options[:channel])
          say 'ERROR: channel can either be release, beta or canary', :red
          raise InvalidChannel
        end
        if options.channel? && options.tag?
          say 'ERROR: conflicting options. --tag and --channel. --tag is incompatible with other options', :red
          raise ConflictingOptions
        end
        if options.head? && options.tag?
          say 'ERROR: conflicting options. --tag and --head. --tag is incompatible with other options', :red
          raise ConflictingOptions
        end
        if options.tag? && !(options.ember_only? || options.ember_data_only?)
          say 'ERROR: insufficient options. --tag needs to be combined with eithe --ember or --ember-data', :red
          raise InsufficientOptions
        end
      end

      def process_options
        if options.head? 
          @channel = :canary
        end
        if options.tag?
          @channel = "tags/#{options.tag}"
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
        output.puts "// Fetched from channel: #{channel}, with url " + uri.to_s
        output.puts "// Fetched on: " + Time.now.utc.iso8601.to_s
        response = Net::HTTP.get_response(uri)
        case response.code
        when '404'
          say "ERROR: Error reading the content from the channel with url #{from}. File not found" , :red
          raise Thor::Error
        when '200'
          output.puts response.body.force_encoding("UTF-8")
        else
          say "ERROR: Unexpected error with status #{response.code} reading the content from the channel with url #{from}." , :red
          raise Thor::Error
        end
        output.rewind
        content = output.read
      end
    end
  end
end
