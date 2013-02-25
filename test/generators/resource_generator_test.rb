require 'test_helper'
require 'generators/ember/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ResourceGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination


  %w(js coffee).each do |engine|

    test "create view with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post_view.js.#{engine}".sub('.js.js','.js'), /templateName: 'post'/
    end

    test "create template with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/templates/post.handlebars"
    end

    test "create controller with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/controllers/post_controller.js.#{engine}".sub('.js.js','.js')
    end

    test "create route with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/routes/post_route.js.#{engine}".sub('.js.js','.js')
    end

    test "skip route with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}", "--skip-route"]
      assert_no_file "app/assets/javascripts/routes/post_route.js.#{engine}".sub('.js.js','.js')
    end


  end
end

