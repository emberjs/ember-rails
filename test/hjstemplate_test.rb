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
    assert @response.body == "SC.TEMPLATES[\"templates/test\"] = Handlebars.template(function (context, options, $depth) { try { options = options || {}; var args = [Handlebars, context, options.helpers, options.partials, options.data]; var depth = Array.prototype.slice.call(arguments, 2); args = args.concat(depth); return container.render.apply(container, args); } catch(e) { throw e; } });\n"
  end

end
