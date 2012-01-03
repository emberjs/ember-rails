require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "page header should include link to asset" do
    get :index
    assert_response :success
    assert_select 'head script[type="text/javascript"][src="/assets/templates/test.js"]', true, @response.body
  end

end

class HjsTemplateTest < ActionController::IntegrationTest

  test "asset pipeline should serve template" do
    get "/assets/templates/test.js"
    assert_response :success
    assert @response.body == "Ember.TEMPLATES[\"templates/test\"] = Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {\nhelpers = helpers || Ember.Handlebars.helpers;\n  var buffer = '', stack1, stack2, stack3, stack4, tmp1, self=this, functionType=\"function\", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;\n\n\n  stack1 = depth0;\n  stack2 = \"test\";\n  stack3 = {};\n  stack4 = \"true\";\n  stack3['escaped'] = stack4;\n  stack4 = helpers.bind || depth0.bind;\n  tmp1 = {};\n  tmp1.hash = stack3;\n  tmp1.contexts = [];\n  tmp1.contexts.push(stack1);\n  tmp1.data = data;\n  if(typeof stack4 === functionType) { stack1 = stack4.call(depth0, stack2, tmp1); }\n  else if(stack4=== undef) { stack1 = helperMissing.call(depth0, \"bind\", stack2, tmp1); }\n  else { stack1 = stack4; }\n  data.buffer.push(escapeExpression(stack1) + \"\\n\");\n  return buffer;\n});\n", @response.body.inspect
  end

  test "ensure new lines inside the anon function are persisted" do
    get "/assets/templates/new_lines.js"
    assert_response :success
    assert @response.body.include?("helpers['if'];\n"), @response.body.inspect
  end

end
