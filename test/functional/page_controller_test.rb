require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get install" do
    get :install
    assert_response :success
  end

  test "should get data_post" do
    get :data_post
    assert_response :success
  end

  test "should get data_get" do
    get :data_get
    assert_response :success
  end

end
