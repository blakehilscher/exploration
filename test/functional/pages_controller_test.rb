require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get coming_soon" do
    get :coming_soon
    assert_response :success
  end

end
