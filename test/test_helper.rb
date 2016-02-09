# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require 'fileutils'
# Remove tmp dir of dummy app before it's booted.
FileUtils.rm_rf "#{File.dirname(__FILE__)}/dummy/tmp"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/generators'
require 'rails/test_help'

begin
  require 'minitest'
  TestCase = Minitest::Test
rescue LoadError
  require 'test/unit'
  puts 'minitest not found, falling back to test/unit'
  TestCase = Test::Unit::TestCase
end

if Rails.version >= "4.0.0"
  IntegrationTest = ActionDispatch::IntegrationTest
else
  require 'json'
  IntegrationTest = ActionController::IntegrationTest
end

require 'active_support/core_ext/kernel/reporting'

Rails.backtrace_cleaner.remove_silencers!
