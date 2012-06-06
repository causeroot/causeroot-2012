require 'test_helper'

class PopulateRulesControllerTest < ActionController::TestCase
  setup do
    @populate_rule = populate_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:populate_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create populate_rule" do
    assert_difference('PopulateRule.count') do
      post :create, populate_rule: {  }
    end

    assert_redirected_to populate_rule_path(assigns(:populate_rule))
  end

  test "should show populate_rule" do
    get :show, id: @populate_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @populate_rule
    assert_response :success
  end

  test "should update populate_rule" do
    put :update, id: @populate_rule, populate_rule: {  }
    assert_redirected_to populate_rule_path(assigns(:populate_rule))
  end

  test "should destroy populate_rule" do
    assert_difference('PopulateRule.count', -1) do
      delete :destroy, id: @populate_rule
    end

    assert_redirected_to populate_rules_path
  end
end
