# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/generators"
require "rails/test_help"
require "fileutils"

Rails.backtrace_cleaner.remove_silencers!
Rails.application.config.ember.handlebars_location = File.expand_path("../../vendor/ember/development/handlebars.js", __FILE__)
Rails.application.config.ember.ember_location = File.expand_path("../../vendor/ember/development/ember.js", __FILE__)


# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Remove tmp dir of dummy app
FileUtils.rm_rf "#{File.dirname(__FILE__)}/dummy/tmp"
