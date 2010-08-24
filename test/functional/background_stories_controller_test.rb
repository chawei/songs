require 'test_helper'

class BackgroundStoriesControllerTest < ActionController::TestCase
  setup do
    @background_story = background_stories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:background_stories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create background_story" do
    assert_difference('BackgroundStory.count') do
      post :create, :background_story => @background_story.attributes
    end

    assert_redirected_to background_story_path(assigns(:background_story))
  end

  test "should show background_story" do
    get :show, :id => @background_story.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @background_story.to_param
    assert_response :success
  end

  test "should update background_story" do
    put :update, :id => @background_story.to_param, :background_story => @background_story.attributes
    assert_redirected_to background_story_path(assigns(:background_story))
  end

  test "should destroy background_story" do
    assert_difference('BackgroundStory.count', -1) do
      delete :destroy, :id => @background_story.to_param
    end

    assert_redirected_to background_stories_path
  end
end
