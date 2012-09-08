require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator

  destination File.join(Rails.root, "tmp")

  setup :prepare_destination

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", File.dirname(dir))

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

      assert_file "app/assets/javascripts/application.js.#{engine}".sub('.js.js','.js'),
        /Dummy = Ember.Application.create()/

      assert_file "#{ember_path}/store.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/routes/app_router.js.#{engine}".sub('.js.js','.js')
      assert_file "#{ember_path}/#{application_name.underscore}.js.#{engine}".sub('.js.js','.js')
    end

  end


  private

  def assert_new_dirs(options = {})
    %W{models controllers views helpers templates}.each do |dir|
      assert_directory "#{ember_path}/#{dir}"
      assert_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
    end

    assert_directory "#{ember_path}/routes"
  end

  def ember_path
    "app/assets/javascripts"
  end
  def application_name
    "Dummy"
  end


end
