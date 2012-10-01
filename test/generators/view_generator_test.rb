require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator
  destination File.join(Rails.root, "tmp")

  setup :bootstrap
  teardown :cleanup

  test "Assert Generation of view" do
    run_generator %w(fred)
    assert_file "app/assets/javascripts/views/fred_view.js", 
      "Dummy.FredView = Ember.View.extend({\n  templateName: 'fred'\n});\n"
  end

  test "Assert Generation of view with coffeescript flag" do
    run_generator %w(flinstone --coffeescript)
    assert_file "app/assets/javascripts/views/flinstone_view.js.coffee", 
      "Dummy.FlinstoneView = Ember.View.extend\n  templateName: 'flinstone'\n"
  end
end
