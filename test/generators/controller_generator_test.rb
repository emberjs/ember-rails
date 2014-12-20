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

  %w(js coffee em es6).each do |engine|

    test "array_controller with #{engine} engine" do
      run_generator ["posts", "--array", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/posts.js.#{engine}".sub('.js.js','.js')
    end

    test "object_controller with #{engine} engine" do
      run_generator ["post", "--object", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post.js.#{engine}".sub('.js.js','.js')
    end

    test "default_controller with #{engine} engine" do
      run_generator ["post","--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post.js.#{engine}".sub('.js.js','.js')
    end

    test "default_controller namespaced with #{engine} engine" do
      run_generator ["post/index","--javascript-engine=#{engine}"]
      assert_file "#{ember_path}/controllers/post/index.js.#{engine}".sub('.js.js','.js'), /PostIndexController|export default Ember\.Controller\.extend/
    end
  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{ember_path}/controllers/ember.js"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]
    assert_file "#{custom_path}/controllers/ember.js"
  end

  test "Assert files are properly created with custom app name" do
    run_generator [ "ember", "-n", "MyApp" ]
    assert_file "#{ember_path}/controllers/ember.js", /MyApp\.EmberController/
  end

  test "Uses config.ember.app_name as the app name" do
    begin
      old, ::Rails.configuration.ember.app_name = ::Rails.configuration.ember.app_name, 'MyApp'

      run_generator %w(ember)
      assert_file "#{ember_path}/controllers/ember.js", /MyApp\.EmberController/
    ensure
      ::Rails.configuration.ember.app_name = old
    end
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

end
