require "execjs"

module Ember
  module Handlebars
    class Source

      def self.precompiler_path
        File.expand_path(File.join(__FILE__, "../assets/ember-precompiler.js"))
      end

      def self.bundled_path
        File.expand_path(File.join(__FILE__, "..", "..", "..", "..",
          "vendor/assets/javascripts/ember.js"))
      end

      def self.path
        @path ||= ENV["EMBER_SOURCE_PATH"] || bundled_path
      end

      def self.path=(path)
        @contents = @version = @context = nil
        @path = path
      end

      def self.contents
        @contents ||= [File.read(precompiler_path), File.read(path)].join("\n")
      end

      def self.version
        @version ||= contents[/^Handlebars.VERSION = "([^"]*)"/, 1]
      end

      def self.context
        @context ||= ExecJS.compile(contents)
      end
    end

    class << self
      def version
        Source.version
      end

      def compile(template)
        template = template.read if template.respond_to?(:read)
        Source.context.call("EmberRails.precompile", template)
      end
    end
  end
end
