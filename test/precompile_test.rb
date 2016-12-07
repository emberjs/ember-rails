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

    FileUtils.cd(app_path) do
      output = `rake assets:precompile 2>&1`
      assert $?.exitstatus == 0, "running: 'rake assets:precompile' failed.\n#{output}"
    end

    application_js_path = Dir["#{app_path}/public/assets/application*.js"].first

    assert application_js_path, 'application.js should be present'

    contents = File.read(application_js_path)

    assert_match %r{Ember\.VERSION|_emberVersion\.default}, contents, 'application.js should contain Ember.VERSION'
    assert_match %r{Handlebars\.VERSION|COMPILER_REVISION}, contents, 'applciation.js should contain Handlebars.VERSION'
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

  def test_precompile_succeeds_in_test_environment
    precompile! 'test'
  end
end
