require 'execjs'

module Ember
  module Handlebars
    class Source
      class << self
        def precompiler_path
          File.expand_path(File.join(__FILE__, '../assets/ember-precompiler.js'))
        end

        def vendor_path
          path = ::Rails.root.nil? ? '' : ::Rails.root.join('vendor/assets/javascripts/ember.js')

          if !File.exists?(path)
            path = File.expand_path(File.join(__FILE__, '../../../../vendor/ember/production/ember.js'))
          end
        end

        def path
          @path ||= ENV['EMBER_SOURCE_PATH'] || vendor_path
        end

        def contents
          @contents ||= begin
            config = ::Rails.application.config.ember
            handlebars = File.read(config.handlebars_location)
            ember = File.read(config.ember_location)
            precompiler = File.read(precompiler_path)

            [precompiler, handlebars, ember].join("\n")
          end
        end

        def handlebars_version
          @handlebars_version ||= contents[/^Handlebars.VERSION = "([^"]*)"/, 1]
        end

        def ember_version
          @ember_version ||= contents[/^Ember.VERSION = '([^']*)'/, 1]
        end

        def context
          @context ||= ExecJS.compile(contents)
        end
      end
    end

    class << self
      def compile(template)
        Source.context.call('EmberRails.precompile', template)
      end
    end
  end
end
