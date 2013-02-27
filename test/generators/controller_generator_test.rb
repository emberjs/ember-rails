require 'test_helper'
require 'generators/ember/controller_generator'

class ControllerGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ControllerGenerator
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

  test "Assert files are properly created" do
    run_generator %w(ember)

    assert_file "#{ember_path}/controllers/ember_controller.js"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]

    assert_file "#{custom_path}/controllers/ember_controller.js"
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}"
  end

end
