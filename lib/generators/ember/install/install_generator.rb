module Ember
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :application_name, type: :string, default: "app"

      desc "Installs ember.js with a default folder layout in app/assets/javascripts/ember"

      class_option :skip_git, type: :boolean, aliases: "-g",
                   default: false,  desc: "Skip Git keeps"

      def inject_ember
        inject_into_file("app/assets/javascripts/application.js", 
                         before: "//= require_tree") do
          dependencies = [
            "//= require ember",
            "//= require ember/#{application_name.underscore}"
          ]
          dependencies.join("\n").concat("\n")
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