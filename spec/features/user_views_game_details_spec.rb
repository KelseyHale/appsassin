require 'rails_helper'

# Acceptance criteria
#
# [√] User must be logged in
# [√] User must be on show page
# [√] User sees list of all players in game
# [√] User sees names of people in the game
# [] User sees profile picture of people in the game

feature "as a user
i want to see the details of the game
so that I can see who has joined" do
  scenario "authenticated user visits show page
  and sees list of players and rules" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    player = FactoryGirl.create(:player, game: game)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit '/'
    click_on "View created games"
    click_on game.name

    expect(page).to have_content game.name
    expect(page).to have_content "Members of this game"
    expect(page).to have_content player.user.first_name
    # page.should have_css("img[src$='#{imagename}']")
  end

  scenario "an unauthenticated user tries to visit show page
  and gets an error" do
    game = FactoryGirl.create(:game)

    visit games_path
    click_on game.name
    expect(page).to have_content "You need to sign in or sign up"
  end
end
