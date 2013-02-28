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

    assert_file "app/assets/javascripts/application.js",
      /Dummy = Ember.Application.create()/
    assert_new_dirs(:skip_git => false)
  end

  test "Assert folder layout is properly created without .gitkeep files" do
    run_generator %w(-g)

    assert_file "app/assets/javascripts/application.js",
      /Dummy = Ember.Application.create()/
    assert_new_dirs(:skip_git => true)
  end

  test "Assert folder layout is properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "-d", custom_path ]

    assert_file "app/assets/javascripts/application.js",
      /Dummy = Ember.Application.create()/
    assert_new_dirs(:skip_git => false, :in_path => custom_path)
  end

  test "Assert application stubs" do
    run_generator

    assert_invoked_generators_files
  end

  test "Assert application stubs with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "-d", custom_path ]

    assert_invoked_generators_files(:in_path => custom_path)
  end

  private

  def assert_invoked_generators_files(options = {})
    path = options[:in_path] || ember_path

    assert_file "#{path}/views/application_view.js"
    assert_file "#{path}/templates/application.handlebars"
    assert_file "#{path}/controllers/application_controller.js"
    assert_file "#{path}/routes/application_route.js"
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers templates}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep" unless options[:skip_git]
    end

    assert_directory "#{path}/routes"
    assert_file "#{path}/router.js"
  end

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}"
  end

end
