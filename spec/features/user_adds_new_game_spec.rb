require 'rails_helper'
require 'spec_helper'

# Acceptance Criteria
#
# [√] User must be signed in
# [√] must be on new game page
# [√] new game is added to the index of active games
# [√] user is redirected to the new game's show page

feature "as a user
i want to create a new game
so that friends can join my game" do
  scenario 'an authenticated user adds a game
  and is redirected to the new games show page' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit '/'
    click_on "Create new game"
    fill_in "Name", with: "The Killing Game"
    fill_in "Password", with: "secretstuff"
    fill_in "Password confirmation", with: "secretstuff"
    click_button "Submit"

    expect(page).to have_content "The Killing Game has been
    successfully created."
    expect(page).to have_content "The Killing Game"

    visit games_path
    expect(page).to have_content "The Killing Game"
  end

  scenario 'an unauthenticated user tries to add a game
  and sees an error message' do
    FactoryGirl.create(:user)
    visit '/'
    click_link "Create new game"

    expect(page).to have_content "You need to sign in or sign up
    before continuing."
    expect(page).to have_content "Log in"

  end
end
