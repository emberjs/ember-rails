module EmberRails
  module Generators
    class BootstrapGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts/ember"
      argument :application_name, :type => :string, :default => "app"

      class_option :skip_git, :type => :boolean, :aliases => "-g", :default => false, :desc => "Skip Git keeps"

      def inject_ember
        application_file = "app/assets/javascripts/application.js"
        if File.exists? application_file
          inject_into_file(application_file, :before => "//= require_tree") do
            dependencies = [
              "//= require ember",
              "//= require ember/#{application_name.underscore}"
            ]
            dependencies.join("\n").concat("\n")
          end
        end
      end

      def create_dir_layout
        %W{models controllers views helpers templates}.each do |dir|
          empty_directory "app/assets/javascripts/ember/#{dir}"
          create_file "app/assets/javascripts/ember/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def create_app_file
        template "app.coffee", "app/assets/javascripts/ember/#{application_name.underscore}.js.coffee"
      end

    end

  end
end
