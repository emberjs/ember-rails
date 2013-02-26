require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator
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

  test "Assert files are properly created" do
    run_generator %w(ember)

    assert_file "#{ember_path}/views/ember_view.js"
    assert_file "#{ember_path}/templates/ember.handlebars"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]

    assert_file "#{custom_path}/views/ember_view.js"
    assert_file "#{custom_path}/templates/ember.handlebars"
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}"
  end

end
