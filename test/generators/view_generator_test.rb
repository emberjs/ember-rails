require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator

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

    test "create view with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post.#{engine_to_extension(engine)}", /templateName: 'post'/
      assert_no_file "app/assets/javascripts/templates/post.hbs"
    end

    test "create view and template with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}", "--with-template"]
      assert_file "app/assets/javascripts/views/post.#{engine_to_extension(engine)}"
      assert_file "app/assets/javascripts/templates/post.hbs"
    end

    test "create namespaced view with #{engine} engine" do
      run_generator ["post/index", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post/index.#{engine_to_extension(engine)}", /PostIndexView|export default Ember\.View\.extend/
    end

  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{ember_path}/views/ember.js"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]
    assert_file "#{custom_path}/views/ember.js"
  end

  test "Assert files are properly created with custom app name" do
    run_generator [ "ember", "-n", "AppName" ]
    assert_file "app/assets/javascripts/views/ember.js", /AppName\.EmberView/
  end

  test "Uses config.ember.app_name as the app name" do
    begin
      old, ::Rails.configuration.ember.app_name = ::Rails.configuration.ember.app_name, 'MyApp'

      run_generator %w(ember)
      assert_file "app/assets/javascripts/views/ember.js", /MyApp\.EmberView/
    ensure
      ::Rails.configuration.ember.app_name = old
    end
  end

  test "Uses config.ember.ember_path" do
    begin
      custom_path = ember_path("custom")
      old, ::Rails.configuration.ember.ember_path = ::Rails.configuration.ember.ember_path, custom_path

      run_generator [ "ember"]
      assert_file "#{custom_path}/views/ember.js"
    ensure
      ::Rails.configuration.ember.ember_path = old
    end
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

  def engine_to_extension(engine)
    engine = "module.#{engine}" if engine == 'es6'
    engine
  end

end
