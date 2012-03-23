require 'test_helper'

class Admin::BiosControllerTest < ActionController::TestCase
  setup do
    @admin_bio = admin_bios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_bios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_bio" do
    assert_difference('Admin::Bio.count') do
      post :create, :admin_bio => @admin_bio.attributes
    end

    assert_redirected_to admin_bio_path(assigns(:admin_bio))
  end

  test "should show admin_bio" do
    get :show, :id => @admin_bio.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_bio.to_param
    assert_response :success
  end

  test "should update admin_bio" do
    put :update, :id => @admin_bio.to_param, :admin_bio => @admin_bio.attributes
    assert_redirected_to admin_bio_path(assigns(:admin_bio))
  end

  test "should destroy admin_bio" do
    assert_difference('Admin::Bio.count', -1) do
      delete :destroy, :id => @admin_bio.to_param
    end

    assert_redirected_to admin_bios_path
  end
end
