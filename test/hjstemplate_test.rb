require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "page header should include link to asset" do
    get :index
    assert_response :success
    assert_select 'head script[src^="/assets/templates/test"]', true, @response.body
  end
end

class HjsTemplateTest < IntegrationTest

  test "asset pipeline should serve template" do
    get "/assets/templates/test.js"
    assert_response :success
    assert_match /Ember\.TEMPLATES\["test"\] = Ember\.(?:Handlebars|HTMLBars)\.template\(/m, @response.body
  end

  test "asset pipeline should serve bundled application.js" do
    get "/assets/application.js"
    assert_response :success
    assert_match /Ember\.TEMPLATES\["test"\] = Ember\.(?:Handlebars|HTMLBars)\.template\(/m, @response.body
  end

  test "should unbind mustache templates" do
    get "/assets/templates/hairy.mustache"
    assert_response :success
    assert_match /Ember\.TEMPLATES\["hairy(\.mustache)?"\] = Ember\.(?:Handlebars|HTMLBars)\.template\(/m, @response.body
    assert_match /function .*unbound|"name":"unbound"/m, @response.body
  end

  test "ensure new lines inside the anon function are persisted" do
    get "/assets/templates/new_lines.js"
    assert_response :success
    assert @response.body =~ /; data = data || {};\n|"data":data/, @response.body.inspect
  end

end
