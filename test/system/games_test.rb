require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "recieve the word is not in the grid" do
    visit new_url
    assert test: "New game"
    fill_in "word", with: "home"
  end
end
