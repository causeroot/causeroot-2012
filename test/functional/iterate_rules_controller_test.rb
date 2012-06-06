require 'test_helper'

class IterateRulesControllerTest < ActionController::TestCase
  setup do
    @iterate_rule = iterate_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:iterate_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iterate_rule" do
    assert_difference('IterateRule.count') do
      post :create, iterate_rule: {  }
    end

    assert_redirected_to iterate_rule_path(assigns(:iterate_rule))
  end

  test "should show iterate_rule" do
    get :show, id: @iterate_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @iterate_rule
    assert_response :success
  end

  test "should update iterate_rule" do
    put :update, id: @iterate_rule, iterate_rule: {  }
    assert_redirected_to iterate_rule_path(assigns(:iterate_rule))
  end

  test "should destroy iterate_rule" do
    assert_difference('IterateRule.count', -1) do
      delete :destroy, id: @iterate_rule
    end

    assert_redirected_to iterate_rules_path
  end
end
