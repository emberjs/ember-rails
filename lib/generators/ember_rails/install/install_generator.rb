module EmberRails
  module Generators
    class InstallGenerator < Rails::Generators::Base

      EMBER_FILES = [ "ember.js", "ember-dev.js" ]
      RUNTIME_FILES = [ "ember-runtime.js", "ember-runtime-dev.js" ]
      ALL_FILES = [ *EMBER_FILES, *RUNTIME_FILES ]

      desc "Install Ember.js into your vendor folder"
      class_option :head, :type => :boolean, :default => false, :desc => "Download latest Ember.js from GitHub and copy it into your project"
      class_option :runtime, :type => :boolean, :default => false, :desc => "Include the Ember.js runtime only"

      def remove_ember
        ALL_FILES.each do |name|
          file = "vendor/assets/javascripts/#{name}"
          remove_file file if File.exist?(file)
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
              command = "git fetch --force --quiet --tags && git reset HEAD --hard"
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

          self.class.source_root File.join(git_root, "dist")

          ember_files.each do |name|
            source_file = if name.match /-dev/
              name.gsub /-dev/, ''
            else
              name.gsub /.js/, '.min.js'
            end

            copy_file source_file, "vendor/assets/javascripts/#{name}"
          end

        else

          self.class.source_root File.expand_path('../../../../../vendor/assets/javascripts', __FILE__)
          say_status("copying", "Ember.js (#{EmberRails::EMBER_VERSION})", :green)

          ember_files.each do |name|
            copy_file name, "vendor/assets/javascripts/#{name}"
          end

        end
      end

      private

        def ember_files
          options.runtime? ? RUNTIME_FILES : EMBER_FILES
        end

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
