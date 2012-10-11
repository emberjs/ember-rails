require 'test_helper'
require 'generators/ember/model_generator'

class ModelGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ModelGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination

  %w(js coffee).each do |engine|


    test "create model with #{engine} engine" do
      run_generator ["post", "title:string", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/models/post.js.#{engine}".sub('.js.js','.js')
    end

    test "create namespaced model with #{engine} engine" do
      run_generator ["post/doineedthis", "title:string", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/models/post/doineedthis.js.#{engine}".sub('.js.js','.js'), /PostDoineedthis/
    end
  end

  test "leave parentheses when create model w/o attributes (with coffee engine)" do
    run_generator ["post", "--javascript-engine=coffee"]
    assert_file "app/assets/javascripts/models/post.js.coffee", /DS.Model.extend\(\)/
  end
end

