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

    copy_directory "app/assets/javascripts/application.js"
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

  %w(js coffee em es6).each do |engine|

    test "create bootstrap with #{engine} engine" do
      run_generator ["--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/adapters/application.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/#{application_name.underscore}.js.#{engine}".sub('.js.js','.js')
      #assert_file "#{ember_path}/application.js.#{engine}".sub('.js.js','.js'),
      #  /Dummy = Ember.Application.create()/
    end

    test "create bootstrap with #{engine} engine and custom path" do
      custom_path = ember_path("custom")
      run_generator ["--javascript-engine=#{engine}", "-d", custom_path]
      assert_file "#{custom_path}/router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/adapters/application.js.#{engine}".sub('.js.js','.js')
      assert_file "#{custom_path}/#{application_name.underscore}.js.#{engine}".sub('.js.js','.js')
      #assert_file "#{custom_path}/application.js.#{engine}".sub('.js.js','.js'),
      #  /Dummy = Ember.Application.create()/
    end

    test "create bootstrap with #{engine} and custom app name" do
      run_generator ["--javascript-engine=#{engine}", "-n", "MyApp"]
      assert_file "#{ember_path}/router.js.#{engine}".sub('.js.js','.js'), /MyApp\.Router\.map|Ember\.Router\.extend/
      assert_file "#{ember_path}/adapters/application.js.#{engine}".sub('.js.js','.js'), /MyApp\.ApplicationAdapter|DS\.ActiveModelAdapter\.extend/
      assert_file "#{ember_path}/my_app.js.#{engine}".sub('.js.js','.js')
    end

  end

  test "adds requires to `application.js`" do
    run_generator

    assert_application_file_modified
  end

  test "creates `application.js` if it doesn't exist" do
    File.delete destination_root + '/app/assets/javascripts/application.js'

    run_generator

    assert_application_file_modified
  end

  test "modifies `application.js` it's empty" do
    File.write(destination_root + '/app/assets/javascripts/application.js', '')

    run_generator

    assert_application_file_modified
  end

  test "modifies `application.js` if require_tree doesn't exist and there's no new line" do
    File.write(destination_root + '/app/assets/javascripts/application.js', '//= require jquery')

    run_generator

    assert_application_file_modified
  end

  test "Uses config.ember.app_name as the app name" do
    begin
      old, ::Rails.configuration.ember.app_name = ::Rails.configuration.ember.app_name, 'MyApp'

      run_generator %w(ember)
      assert_file "#{ember_path}/router.js", /MyApp\.Router\.map/
      assert_file "#{ember_path}/adapters/application.js", /MyApp\.ApplicationAdapter = DS\.ActiveModelAdapter/
    ensure
      ::Rails.configuration.ember.app_name = old
    end
  end

  test "Uses config.ember.ember_path" do
    begin
      custom_path = ember_path("custom")
      old, ::Rails.configuration.ember.ember_path = ::Rails.configuration.ember.ember_path, custom_path

      run_generator
      assert_file "#{custom_path}/router.js"
      assert_file "#{custom_path}/#{application_name.underscore}.js"
    ensure
      ::Rails.configuration.ember.ember_path = old
    end
  end

  private

  def assert_application_file_modified(application_file = ember_path('application.js'))
    assert_file application_file, %r{//= require ember}
    assert_file application_file, %r{//= require ember-data}
    assert_file application_file, %r{//= require ./#{application_name.underscore}}
  end

  def assert_invoked_generators_files(options = {})
    path = options[:in_path] || ember_path

    assert_file "#{path}/application.js"
    assert_file "#{path}/#{application_name}.js"
    assert_file "#{path}/router.js"
    assert_file "#{path}/adapters/application.js"
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers components templates templates/components routes mixins adapters}.each do |dir|
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
