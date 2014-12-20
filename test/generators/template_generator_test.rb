require 'test_helper'
require 'generators/ember/template_generator'

class TemplateGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::TemplateGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")
  setup :prepare_destination

  %w(js coffee em es6).each do |engine|
    test "template with #{engine} as current engine" do
      run_generator ["post", "--javascript-engine", engine]
      assert_file "app/assets/javascripts/templates/post.hbs"
    end
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "post", "-d", custom_path ]
    assert_file "#{custom_path}/templates/post.hbs"
  end

  test "Uses config.ember.ember_path" do
    begin
      custom_path = ember_path("custom")
      old, ::Rails.configuration.ember.ember_path = ::Rails.configuration.ember.ember_path, custom_path

      run_generator ["post"]
      assert_file "#{custom_path}/templates/post.hbs"
    ensure
      ::Rails.configuration.ember.ember_path = old
    end
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}"
  end
end

