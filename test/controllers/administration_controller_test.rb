require "test_helper"

class AdministrationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administration_index_url
    assert_response :success
  end

  test "should get articles" do
    get administration_articles_url
    assert_response :success
  end

  test "should get commantaires" do
    get administration_commantaires_url
    assert_response :success
  end

  test "should get users" do
    get administration_users_url
    assert_response :success
  end

  test "should get show_article" do
    get administration_show_article_url
    assert_response :success
  end
end
