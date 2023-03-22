require "application_system_test_case"

class ListesTest < ApplicationSystemTestCase
  setup do
    @liste = listes(:one)
  end

  test "visiting the index" do
    visit listes_url
    assert_selector "h1", text: "Listes"
  end

  test "should create liste" do
    visit listes_url
    click_on "New liste"

    check "Completed" if @liste.completed
    fill_in "Contenu", with: @liste.contenu
    fill_in "Titre", with: @liste.titre
    fill_in "User", with: @liste.user_id
    click_on "Create Liste"

    assert_text "Liste was successfully created"
    click_on "Back"
  end

  test "should update Liste" do
    visit liste_url(@liste)
    click_on "Edit this liste", match: :first

    check "Completed" if @liste.completed
    fill_in "Contenu", with: @liste.contenu
    fill_in "Titre", with: @liste.titre
    fill_in "User", with: @liste.user_id
    click_on "Update Liste"

    assert_text "Liste was successfully updated"
    click_on "Back"
  end

  test "should destroy Liste" do
    visit liste_url(@liste)
    click_on "Destroy this liste", match: :first

    assert_text "Liste was successfully destroyed"
  end
end
