require 'test_helper'
require 'generators/ember/model_generator'

class ModelGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ModelGenerator
  destination File.join(Rails.root, "tmp")

  setup :bootstrap
  teardown :cleanup

  test "Assert Generation of model" do
    run_generator %w(victoria a1:binary a2:string a3:text a4:primary_key)
    assert_file "app/assets/javascripts/models/victoria.js", 
      "Dummy.Victoria = DS.Model.extend({\n  a1: DS.attr('string'),\n  a2: DS.attr('string'),\n  a3: DS.attr('string'),\n  a4: DS.attr('number')\n});"
  end

  test "Assert Generation of controller with coffeescript flag" do
    run_generator %w(secret a1:binary a2:string a3:text a4:primary_key --coffeescript)
    assert_file "app/assets/javascripts/models/secret.js.coffee", 
      "Dummy.Secret = DS.Model.extend\n  a1: DS.attr('string')\n  a2: DS.attr('string')\n  a3: DS.attr('string')\n  a4: DS.attr('number')\n"
  end
end


