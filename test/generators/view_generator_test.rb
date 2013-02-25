require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination


  %w(js coffee).each do |engine|

    test "create view with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post_view.js.#{engine}".sub('.js.js','.js'), /templateName: 'post'/
      assert_no_file "app/assets/javascripts/templates/post.handlebars"
    end

    test "create view and template with #{engine} engine" do
      run_generator ["post", "--javascript-engine=#{engine}", "--with-template"]
      assert_file "app/assets/javascripts/views/post_view.js.#{engine}".sub('.js.js','.js')
      assert_file "app/assets/javascripts/templates/post.handlebars"
    end

    test "create namespaced view with #{engine} engine" do
      run_generator ["post/index", "--javascript-engine=#{engine}"]
      assert_file "app/assets/javascripts/views/post/index_view.js.#{engine}".sub('.js.js','.js') , /PostIndexView/
    end

  end
end

