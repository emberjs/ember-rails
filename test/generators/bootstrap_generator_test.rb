require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", "generator_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    copy_directory "app/assets/javascripts"
    copy_directory "config"
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

    test "create bootstrap with #{engine} engine" do
      run_generator ["--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/store.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/#{application_name.underscore}.js.#{engine}".sub('.js.js','.js')
      #assert_file "#{ember_path}/application.js.#{engine}".sub('.js.js','.js'),
      #  /Dummy = Ember.Application.create()/
    end

    test "create bootstrap with #{engine} engine and custom path" do
      custom_path = ember_path("custom")
      run_generator ["--javascript-engine=#{engine}", "-d", custom_path]
      assert_file "#{custom_path}/store.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/#{application_name.underscore}.js.#{engine}".sub('.js.js','.js')
      #assert_file "#{custom_path}/application.js.#{engine}".sub('.js.js','.js'),
      #  /Dummy = Ember.Application.create()/
    end

  end

  private

  def assert_invoked_generators_files(options = {})
    path = options[:in_path] || ember_path

    assert_file "#{path}/#{application_name}.js"
    assert_file "#{path}/router.js"
    assert_file "#{path}/store.js"
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers templates routes}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep" unless options[:skip_git]
    end

  end

  def application_name
    "Dummy"
  end

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end


end
