require 'test_helper'
require 'generators/ember_rails/bootstrap/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests EmberRails::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp")

  setup :prepare_destination

  test "Assert folder layout and .gitkeep files are properly created" do
    run_generator

    assert_file "app/assets/javascripts/ember/dummy.js.coffee",
      /window.Dummy = Ember.Application.create()/
    assert_new_dirs_with_gitkeep_files
  end

  test "Assert folder layout is properly created without .gitkeep files" do
    run_generator %w(-g)

    assert_file "app/assets/javascripts/ember/dummy.js.coffee",
      /window.Dummy = Ember.Application.create()/
    assert_new_dirs
  end

  private

  def assert_new_dirs
    assert_file "app/assets/javascripts/ember/models"
    assert_file "app/assets/javascripts/ember/controllers"
    assert_file "app/assets/javascripts/ember/views"
    assert_file "app/assets/javascripts/ember/helpers"
    assert_file "app/assets/javascripts/ember/templates"
  end

  def assert_new_dirs_with_gitkeep_files
    assert_new_dirs
    assert_file "app/assets/javascripts/ember/models/.gitkeep"
    assert_file "app/assets/javascripts/ember/controllers/.gitkeep"
    assert_file "app/assets/javascripts/ember/views/.gitkeep"
    assert_file "app/assets/javascripts/ember/helpers/.gitkeep"
    assert_file "app/assets/javascripts/ember/templates/.gitkeep"
  end

end
