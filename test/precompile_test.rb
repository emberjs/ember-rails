require 'test_helper'

class PrecompileTest < TestCase
  def setup
    delete_assets!
  end

  def teardown
    ENV['RAILS_ENV'] = 'test'
    delete_assets!
  end

  def delete_assets!
    FileUtils.rm_rf app_path.join('public', 'assets')
  end

  def precompile!(rails_env)
    ENV['RAILS_ENV'] = rails_env

    quietly do 
      Dir.chdir(app_path){ `bundle exec rake assets:precompile` }
    end

    appjs = Dir["#{app_path}/public/assets/application.js"].first
    assert !appjs.nil?
    contents = File.read(appjs)
    assert_match /Ember\.VERSION/, contents
    assert_match /Handlebars\.VERSION/, contents
  end

  def app_path
    Pathname.new("#{File.dirname(__FILE__)}/dummy")
  end

  def test_precompile_succeeds_in_development_environment
    precompile! nil
  end

  def test_precompile_succeeds_in_production_environment
    precompile! 'production'
  end
end
