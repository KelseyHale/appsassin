require 'rails_helper'

# Acceptance criteria
#
# [√] User must be logged in
# [√] User must be on the player dashboard
# [√] Link for elimination only available when target still active
# [√] User recieves a confirmation message to eliminate player
# [√] User clicks confirmation message and player is marked as eliminated
# on the player's dashboard and in the game show page

feature "As a user
I want to mark my target as eliminated
So other players know who is out of the game" do
  scenario "user clicks on their target to mark that target as eliminated" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    game = FactoryGirl.create(:game, user: user)
    player = Player.create(user: user, game: game)
    Player.create(user: user2, game: game)
    Target.create(user: user, game: game)
    target = Target.create(user: user2, game: game)
    round = Round.create(name: 1, game: game)
    RoundAssignment.create!(
      round_id: round.id,
      player_id: player.id,
      target_id: target.id
    )

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content target.user.first_name
    click_link "Target Eliminated?"

    expect(page).to have_content "Eliminated."

    visit game_path(game)
    expect(page).to have_content "PLAYER ELIMINATED"

    # expect(page).to have_content "Your current targets:"
    # expect(page).to have_content target.user.first_name
  end
end
