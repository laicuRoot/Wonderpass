require 'test_helper'

class StampsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stamps_show_url
    assert_response :success
  end

  test "should get edit" do
    get stamps_edit_url
    assert_response :success
  end

  test "should get update" do
    get stamps_update_url
    assert_response :success
  end

end
