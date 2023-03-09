require "test_helper"

class RechercheControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recherche_index_url
    assert_response :success
  end
end
