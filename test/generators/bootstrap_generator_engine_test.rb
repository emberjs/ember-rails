require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorEngineTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator
  destination Rails.root.join('tmp', 'generator_engine_test_output')

  setup :prepare_destination
  teardown :cleanup

  def copy_directory(dir)
    source = File.join(ENGINE_ROOT, dir)
    dest = File.join(ENGINE_ROOT, "tmp", "generator_engine_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    load File.expand_path('../../dummy/config/engine.rb', __FILE__)
    copy_directory "app/assets/javascripts"
    copy_directory "config"
  end

  def cleanup
    Object.send(:remove_const, :ENGINE_ROOT)
    Object.send(:remove_const, :ENGINE_PATH)
  end

  test "Assert folder layout and .gitkeep files are properly created in a rails engine" do
    run_generator
    assert_new_dirs(:skip_git => false)
  end

  test "Assert folder layout is properly created without .gitkeep files in a rails engine" do
    run_generator %w(-g)
    assert_new_dirs(:skip_git => true)
  end

  %w(js coffee em es6).each do |engine|

    test "create bootstrap in a rails engine with #{engine}" do
      run_generator ["--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/adapters/application.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/#{engine_name}.js.#{engine}".sub('.js.js','.js')
    end

    test "create bootstrap in a rails engine with #{engine} engine and custom path" do
      custom_path = ember_path("custom")
      run_generator ["--javascript-engine=#{engine}", "-d", custom_path]
      assert_file "#{custom_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/adapters/application.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/#{engine_name}.js.#{engine}".sub('.js.js','.js')
    end

    test "create bootstrap in a rails engine with #{engine} and custom app name" do
      run_generator ["--javascript-engine=#{engine}", "-n", "MyEngine"]
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js'), /MyEngine\.Router\.map|Ember\.Router\.extend/
      assert_file "#{ember_path}/adapters/application.js.#{engine}".sub('.js.js','.js'), /MyEngine\.ApplicationAdapter|DS\.ActiveModelAdapter\.extend/
      assert_file "#{ember_path}/my-engine.js.#{engine}".sub('.js.js','.js')
    end
  end

  private

  def ember_path(custom_path = nil)
    "app/assets/javascripts/#{custom_path || engine_name}"
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers components templates templates/components routes mixins adapters}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep" unless options[:skip_git]
    end
  end

  def engine_name
    "dummy"
  end

end
