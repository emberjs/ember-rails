# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/generators"
require "rails/test_help"
require "fileutils"
require 'generators/ember/bootstrap_generator'

Rails.backtrace_cleaner.remove_silencers!
Rails.application.config.ember.handlebars_location = File.expand_path("../../vendor/ember/development/handlebars.js", __FILE__)
Rails.application.config.ember.ember_location = File.expand_path("../../vendor/ember/development/ember.js", __FILE__)


# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Remove tmp dir of dummy app
FileUtils.rm_rf "#{File.dirname(__FILE__)}/dummy/tmp"

def bootstrap
  BootstrapGeneratorSetupHelper.new.run_setup
end

def cleanup
  FileUtils.rm_rf File.join(Rails.root, "tmp")
end

class BootstrapGeneratorSetupHelper

  def run_setup
    prepare_destination
  end

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    copy_directory "app/assets/javascripts"
    copy_directory "config"
  end

end
