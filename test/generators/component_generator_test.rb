require 'test_helper'
require 'generators/ember/component_generator'

class ComponentGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ComponentGenerator

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

    test "default_component with #{engine} engine" do
      run_generator ["PostChart","--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/components/post-chart.js.#{engine}".sub('.js.js','.js')
      assert_file "app/assets/javascripts/templates/components/post-chart.hbs"
    end

  end

  test "Assert files are properly created (CamelCase)" do
    run_generator %w(PostChart)
    assert_file "#{ember_path}/components/post-chart.js"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert object names are properly created with CamelCase name" do
    run_generator %w(PostChart)
    assert_file "#{ember_path}/components/post-chart.js", /Dummy\.PostChartComponent/
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created (lower-case)" do
    run_generator %w(post-chart)
    assert_file "#{ember_path}/components/post-chart.js"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert object names are properly created with lower-case name" do
    run_generator %w(post-chart)
    assert_file "#{ember_path}/components/post-chart.js", /Dummy\.PostChartComponent/
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "PostChart", "-d", custom_path ]
    assert_file "#{custom_path}/components/post-chart.js"
    assert_file "#{custom_path}/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created with custom app name" do
    run_generator [ "PostChart", "-n", "MyApp" ]
    assert_file "#{ember_path}/components/post-chart.js", /MyApp\.PostChartComponent/
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Uses config.ember.app_name as the app name" do
    begin
      old, ::Rails.configuration.ember.app_name = ::Rails.configuration.ember.app_name, 'MyApp'

      run_generator %w(PostChart)
      assert_file "#{ember_path}/components/post-chart.js", /MyApp\.PostChartComponent/
    ensure
      ::Rails.configuration.ember.app_name = old
    end
  end

  test "Uses config.ember.ember_path" do
    begin
      custom_path = ember_path("custom")
      old, ::Rails.configuration.ember.ember_path = ::Rails.configuration.ember.ember_path, custom_path

      run_generator ["PostChart"]
      assert_file "#{custom_path}/components/post-chart.js"
      assert_file "#{custom_path}/templates/components/post-chart.hbs"
    ensure
      ::Rails.configuration.ember.ember_path = old
    end
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

end
