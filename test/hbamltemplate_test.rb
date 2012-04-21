require 'test_helper'

class HbamlTemplateTest < ActionController::IntegrationTest

  test "asset pipeline should serve template" do
    get "/assets/templates/test_hbaml.js"
    assert_response :success
    assert @response.body == "Ember.TEMPLATES[\"templates/test_hbaml\"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {\nhelpers = helpers || Ember.Handlebars.helpers;\n  var buffer = '', stack1, stack2, stack3, stack4, tmp1, self=this, functionType=\"function\", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;\n\n\n  data.buffer.push(\"<h1>\");\n  stack1 = depth0;\n  stack2 = \"test\";\n  stack3 = {};\n  stack4 = \"true\";\n  stack3['escaped'] = stack4;\n  stack4 = helpers._triageMustache || depth0._triageMustache;\n  tmp1 = {};\n  tmp1.hash = stack3;\n  tmp1.contexts = [];\n  tmp1.contexts.push(stack1);\n  tmp1.data = data;\n  if(typeof stack4 === functionType) { stack1 = stack4.call(depth0, stack2, tmp1); }\n  else if(stack4=== undef) { stack1 = helperMissing.call(depth0, \"_triageMustache\", stack2, tmp1); }\n  else { stack1 = stack4; }\n  data.buffer.push(escapeExpression(stack1) + \"</h1>\\n\");\n  return buffer;\n});\n"
  end

end
