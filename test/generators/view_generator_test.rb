require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::ViewGenerator

  destination File.join(Rails.root, "tmp", "generator_test_output")
  setup :prepare_destination

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", "generator_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    copy_directory "app/assets/javascripts"
    copy_directory "config"
  end


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

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{ember_path}/views/ember_view.js"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]
    assert_file "#{custom_path}/views/ember_view.js"
  end

  private

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end

end
