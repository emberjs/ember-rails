require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination


  %w(js coffee).each do |engine|

    test "create view with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post_view.js.#{engine}".sub('.js.js','.js')
    end

    test "create namespaced view with #{engine} engine" do
      run_generator ["post/index", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post/index_view.js.#{engine}".sub('.js.js','.js') , /PostIndexView/
      assert_file "app/assets/javascripts/views/post/index_view.js.#{engine}".sub('.js.js','.js') , /templateName: 'post\/index'/
    end

    test "skip-controller option for #{engine} engine" do
      run_generator ["post","--skip-controller", "--javascript-engine=#{engine}"]
      assert_no_file "app/assets/javascripts/controllers/post_controller.js.#{engine}".sub('.js.js','.js')
    end

  end

  test 'views_handlebars' do
    run_generator ["post"]
    assert_file "app/assets/javascripts/templates/post.handlebars"
  end

  test 'namsepaced views_handlebars' do
    run_generator ["post/index"]
    assert_file "app/assets/javascripts/templates/post/index.handlebars"
  end


end

