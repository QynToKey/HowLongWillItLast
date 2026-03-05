require "test_helper"

class LearningThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get learning_themes_new_url
    assert_response :success
  end

  test "should get create" do
    get learning_themes_create_url
    assert_response :success
  end

  test "should get index" do
    get learning_themes_index_url
    assert_response :success
  end

  test "should get edit" do
    get learning_themes_edit_url
    assert_response :success
  end

  test "should get update" do
    get learning_themes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get learning_themes_destroy_url
    assert_response :success
  end
end
