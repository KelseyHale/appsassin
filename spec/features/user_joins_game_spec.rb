require 'rails_helper'
require 'spec_helper'

# Acceptance criteria
#
# [√] User must be logged in
# [√] User must be on game details page
# [√] User must enter password if the game creator used a password
# [√] If there is no password the user gets added to the game on click
# [√] User sees an error message if incorrect password is entered
# [√] User that has already joined the game sees a link to leave the game

feature "as a user
i want to be able to join a game
so that i can play the game" do
  scenario "user views details of game and joins game with password" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "View created games"
    click_link game.name
    click_link "Join game"
    fill_in "password", with: game.password
    click_button "Submit"

    expect(page).to have_content user.first_name
    expect(page).to have_link "Leave game"
    expect(page).to_not have_link "Join game"
  end

  scenario "user enters incorrect password and sees an error message" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "View created games"
    click_link game.name
    click_link "Join game"
    fill_in "password", with: "Incorrect"
    click_button "Submit"
  end

  scenario "unauthenticated user tries to join game and sees error message" do
    game = FactoryGirl.create(:game)
    visit new_game_player_path(game)
    expect(page).to have_content "You need to sign in or sign up"
  end
end
