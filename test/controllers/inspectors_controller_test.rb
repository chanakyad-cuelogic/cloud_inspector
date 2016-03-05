require 'test_helper'

class InspectorsControllerTest < ActionController::TestCase
  test "should get security" do
    get :security
    assert_response :success
  end

  test "should get cost" do
    get :cost
    assert_response :success
  end

end
