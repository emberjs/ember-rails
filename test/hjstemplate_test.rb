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
    assert @response.body == "SC.TEMPLATES[\"templates/test\"] = Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) { helpers = helpers || Handlebars.helpers; var buffer = '', stack1, stack2, stack3, stack4, tmp1, self=this, functionType=\"function\", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression; stack1 = depth0; stack2 = \"test\"; stack3 = {}; stack4 = \"true\"; stack3['escaped'] = stack4; stack4 = helpers.bind || SC.get(depth0, \"bind\"); tmp1 = {}; tmp1.hash = stack3; tmp1.contexts = []; tmp1.contexts.push(stack1); tmp1.data = data; if(typeof stack4 === functionType) { stack1 = stack4.call(depth0, stack2, tmp1); } else if(stack4=== undef) { stack1 = helperMissing.call(depth0, \"bind\", stack2, tmp1); } else { stack1 = stack4; } data.buffer.push(escapeExpression(stack1) + \"\\n\"); return buffer; });\n"
  end

end
