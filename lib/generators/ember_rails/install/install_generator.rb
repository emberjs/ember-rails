require 'rails'
require 'bundler'

module EmberRails
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      FILES = [ "ember.js", "ember-dev.js", "ember-runtime.js", "ember-runtime-dev.js" ]

      desc "This generator installs Ember.js #{EmberRails::EMBER_VERSION}"
      class_option :head, :type => :boolean, :default => false, :desc => "Download latest Ember.js from GitHub and copy it into your project"

      def remove_ember
        FILES.each do |name|
          remove_file "vendor/assets/javascripts/#{name}"
        end
      end

      def copy_ember
        if options.head?
          git_root = File.expand_path "~/.ember"
          gem_file = File.join git_root, "Gemfile"

          # If it doesn't exist yet
          unless File.exist?(git_root)
            command = %{git clone git://github.com/emberjs/ember.js.git "#{git_root}"}
            say_status("downloading", command, :green)

            cmd command
          else
            Dir.chdir git_root do
              command = "git fetch --force --quiet --tags && git reset --hard"
              say_status("updating", command, :green)

              cmd command
            end
          end

          Dir.chdir git_root do
            say_status("building", "bundle && bundle exec rake", :green)
            Bundler.with_clean_env do
              cmd "bundle --gemfile #{gem_file}"
              cmd %{BUNDLE_GEMFILE="#{gem_file}" bundle exec rake}
            end
          end

          self.class.source_root git_root

          Dir[File.join(git_root, "dist", "*.js")].each do |file|
            name = File.basename file
            if name.match /\.min/
              name.gsub! /\.min/, ''
            else
              name.gsub! /\.js/, '-dev.js'
            end
            copy_file file, "vendor/assets/javascripts/#{name}"
          end
        else
          self.class.source_root File.expand_path('../../../../../vendor/assets/javascripts', __FILE__)

          say_status("copying", "Ember.js (#{EmberRails::EMBER_VERSION})", :green)

          FILES.each do |name|
            copy_file name, "vendor/assets/javascripts/#{name}"
          end
        end
      end

      private

        def cmd(command)
          out = `#{command}`

          if $?.exitstatus != 0
            raise "Command error: command `#{command}` in directory #{Dir.pwd} has failed."
          end
          out
        end

    end
  end
end
