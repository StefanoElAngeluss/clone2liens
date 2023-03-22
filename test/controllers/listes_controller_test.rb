require "test_helper"

class ListesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liste = listes(:one)
  end

  test "should get index" do
    get listes_url
    assert_response :success
  end

  test "should get new" do
    get new_liste_url
    assert_response :success
  end

  test "should create liste" do
    assert_difference("Liste.count") do
      post listes_url, params: { liste: { completed: @liste.completed, contenu: @liste.contenu, titre: @liste.titre, user_id: @liste.user_id } }
    end

    assert_redirected_to liste_url(Liste.last)
  end

  test "should show liste" do
    get liste_url(@liste)
    assert_response :success
  end

  test "should get edit" do
    get edit_liste_url(@liste)
    assert_response :success
  end

  test "should update liste" do
    patch liste_url(@liste), params: { liste: { completed: @liste.completed, contenu: @liste.contenu, titre: @liste.titre, user_id: @liste.user_id } }
    assert_redirected_to liste_url(@liste)
  end

  test "should destroy liste" do
    assert_difference("Liste.count", -1) do
      delete liste_url(@liste)
    end

    assert_redirected_to listes_url
  end
end
