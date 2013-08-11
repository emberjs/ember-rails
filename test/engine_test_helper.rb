# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy_engine/config/engine.rb',  __FILE__)
require 'rails/generators'
require 'rails/test_help'
require 'fileutils'

# Remove tmp dir of dummy app before it's booted.
FileUtils.rm_rf "#{File.dirname(__FILE__)}/dummy_engine/tmp"

begin
  require 'minitest'
  TestCase = Minitest::Test
rescue LoadError
  require 'test/unit'
  puts 'minitest not found, falling back to test/unit'
  TestCase = Test::Unit::TestCase
end

require 'active_support/core_ext/kernel/reporting'
require 'pathname'

Rails.backtrace_cleaner.remove_silencers!
