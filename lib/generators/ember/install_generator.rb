require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Install Ember.js into your vendor folder"
      class_option :head, :type => :boolean, :default => false, :desc => "Download latest Ember.js from GitHub and copy it into your project"

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
              command = "git fetch origin && git reset origin/master --hard"
              say_status("updating", command, :green)

              cmd command
            end
          end

          Dir.chdir git_root do
            say_status("building", "bundle && bundle exec rake clean dist", :green)
            Bundler.with_clean_env do
              cmd "bundle --gemfile #{gem_file}"
              cmd %{BUNDLE_GEMFILE="#{gem_file}" bundle exec rake clean dist}
            end
          end

          source_paths << File.join(git_root, "dist")

          copy_file "ember.js", "vendor/assets/ember/development/ember.js"
          copy_file "ember.min.js", "vendor/assets/ember/production/ember.js"
        end
      end

      def copy_ember_data
        if options.head?

          git_root = File.expand_path "~/.ember-data"
          gem_file = File.join git_root, "Gemfile"

          # If it doesn't exist yet
          unless File.exist?(git_root)
            command = %{git clone git://github.com/emberjs/data.git "#{git_root}"}
            say_status("downloading", command, :green)

            cmd command
          else
            Dir.chdir git_root do
              command = "git fetch origin && git reset origin/master --hard"
              say_status("updating", command, :green)

              cmd command
            end
          end

          Dir.chdir git_root do
            say_status("building", "bundle && bundle exec rake clean dist", :green)
            Bundler.with_clean_env do
              cmd "bundle --gemfile #{gem_file}"
              cmd %{BUNDLE_GEMFILE="#{gem_file}" bundle exec rake clean dist}
            end
          end

          source_paths << File.join(git_root, "dist")

          copy_file "ember-data.js", "vendor/assets/ember/development/ember-data.js"
          copy_file "ember-data.min.js", "vendor/assets/ember/production/ember-data.js"
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
