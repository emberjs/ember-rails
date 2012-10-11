require 'test_helper'
require 'generators/ember/controller_generator'

class ControllerGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ControllerGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination




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
      assert_file "app/assets/javascripts/controllers/post/index_controller.js.#{engine}".sub('.js.js','.js'), /PostIndexController/
    end

  end

end

