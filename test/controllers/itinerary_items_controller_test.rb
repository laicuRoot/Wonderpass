require 'test_helper'

class ItineraryItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get itinerary_items_new_url
    assert_response :success
  end

  test "should get create" do
    get itinerary_items_create_url
    assert_response :success
  end

  test "should get destroy" do
    get itinerary_items_destroy_url
    assert_response :success
  end

end
