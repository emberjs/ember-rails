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
    assert_new_dirs(skip_git: false)
  end

  test "Assert folder layout is properly created without .gitkeep files" do
    run_generator %w(-g)

    assert_file "app/assets/javascripts/ember/dummy.js.coffee",
      /window.Dummy = Ember.Application.create()/
    assert_new_dirs(skip_git: true)
  end

  private

  def assert_new_dirs(options = {})
    %W{models controllers views helpers templates}.each do |dir|
      assert_directory "#{ember_path}/#{dir}"
      assert_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
    end
  end

  def ember_path
   "app/assets/javascripts/ember"
  end

end
