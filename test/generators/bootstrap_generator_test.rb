require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp")

  setup :prepare_destination

  def prepare_destination
    super

    source = Rails.root.join("app/assets/javascripts")
    dest   = Rails.root.join("tmp/app/assets")

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
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

  private

  def assert_new_dirs(options = {})
    %W{models controllers views helpers templates}.each do |dir|
      assert_directory "#{ember_path}/#{dir}"
      assert_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
    end

    assert_directory "#{ember_path}/states"
    assert_file "#{ember_path}/states/app_states.js"
  end

  def ember_path
   "app/assets/javascripts"
  end

end
