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

  %w(js coffee).each do |engine|

    test "array_controller with #{engine} engine" do

      run_generator ["post", "--array", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post_controller.js.#{engine}".sub('.js.js','.js')
    end

    test "object_controller with #{engine} engine" do
      run_generator ["post", "--object", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post_controller.js.#{engine}".sub('.js.js','.js')
    end

    test "default_controller with #{engine} engine" do
      run_generator ["post","--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post_controller.js.#{engine}".sub('.js.js','.js')
    end

    test "default_controller namespaced with #{engine} engine" do
      run_generator ["post/index","--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/controllers/post/index_controller.js.#{engine}".sub('.js.js','.js'), /PostIndexController/
    end
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
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

end
