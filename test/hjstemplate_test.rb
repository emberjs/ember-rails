require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "page header should include link to asset" do
    get :index
    assert_response :success
    assert_select 'head script[type="text/javascript"][src="/assets/templates/test.js"]', true
  end

end

class HjsTemplateTest < ActionController::IntegrationTest

  test "asset pipeline should serve template" do
    get "/assets/templates/test.js"
    assert_response :success
    assert @response.body == "SC.TEMPLATES[\"templates/test\"] = function (b,c,d){try{c=c||{};var e=[Handlebars,b,c.helpers,c.partials,c.data],f=Array.prototype.slice.call(arguments,2);e=e.concat(f);return a.render.apply(a,e)}catch(g){throw g}};\n"
  end

end
