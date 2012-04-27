require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase
  setup do
    @challenge = challenges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge" do
    assert_difference('Challenge.count') do
      post :create, challenge: { award: @challenge.award, deadline: @challenge.deadline, description: @challenge.description, discussion_board: @challenge.discussion_board, image: @challenge.image, post_date: @challenge.post_date, title: @challenge.title, url_reference: @challenge.url_reference }
    end

    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should show challenge" do
    get :show, id: @challenge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @challenge
    assert_response :success
  end

  test "should update challenge" do
    put :update, id: @challenge, challenge: { award: @challenge.award, deadline: @challenge.deadline, description: @challenge.description, discussion_board: @challenge.discussion_board, image: @challenge.image, post_date: @challenge.post_date, title: @challenge.title, url_reference: @challenge.url_reference }
    assert_redirected_to challenge_path(assigns(:challenge))
  end

  test "should destroy challenge" do
    assert_difference('Challenge.count', -1) do
      delete :destroy, id: @challenge
    end

    assert_redirected_to challenges_path
  end
end
