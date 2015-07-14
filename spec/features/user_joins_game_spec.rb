require 'rails_helper'

# Acceptance criteria
#
# [] User must be logged in
# [] User must be on game details page
# [] User must enter password
# [] User sees an error message if incorrect password is entered


feature "as a user i want to be able to join a game so that i can play the game" do
  scenario "user views details of game and joins game with password" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "View created games"
    click_link game.name
    click_button "Join game"
    
    expect(page).to have_content user.first_name
  end

  scenario "user enters incorrect password and sees an error message" do

  end

end
