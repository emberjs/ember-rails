require 'test_helper'
require 'generators/ember/template_generator'

class TemplateGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::TemplateGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination


  %w(js coffee).each do |engine|

    test "template with #{engine} as current engine" do
      run_generator ["post"]
      assert_file "app/assets/javascripts/templates/post.handlebars"
    end
  end

end

