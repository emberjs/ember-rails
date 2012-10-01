require 'test_helper'
require 'generators/ember/controller_generator'

class ControllerGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ControllerGenerator
  destination File.join(Rails.root, "tmp")

  setup :bootstrap
  teardown :cleanup

  test "Assert Generation of controller" do
    run_generator %w(frank)
    assert_file "app/assets/javascripts/controllers/frank_controller.js", 
      "Dummy.FrankController = Ember.Controller.extend({\n\n});\n"
  end

  test "Assert Generation of controller with coffeescript flag" do
    run_generator %w(the_tank --coffeescript)
    assert_file "app/assets/javascripts/controllers/the_tank_controller.js.coffee", 
      "Dummy.TheTankController = Ember.Controller.extend()\n"
  end

  test "Assertion Generation of array_controller" do
    run_generator %w(foo --array)
    assert_file "app/assets/javascripts/controllers/foo_controller.js", 
      "Dummy.FooController = Ember.ArrayController.extend({\n\n});\n"
  end

  test "Assertion Generation of array_controller with coffeescript flag" do
    run_generator %w(bar --array --coffeescript)
    assert_file "app/assets/javascripts/controllers/bar_controller.js.coffee", 
      "Dummy.BarController = Ember.ArrayController.extend()\n"
  end

  test "Assertion Generation of object_controller" do
    run_generator %w(dance --object)
    assert_file "app/assets/javascripts/controllers/dance_controller.js", 
      "Dummy.DanceController = Ember.ObjectController.extend({\n\n});\n"
  end

  test "Assertion Generation of object_controller with coffeescript flag" do
    run_generator %w(revolution --object --coffeescript)
    assert_file "app/assets/javascripts/controllers/revolution_controller.js.coffee", 
      "Dummy.RevolutionController = Ember.ObjectController.extend()\n"
  end

end
