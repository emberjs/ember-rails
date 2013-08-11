require 'engine_test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorEngineTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator
  destination File.join(ENGINE_ROOT, "tmp", "generator_engine_test_output")

  setup :prepare_destination

  def copy_directory(dir)
    source = File.join(ENGINE_ROOT, dir)
    dest = File.join(ENGINE_ROOT, "tmp", "generator_engine_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    copy_directory "app/assets/javascripts"
  end

  test "Assert folder layout and .gitkeep files are properly created" do
    run_generator
    assert_new_dirs(:skip_git => false)
  end

  test "Assert folder layout is properly created without .gitkeep files" do
    run_generator %w(-g)
    assert_new_dirs(:skip_git => true)
  end

  %w(js coffee).each do |engine|

    test "create bootstrap with #{engine}" do
      run_generator ["--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/store.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/app.js.#{engine}".sub('.js.js','.js')
    end

    test "create bootstrap with #{engine} and custom app name" do
      run_generator ["--javascript-engine=#{engine}", "-n", "MyEngine"]
      assert_file "#{ember_path}/store.js.#{engine}".sub('.js.js','.js'), /MyEngine\.Store/
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js'), /MyEngine\.Router\.map/
      assert_file "#{ember_path}/my_engine.js.#{engine}".sub('.js.js','.js')
    end
  end

  private

  def ember_path(custom_path = nil)
    "app/assets/javascripts/#{custom_path || engine_name}"
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers templates routes}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep" unless options[:skip_git]
    end
  end

  def engine_name
    "dummy_engine"
  end

end
