require 'test_helper'

class DrilldownRulesControllerTest < ActionController::TestCase
  setup do
    @drilldown_rule = drilldown_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drilldown_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drilldown_rule" do
    assert_difference('DrilldownRule.count') do
      post :create, drilldown_rule: {  }
    end

    assert_redirected_to drilldown_rule_path(assigns(:drilldown_rule))
  end

  test "should show drilldown_rule" do
    get :show, id: @drilldown_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drilldown_rule
    assert_response :success
  end

  test "should update drilldown_rule" do
    put :update, id: @drilldown_rule, drilldown_rule: {  }
    assert_redirected_to drilldown_rule_path(assigns(:drilldown_rule))
  end

  test "should destroy drilldown_rule" do
    assert_difference('DrilldownRule.count', -1) do
      delete :destroy, id: @drilldown_rule
    end

    assert_redirected_to drilldown_rules_path
  end
end
