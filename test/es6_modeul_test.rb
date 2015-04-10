require 'test_helper'

class Es6ModuleTest < IntegrationTest

  %w(models controllers views routes components helpers mixins serializers adapters).each do |type|
    test "#{type} type module should be registerd with module_prefix" do
      get "/assets/#{type}/user.js"
      assert_response :success
      assert_match %r{define\('ember-app/#{type}/user'}, @response.body
    end
  end

  %w(store router).each do |type|
    test "#{type} type module should be registerd with module_prefix" do
      get "/assets/#{type}.js"
      assert_response :success
      assert_match %r{define\('ember-app/#{type}'}, @response.body
    end
  end

  test "non specofied with emebr module should be registerd without module_prefix" do
    get "/assets/non-ember.js"
    assert_response :success
    assert_match %r{define\('non-ember'}, @response.body
  end

end
