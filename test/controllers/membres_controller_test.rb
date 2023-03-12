require "test_helper"

class MembresControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get membres_dashboard_url
    assert_response :success
  end
end
