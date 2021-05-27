require 'test_helper'

class StampbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stampbooks_index_url
    assert_response :success
  end

  test "should get show" do
    get stampbooks_show_url
    assert_response :success
  end

end
